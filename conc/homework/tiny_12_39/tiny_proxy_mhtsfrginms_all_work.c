/* $begin tinymain */
/*
 * tiny.c - A simple, iterative HTTP/1.0 Web server that uses the
 *     GET method to serve static and dynamic content.
 */
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#include "csapp.h"
// #include "homework/tiny_12_38/csapp.h"
#define ALWAYS_PREDICT_CONTINUE 0
#define READ_FILE_BLOCK 0  // not use when file big
#define READ_FILE_MAP \
  0  // this is not what proxy should do, and maybe not comform to browser
     // transmission protocal
#define READ_FILE_LINE 1
#define RESPONSE_HEADER 0
#define LOG_MUT 1
#define BIG_FILE_SIZE 20000

void doit(int fd);
void read_requesthdrs(rio_t *rp);
int parse_uri(char *uri, char *filename, char *cgiargs);
void serve_static(int fd, char *filename, int filesize);
void get_filetype(char *filename, char *filetype);
void serve_dynamic(int fd, char *filename, char *cgiargs);
void clienterror(int fd, char *cause, char *errnum, char *shortmsg,
                 char *longmsg);
void init_mutex(sem_t *log_mutex);

sem_t log_mutex;
int log_fd, filter_fd, proxy_to_server;
char **filter_str_list;
#define FILTER_SIZE 50
#define ALL_MODE S_IROTH | S_IWOTH | S_IRGRP | S_IWGRP | S_IRUSR | S_IWUSR
#define CLOSE_IN_MAIN 0

/*
reentrant
*/
void init_mutex(sem_t *log_mutex) { Sem_init(log_mutex, 0, 1); }

void read_filter(rio_t *rio_filter, char **filter_str_list, int *filter_fd) {
  char buf[MAXLINE + 1];
  int i = 0;
  while ((Rio_readlineb(rio_filter, buf, MAXLINE + 1)) > 0) {
    // printf("%s",buf);
    strcpy(filter_str_list[i], buf);
    i++;
    if (i == FILTER_SIZE) {
      exit(1);
    }
  }
  if (i == 0) {
    exit(1);
  }
  Close(*filter_fd);
}

int main(int argc, char **argv) {
  int listenfd, connfd, max_line_with_newline = MAXLINE + 1;
  char hostname[MAXLINE], port[MAXLINE];
  socklen_t clientlen;
  struct sockaddr_storage clientaddr;
  rio_t rio_filter;
  struct stat stat_log;

  filter_str_list = Malloc(FILTER_SIZE * sizeof(char *));
  // printf("filter_str_list: %p\n", filter_str_list);

  for (int i = 0; i < FILTER_SIZE; i++) {
    filter_str_list[i] = Calloc(max_line_with_newline, sizeof(char));
    // printf("filter_str_list %d: %p\n", i, filter_str_list[i]);
  }

  /* Check command line args */
  if (argc != 3) {
    fprintf(stderr, "usage: %s <proxy listening port> <proxy client port>\n",
            argv[0]);
    exit(1);
  }
  init_mutex(&log_mutex);
  if ((log_fd = open("./log.txt", O_APPEND | O_CREAT | O_WRONLY, ALL_MODE)) ==
      -1) {
    stat("log.txt", &stat_log);
    if (!(stat_log.st_mode & S_IRUSR)) {
      unix_error("unreadable");
    }
    unix_error("log fault: ");
  }
  if ((filter_fd = open("./filter.txt", O_APPEND, ALL_MODE)) == -1) {
    unix_error("filter fault: ");
  }
  Rio_readinitb(&rio_filter, filter_fd);
  read_filter(&rio_filter, filter_str_list, &filter_fd);

  // printf("after read_filter\n");
  // for (int i = 0; i < FILTER_SIZE; i++) {
  //   printf("filter_str_list %d: %p\n", i, filter_str_list[i]);
  // }

  listenfd = Open_listenfd(argv[1]);

  clientlen = sizeof(clientaddr);
  while (1) {
    proxy_to_server = Open_clientfd("localhost", argv[2]);
    printf("open proxy client: %d\n", proxy_to_server);
    connfd = Accept(listenfd, (SA *)&clientaddr,
                    &clientlen);  // line:netp:tiny:accept
    Getnameinfo((SA *)&clientaddr, clientlen, hostname, MAXLINE, port, MAXLINE,
                0);
    printf("Accepted connection from (%s, %s)\n", hostname, port);
    doit(connfd);   // line:netp:tiny:doit
    Close(connfd);  // line:netp:tiny:close
    Close(proxy_to_server);
    printf("close %d with port %s\n", connfd, port);
  }
#if CLOSE_IN_MAIN
  Close(log_fd);
#endif
}
/* $end tinymain */

void read_requesthdrs_write(rio_t *rp, int *fd_ptr) {
  char buf[MAXLINE];
  int fd = *fd_ptr;
  Rio_readlineb(rp, buf, MAXLINE);
  Rio_writen(fd, buf, strlen(buf));
  printf("header:%s\n", buf);
  while (strcmp(buf, "\r\n")) {  // line:netp:readhdrs:checkterm
    Sio_puts("in loop");
    Rio_readlineb(rp, buf, MAXLINE);
    Rio_writen(fd, buf, strlen(buf));
    printf("header loop:%s\n", buf);
  }
  Sio_puts("out while!");
  return;
}

/*
 * doit - handle one HTTP request/response transaction
 */
/* $begin doit */
void doit(int client_fd) {
  int i;
  long rc;
  char buf[MAXLINE], method[MAXLINE], uri[MAXLINE], version[MAXLINE];
  char filename[MAXLINE], cgiargs[MAXLINE];
#if READ_FILE_MAP
  struct stat sbuf;
  char filetype[MAXLINE];
#endif
#if READ_FILE_BLOCK
  char *end = "\r\n";
#endif
#if LOG_MUT
  char *tmp;
#endif
  rio_t rio_listen, rio_client_to_server;

#if DO_IT_PRINTF
  printf("run doit\n");
#endif
  /* Read request line and headers */
  Rio_readinitb(&rio_listen, client_fd);
  Rio_readinitb(&rio_client_to_server, proxy_to_server);

  if (!Rio_readlineb(&rio_listen, buf, MAXLINE)) {
    return;
  }
#if DO_IT_PRINTF
  printf("get buf: %s\n", buf);
#endif
  sscanf(buf, "%s %s %s", method, uri, version);
  parse_uri(uri, filename, cgiargs);
#if DO_IT_PRINTF
  printf("filename: %s\n", filename);
#endif
  if (strcasecmp(method, "GET")) {  // line:netp:doit:beginrequesterr
    clienterror(client_fd, method, "501", "Not Implemented",
                "Tiny does not implement this method");
    return;
  }  // line:netp:doit:endrequesterr

#if LOG_MUT
  P(&log_mutex);
  tmp = strcat(uri, "\n");
  // printf("tmp ptr:%p\n", tmp);
  write(log_fd, tmp, strlen(tmp));
  fsync(log_fd);
  // printf("write to log %s\n", tmp);
  V(&log_mutex);
  // printf("begin check filter_str_list\n");
#endif

  for (i = 0; *filter_str_list[i] != 0; i++) {
#if ALWAYS_PREDICT_CONTINUE
    if (strcmp(uri, filter_str_list[i])) {
      continue;
    } else {
      return;
    }
#else
    // printf("check filter\n");
    if (!strcmp(uri, filter_str_list[i])) {
      // printf("in filter list.\n");
      return;
    }
#endif
  }

#if READ_FILE_MAP
  /* Send response headers to client */
  get_filetype(filename, filetype);
  char *image_str = "image";
  /*
  ignore '\0'
  */
  int is_image = !strncmp(filetype, image_str, sizeof("image") - 1);
  printf("filetype: %s image_str: %s substr: %d\n", filetype, image_str,
         is_image);
#endif

  // #if READ_FILE_MAP
  //   if (!is_image) {
  // #endif
  printf("write to server: %s\n", buf);
  Rio_writen(proxy_to_server, buf, strlen(buf));
  // printf("to run read_requesthdrs_write\n");
  read_requesthdrs_write(&rio_listen,
                         &proxy_to_server);  // line:netp:doit:readrequesthdrs
  Sio_puts("exit read_requesthdrs_write\n");
  // #if READ_FILE_MAP
  //   }
  // #endif

#if READ_FILE_LINE
  long int len;
  while ((rc = Rio_readlineb(&rio_client_to_server, buf, MAXLINE)) > 0) {
    len = strlen(buf);
    if (len != rc) {
      printf("write buf loop: %ld not equal to %ld\n", rc, len);
    }

    // #if READ_FILE_BLOCK
    //     if (!strcmp(end, buf)) {
    //       printf("get header\n");
    //       break;
    //     }
    // #endif
    // if (rc != strlen(buf)) {
    //   fprintf(stderr, "len error %d %ld\n", rc, strlen(buf));
    //   exit(1);
    // }
    Rio_writen(client_fd, buf, rc);
  }
  return;
#endif

#if READ_FILE_BLOCK
  /*
  this is not safe if rc is too big.
  */
  char *file_buf = Malloc(BIG_FILE_SIZE);
  printf("read response header and file\n");
  /*
  read until BIG_FILE_SIZE or client close transmission.
  */
  rc = Rio_readnb(&rio_client_to_server, file_buf, BIG_FILE_SIZE);
  printf("read response header and file end\n");
  Rio_writen(client_fd, file_buf, rc);
  printf("write file_buf:\n %s len: %ld\n", file_buf, rc);
  // Rio_writen(fd, &null_char, strlen(&null_char));
  printf("write file end\n");
#endif

#if READ_FILE_MAP
  if (is_image) {
    if (stat(filename, &sbuf) < 0) {  // line:netp:doit:beginnotfound
      fprintf(stderr, "error: %s", strerror(errno));
      clienterror(client_fd, filename, "404", "Not found",
                  "Tiny couldn't find this file");
      return;
    }
#if RESPONSE_HEADER
    serve_static(client_fd, filename, sbuf.st_size);
#else
    /*
    both 0 and ALL_MODE is right,sometimes weird says no file
    */
    int srcfd = Open(filename, O_RDONLY,
                     ALL_MODE);  // line:netp:servestatic:open

    int filesize = sbuf.st_size;
    char *srcp = Mmap(0, filesize, PROT_READ, MAP_PRIVATE, srcfd,
                      0);  // line:netp:servestatic:mmap
    printf("get file contents:\n%s\n", srcp);
    Close(srcfd);  // line:netp:servestatic:close
    printf("write %s, size %d\n", filename, filesize);
    Rio_writen(client_fd, srcp, filesize);
    Munmap(srcp, filesize);  // line:netp:servestatic:munmap
#endif
    return;
  }
  while ((Rio_readlineb(&rio_client_to_server, buf, MAXLINE)) > 0) {
    printf("write buf loop: %s", buf);
    Rio_writen(client_fd, buf, strlen(buf));
  }
#endif
}
/* $end doit */

/*
 * read_requesthdrs - read HTTP request headers
 */
/* $begin read_requesthdrs */
void read_requesthdrs(rio_t *rp) {
  char buf[MAXLINE];

  Rio_readlineb(rp, buf, MAXLINE);
  printf("%s", buf);
  while (strcmp(buf, "\r\n")) {  // line:netp:readhdrs:checkterm
    Rio_readlineb(rp, buf, MAXLINE);
    printf("%s", buf);
  }
  return;
}
/* $end read_requesthdrs */

/*
 * parse_uri - parse URI into filename and CGI args
 *             return 0 if dynamic content, 1 if static
 */
/* $begin parse_uri */
int parse_uri(char *uri, char *filename, char *cgiargs) {
  char *ptr;

  if (!strstr(uri, "cgi-bin")) {
    /* Static content */              // line:netp:parseuri:isstatic
    strcpy(cgiargs, "");              // line:netp:parseuri:clearcgi
    strcpy(filename, ".");            // line:netp:parseuri:beginconvert1
    strcat(filename, uri);            // line:netp:parseuri:endconvert1
    if (uri[strlen(uri) - 1] == '/')  // line:netp:parseuri:slashcheck
      strcat(filename, "home.html");  // line:netp:parseuri:appenddefault
    return 1;
  } else { /* Dynamic content */  // line:netp:parseuri:isdynamic
    ptr = index(uri, '?');        // line:netp:parseuri:beginextract
    if (ptr) {
      strcpy(cgiargs, ptr + 1);
      *ptr = '\0';
    } else
      strcpy(cgiargs, "");  // line:netp:parseuri:endextract
    strcpy(filename, ".");  // line:netp:parseuri:beginconvert2
    strcat(filename, uri);  // line:netp:parseuri:endconvert2
    return 0;
  }
}
/* $end parse_uri */

/*
 * serve_static - copy a file back to the client
 */
/* $begin serve_static */
void serve_static(int fd, char *filename, int filesize) {
  int srcfd;
  char *srcp, filetype[MAXLINE], buf[MAXBUF];

  /* Send response headers to client */
  get_filetype(filename, filetype);     // line:netp:servestatic:getfiletype
  sprintf(buf, "HTTP/1.0 200 OK\r\n");  // line:netp:servestatic:beginserve
  sprintf(buf, "%sServer: Tiny Web Server\r\n", buf);
  sprintf(buf, "%sConnection: close\r\n", buf);
  sprintf(buf, "%sContent-length: %d\r\n", buf, filesize);
  sprintf(buf, "%sContent-type: %s\r\n\r\n", buf, filetype);
  Rio_writen(fd, buf, strlen(buf));  // line:netp:servestatic:endserve
  printf("Response headers:\n");
  printf("%s", buf);

  /* Send response body to client */
  srcfd = Open(filename, O_RDONLY, ALL_MODE);  // line:netp:servestatic:open
  srcp = Mmap(0, filesize, PROT_READ, MAP_PRIVATE, srcfd,
              0);                  // line:netp:servestatic:mmap
  Close(srcfd);                    // line:netp:servestatic:close
  Rio_writen(fd, srcp, filesize);  // line:netp:servestatic:write
  Munmap(srcp, filesize);          // line:netp:servestatic:munmap
}

/*
 * get_filetype - derive file type from file name
 */
void get_filetype(char *filename, char *filetype) {
  if (strstr(filename, ".html"))
    strcpy(filetype, "text/html");
  else if (strstr(filename, ".gif"))
    strcpy(filetype, "image/gif");
  else if (strstr(filename, ".png"))
    strcpy(filetype, "image/png");
  else if (strstr(filename, ".jpg"))
    strcpy(filetype, "image/jpeg");
  else
    strcpy(filetype, "text/plain");
}
/* $end serve_static */

/*
 * serve_dynamic - run a CGI program on behalf of the client
 */
/* $begin serve_dynamic */
void serve_dynamic(int fd, char *filename, char *cgiargs) {
  char buf[MAXLINE], *emptylist[] = {NULL};

  /* Return first part of HTTP response */
  sprintf(buf, "HTTP/1.0 200 OK\r\n");
  Rio_writen(fd, buf, strlen(buf));
  sprintf(buf, "Server: Tiny Web Server\r\n");
  Rio_writen(fd, buf, strlen(buf));

  if (Fork() == 0) { /* Child */  // line:netp:servedynamic:fork
    /* Real server would set all CGI vars here */
    setenv("QUERY_STRING", cgiargs, 1);  // line:netp:servedynamic:setenv
    Dup2(fd, STDOUT_FILENO);
    /* Redirect stdout to client */  // line:netp:servedynamic:dup2
    Execve(filename, emptylist, environ);
    /* Run CGI program */  // line:netp:servedynamic:execve
  }
  Wait(NULL);
  /* Parent waits for and reaps child */  // line:netp:servedynamic:wait
}
/* $end serve_dynamic */

/*
 * clienterror - returns an error message to the client
 */
/* $begin clienterror */
void clienterror(int fd, char *cause, char *errnum, char *shortmsg,
                 char *longmsg) {
  char buf[MAXLINE], body[MAXBUF];

  /* Build the HTTP response body */
  sprintf(body, "<html><title>Tiny Error</title>");
  sprintf(body,
          "%s<body bgcolor="
          "ffffff"
          ">\r\n",
          body);
  sprintf(body, "%s%s: %s\r\n", body, errnum, shortmsg);
  sprintf(body, "%s<p>%s: %s\r\n", body, longmsg, cause);
  sprintf(body, "%s<hr><em>The Tiny Web server</em>\r\n", body);

  /* Print the HTTP response */
  sprintf(buf, "HTTP/1.0 %s %s\r\n", errnum, shortmsg);
  Rio_writen(fd, buf, strlen(buf));
  sprintf(buf, "Content-type: text/html\r\n");
  Rio_writen(fd, buf, strlen(buf));
  sprintf(buf, "Content-length: %d\r\n\r\n", (int)strlen(body));
  Rio_writen(fd, buf, strlen(buf));
  Rio_writen(fd, body, strlen(body));
}
/* $end clienterror */
