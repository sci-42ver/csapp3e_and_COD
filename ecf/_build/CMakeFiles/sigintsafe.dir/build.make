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
include CMakeFiles/sigintsafe.dir/depend.make
# Include any dependencies generated by the compiler for this target.
include CMakeFiles/sigintsafe.dir/compiler_depend.make

# Include the progress variables for this target.
include CMakeFiles/sigintsafe.dir/progress.make

# Include the compile flags for this target's objects.
include CMakeFiles/sigintsafe.dir/flags.make

CMakeFiles/sigintsafe.dir/sigintsafe.c.o: CMakeFiles/sigintsafe.dir/flags.make
CMakeFiles/sigintsafe.dir/sigintsafe.c.o: /mnt/ubuntu/home/czg/csapp3e/ecf/sigintsafe.c
CMakeFiles/sigintsafe.dir/sigintsafe.c.o: CMakeFiles/sigintsafe.dir/compiler_depend.ts
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=/mnt/ubuntu/home/czg/csapp3e/ecf/_build/CMakeFiles --progress-num=$(CMAKE_PROGRESS_1) "Building C object CMakeFiles/sigintsafe.dir/sigintsafe.c.o"
	/usr/bin/cc $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -MD -MT CMakeFiles/sigintsafe.dir/sigintsafe.c.o -MF CMakeFiles/sigintsafe.dir/sigintsafe.c.o.d -o CMakeFiles/sigintsafe.dir/sigintsafe.c.o -c /mnt/ubuntu/home/czg/csapp3e/ecf/sigintsafe.c

CMakeFiles/sigintsafe.dir/sigintsafe.c.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing C source to CMakeFiles/sigintsafe.dir/sigintsafe.c.i"
	/usr/bin/cc $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -E /mnt/ubuntu/home/czg/csapp3e/ecf/sigintsafe.c > CMakeFiles/sigintsafe.dir/sigintsafe.c.i

CMakeFiles/sigintsafe.dir/sigintsafe.c.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling C source to assembly CMakeFiles/sigintsafe.dir/sigintsafe.c.s"
	/usr/bin/cc $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -S /mnt/ubuntu/home/czg/csapp3e/ecf/sigintsafe.c -o CMakeFiles/sigintsafe.dir/sigintsafe.c.s

# Object files for target sigintsafe
sigintsafe_OBJECTS = \
"CMakeFiles/sigintsafe.dir/sigintsafe.c.o"

# External object files for target sigintsafe
sigintsafe_EXTERNAL_OBJECTS =

sigintsafe: CMakeFiles/sigintsafe.dir/sigintsafe.c.o
sigintsafe: CMakeFiles/sigintsafe.dir/build.make
sigintsafe: libYourLib.so
sigintsafe: CMakeFiles/sigintsafe.dir/link.txt
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --bold --progress-dir=/mnt/ubuntu/home/czg/csapp3e/ecf/_build/CMakeFiles --progress-num=$(CMAKE_PROGRESS_2) "Linking C executable sigintsafe"
	$(CMAKE_COMMAND) -E cmake_link_script CMakeFiles/sigintsafe.dir/link.txt --verbose=$(VERBOSE)

# Rule to build all files generated by this target.
CMakeFiles/sigintsafe.dir/build: sigintsafe
.PHONY : CMakeFiles/sigintsafe.dir/build

CMakeFiles/sigintsafe.dir/clean:
	$(CMAKE_COMMAND) -P CMakeFiles/sigintsafe.dir/cmake_clean.cmake
.PHONY : CMakeFiles/sigintsafe.dir/clean

CMakeFiles/sigintsafe.dir/depend:
	cd /mnt/ubuntu/home/czg/csapp3e/ecf/_build && $(CMAKE_COMMAND) -E cmake_depends "Unix Makefiles" /mnt/ubuntu/home/czg/csapp3e/ecf /mnt/ubuntu/home/czg/csapp3e/ecf /mnt/ubuntu/home/czg/csapp3e/ecf/_build /mnt/ubuntu/home/czg/csapp3e/ecf/_build /mnt/ubuntu/home/czg/csapp3e/ecf/_build/CMakeFiles/sigintsafe.dir/DependInfo.cmake --color=$(COLOR)
.PHONY : CMakeFiles/sigintsafe.dir/depend

