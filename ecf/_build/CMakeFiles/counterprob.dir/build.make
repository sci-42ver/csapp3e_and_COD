# CMAKE generated file: DO NOT EDIT!
# Generated by "Unix Makefiles" Generator, CMake Version 3.26

# Delete rule output on recipe failure.
.DELETE_ON_ERROR:

#=============================================================================
# Special targets provided by cmake.

# Disable implicit rules so canonical targets will work.
.SUFFIXES:

# Disable VCS-based implicit rules.
% : %,v

# Disable VCS-based implicit rules.
% : RCS/%

# Disable VCS-based implicit rules.
% : RCS/%,v

# Disable VCS-based implicit rules.
% : SCCS/s.%

# Disable VCS-based implicit rules.
% : s.%

.SUFFIXES: .hpux_make_needs_suffix_list

# Command-line flag to silence nested $(MAKE).
$(VERBOSE)MAKESILENT = -s

#Suppress display of executed commands.
$(VERBOSE).SILENT:

# A target that is always out of date.
cmake_force:
.PHONY : cmake_force

#=============================================================================
# Set environment variables for the build.

# The shell in which to execute make rules.
SHELL = /bin/sh

# The CMake executable.
CMAKE_COMMAND = /usr/bin/cmake

# The command to remove a file.
RM = /usr/bin/cmake -E rm -f

# Escaping for special characters.
EQUALS = =

# The top-level source directory on which CMake was run.
CMAKE_SOURCE_DIR = /mnt/ubuntu/home/czg/csapp3e/ecf

# The top-level build directory on which CMake was run.
CMAKE_BINARY_DIR = /mnt/ubuntu/home/czg/csapp3e/ecf/_build

# Include any dependencies generated for this target.
include CMakeFiles/counterprob.dir/depend.make
# Include any dependencies generated by the compiler for this target.
include CMakeFiles/counterprob.dir/compiler_depend.make

# Include the progress variables for this target.
include CMakeFiles/counterprob.dir/progress.make

# Include the compile flags for this target's objects.
include CMakeFiles/counterprob.dir/flags.make

CMakeFiles/counterprob.dir/counterprob.c.o: CMakeFiles/counterprob.dir/flags.make
CMakeFiles/counterprob.dir/counterprob.c.o: /mnt/ubuntu/home/czg/csapp3e/ecf/counterprob.c
CMakeFiles/counterprob.dir/counterprob.c.o: CMakeFiles/counterprob.dir/compiler_depend.ts
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=/mnt/ubuntu/home/czg/csapp3e/ecf/_build/CMakeFiles --progress-num=$(CMAKE_PROGRESS_1) "Building C object CMakeFiles/counterprob.dir/counterprob.c.o"
	/usr/bin/cc $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -MD -MT CMakeFiles/counterprob.dir/counterprob.c.o -MF CMakeFiles/counterprob.dir/counterprob.c.o.d -o CMakeFiles/counterprob.dir/counterprob.c.o -c /mnt/ubuntu/home/czg/csapp3e/ecf/counterprob.c

CMakeFiles/counterprob.dir/counterprob.c.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing C source to CMakeFiles/counterprob.dir/counterprob.c.i"
	/usr/bin/cc $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -E /mnt/ubuntu/home/czg/csapp3e/ecf/counterprob.c > CMakeFiles/counterprob.dir/counterprob.c.i

CMakeFiles/counterprob.dir/counterprob.c.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling C source to assembly CMakeFiles/counterprob.dir/counterprob.c.s"
	/usr/bin/cc $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -S /mnt/ubuntu/home/czg/csapp3e/ecf/counterprob.c -o CMakeFiles/counterprob.dir/counterprob.c.s

# Object files for target counterprob
counterprob_OBJECTS = \
"CMakeFiles/counterprob.dir/counterprob.c.o"

# External object files for target counterprob
counterprob_EXTERNAL_OBJECTS =

counterprob: CMakeFiles/counterprob.dir/counterprob.c.o
counterprob: CMakeFiles/counterprob.dir/build.make
counterprob: libYourLib.so
counterprob: CMakeFiles/counterprob.dir/link.txt
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --bold --progress-dir=/mnt/ubuntu/home/czg/csapp3e/ecf/_build/CMakeFiles --progress-num=$(CMAKE_PROGRESS_2) "Linking C executable counterprob"
	$(CMAKE_COMMAND) -E cmake_link_script CMakeFiles/counterprob.dir/link.txt --verbose=$(VERBOSE)

# Rule to build all files generated by this target.
CMakeFiles/counterprob.dir/build: counterprob
.PHONY : CMakeFiles/counterprob.dir/build

CMakeFiles/counterprob.dir/clean:
	$(CMAKE_COMMAND) -P CMakeFiles/counterprob.dir/cmake_clean.cmake
.PHONY : CMakeFiles/counterprob.dir/clean

CMakeFiles/counterprob.dir/depend:
	cd /mnt/ubuntu/home/czg/csapp3e/ecf/_build && $(CMAKE_COMMAND) -E cmake_depends "Unix Makefiles" /mnt/ubuntu/home/czg/csapp3e/ecf /mnt/ubuntu/home/czg/csapp3e/ecf /mnt/ubuntu/home/czg/csapp3e/ecf/_build /mnt/ubuntu/home/czg/csapp3e/ecf/_build /mnt/ubuntu/home/czg/csapp3e/ecf/_build/CMakeFiles/counterprob.dir/DependInfo.cmake --color=$(COLOR)
.PHONY : CMakeFiles/counterprob.dir/depend

