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
include CMakeFiles/fork.dir/depend.make
# Include any dependencies generated by the compiler for this target.
include CMakeFiles/fork.dir/compiler_depend.make

# Include the progress variables for this target.
include CMakeFiles/fork.dir/progress.make

# Include the compile flags for this target's objects.
include CMakeFiles/fork.dir/flags.make

CMakeFiles/fork.dir/fork.c.o: CMakeFiles/fork.dir/flags.make
CMakeFiles/fork.dir/fork.c.o: /mnt/ubuntu/home/czg/csapp3e/ecf/fork.c
CMakeFiles/fork.dir/fork.c.o: CMakeFiles/fork.dir/compiler_depend.ts
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=/mnt/ubuntu/home/czg/csapp3e/ecf/_build/CMakeFiles --progress-num=$(CMAKE_PROGRESS_1) "Building C object CMakeFiles/fork.dir/fork.c.o"
	/usr/bin/cc $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -MD -MT CMakeFiles/fork.dir/fork.c.o -MF CMakeFiles/fork.dir/fork.c.o.d -o CMakeFiles/fork.dir/fork.c.o -c /mnt/ubuntu/home/czg/csapp3e/ecf/fork.c

CMakeFiles/fork.dir/fork.c.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing C source to CMakeFiles/fork.dir/fork.c.i"
	/usr/bin/cc $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -E /mnt/ubuntu/home/czg/csapp3e/ecf/fork.c > CMakeFiles/fork.dir/fork.c.i

CMakeFiles/fork.dir/fork.c.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling C source to assembly CMakeFiles/fork.dir/fork.c.s"
	/usr/bin/cc $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -S /mnt/ubuntu/home/czg/csapp3e/ecf/fork.c -o CMakeFiles/fork.dir/fork.c.s

# Object files for target fork
fork_OBJECTS = \
"CMakeFiles/fork.dir/fork.c.o"

# External object files for target fork
fork_EXTERNAL_OBJECTS =

fork: CMakeFiles/fork.dir/fork.c.o
fork: CMakeFiles/fork.dir/build.make
fork: libYourLib.so
fork: CMakeFiles/fork.dir/link.txt
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --bold --progress-dir=/mnt/ubuntu/home/czg/csapp3e/ecf/_build/CMakeFiles --progress-num=$(CMAKE_PROGRESS_2) "Linking C executable fork"
	$(CMAKE_COMMAND) -E cmake_link_script CMakeFiles/fork.dir/link.txt --verbose=$(VERBOSE)

# Rule to build all files generated by this target.
CMakeFiles/fork.dir/build: fork
.PHONY : CMakeFiles/fork.dir/build

CMakeFiles/fork.dir/clean:
	$(CMAKE_COMMAND) -P CMakeFiles/fork.dir/cmake_clean.cmake
.PHONY : CMakeFiles/fork.dir/clean

CMakeFiles/fork.dir/depend:
	cd /mnt/ubuntu/home/czg/csapp3e/ecf/_build && $(CMAKE_COMMAND) -E cmake_depends "Unix Makefiles" /mnt/ubuntu/home/czg/csapp3e/ecf /mnt/ubuntu/home/czg/csapp3e/ecf /mnt/ubuntu/home/czg/csapp3e/ecf/_build /mnt/ubuntu/home/czg/csapp3e/ecf/_build /mnt/ubuntu/home/czg/csapp3e/ecf/_build/CMakeFiles/fork.dir/DependInfo.cmake --color=$(COLOR)
.PHONY : CMakeFiles/fork.dir/depend

