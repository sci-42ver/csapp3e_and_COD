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
include CMakeFiles/forkprob7.dir/depend.make
# Include any dependencies generated by the compiler for this target.
include CMakeFiles/forkprob7.dir/compiler_depend.make

# Include the progress variables for this target.
include CMakeFiles/forkprob7.dir/progress.make

# Include the compile flags for this target's objects.
include CMakeFiles/forkprob7.dir/flags.make

CMakeFiles/forkprob7.dir/forkprob7.c.o: CMakeFiles/forkprob7.dir/flags.make
CMakeFiles/forkprob7.dir/forkprob7.c.o: /mnt/ubuntu/home/czg/csapp3e/ecf/forkprob7.c
CMakeFiles/forkprob7.dir/forkprob7.c.o: CMakeFiles/forkprob7.dir/compiler_depend.ts
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=/mnt/ubuntu/home/czg/csapp3e/ecf/_build/CMakeFiles --progress-num=$(CMAKE_PROGRESS_1) "Building C object CMakeFiles/forkprob7.dir/forkprob7.c.o"
	/usr/bin/cc $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -MD -MT CMakeFiles/forkprob7.dir/forkprob7.c.o -MF CMakeFiles/forkprob7.dir/forkprob7.c.o.d -o CMakeFiles/forkprob7.dir/forkprob7.c.o -c /mnt/ubuntu/home/czg/csapp3e/ecf/forkprob7.c

CMakeFiles/forkprob7.dir/forkprob7.c.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing C source to CMakeFiles/forkprob7.dir/forkprob7.c.i"
	/usr/bin/cc $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -E /mnt/ubuntu/home/czg/csapp3e/ecf/forkprob7.c > CMakeFiles/forkprob7.dir/forkprob7.c.i

CMakeFiles/forkprob7.dir/forkprob7.c.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling C source to assembly CMakeFiles/forkprob7.dir/forkprob7.c.s"
	/usr/bin/cc $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -S /mnt/ubuntu/home/czg/csapp3e/ecf/forkprob7.c -o CMakeFiles/forkprob7.dir/forkprob7.c.s

# Object files for target forkprob7
forkprob7_OBJECTS = \
"CMakeFiles/forkprob7.dir/forkprob7.c.o"

# External object files for target forkprob7
forkprob7_EXTERNAL_OBJECTS =

forkprob7: CMakeFiles/forkprob7.dir/forkprob7.c.o
forkprob7: CMakeFiles/forkprob7.dir/build.make
forkprob7: libYourLib.so
forkprob7: CMakeFiles/forkprob7.dir/link.txt
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --bold --progress-dir=/mnt/ubuntu/home/czg/csapp3e/ecf/_build/CMakeFiles --progress-num=$(CMAKE_PROGRESS_2) "Linking C executable forkprob7"
	$(CMAKE_COMMAND) -E cmake_link_script CMakeFiles/forkprob7.dir/link.txt --verbose=$(VERBOSE)

# Rule to build all files generated by this target.
CMakeFiles/forkprob7.dir/build: forkprob7
.PHONY : CMakeFiles/forkprob7.dir/build

CMakeFiles/forkprob7.dir/clean:
	$(CMAKE_COMMAND) -P CMakeFiles/forkprob7.dir/cmake_clean.cmake
.PHONY : CMakeFiles/forkprob7.dir/clean

CMakeFiles/forkprob7.dir/depend:
	cd /mnt/ubuntu/home/czg/csapp3e/ecf/_build && $(CMAKE_COMMAND) -E cmake_depends "Unix Makefiles" /mnt/ubuntu/home/czg/csapp3e/ecf /mnt/ubuntu/home/czg/csapp3e/ecf /mnt/ubuntu/home/czg/csapp3e/ecf/_build /mnt/ubuntu/home/czg/csapp3e/ecf/_build /mnt/ubuntu/home/czg/csapp3e/ecf/_build/CMakeFiles/forkprob7.dir/DependInfo.cmake --color=$(COLOR)
.PHONY : CMakeFiles/forkprob7.dir/depend

