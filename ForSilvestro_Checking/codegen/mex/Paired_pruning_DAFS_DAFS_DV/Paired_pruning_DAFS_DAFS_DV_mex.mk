START_DIR = D:\RMT 2_0\RMT-2.0\ForSilvestro_Checking

MATLAB_ROOT = C:\PROGRA~1\MATLAB\R2015b
MAKEFILE = Paired_pruning_DAFS_DAFS_DV_mex.mk

include Paired_pruning_DAFS_DAFS_DV_mex.mki


SRC_FILES =  \
	Paired_pruning_DAFS_DAFS_DV_mexutil.c \
	Paired_pruning_DAFS_DAFS_DV_data.c \
	Paired_pruning_DAFS_DAFS_DV_initialize.c \
	Paired_pruning_DAFS_DAFS_DV_terminate.c \
	Paired_pruning_DAFS_DAFS_DV.c \
	eml_int_forloop_overflow_check.c \
	sort1.c \
	sortIdx.c \
	eml_setop.c \
	_coder_Paired_pruning_DAFS_DAFS_DV_info.c \
	_coder_Paired_pruning_DAFS_DAFS_DV_api.c \
	_coder_Paired_pruning_DAFS_DAFS_DV_mex.c \
	Paired_pruning_DAFS_DAFS_DV_emxutil.c

MEX_FILE_NAME_WO_EXT = Paired_pruning_DAFS_DAFS_DV_mex
MEX_FILE_NAME = $(MEX_FILE_NAME_WO_EXT).mexw64
TARGET = $(MEX_FILE_NAME)

SYS_LIBS = 


#
#====================================================================
# gmake makefile fragment for building MEX functions using MinGW
# Copyright 2015 The MathWorks, Inc.
#====================================================================
#
SHELL = cmd
CC = $(COMPILER)
LD = $(LINKER)
OBJEXT = o
.SUFFIXES: .$(OBJEXT)

OBJLISTC = $(SRC_FILES:.c=.$(OBJEXT))
OBJLISTCPP  = $(OBJLISTC:.cpp=.$(OBJEXT))
OBJLIST  = $(OBJLISTCPP:.cu=.$(OBJEXT))

target: $(TARGET)

ML_INCLUDES = -I "$(MATLAB_ROOT)/simulink/include"
ML_INCLUDES+= -I "$(MATLAB_ROOT)/toolbox/shared/simtargets"
SYS_INCLUDE = $(ML_INCLUDES)

# Additional includes

SYS_INCLUDE += -I "$(START_DIR)"
SYS_INCLUDE += -I "$(START_DIR)\codegen\mex\Paired_pruning_DAFS_DAFS_DV"
SYS_INCLUDE += -I ".\interface"
SYS_INCLUDE += -I "D:\RMT"
SYS_INCLUDE += -I "$(START_DIR)\2_0\RMT-2.0\ForSilvestro_Checking"
SYS_INCLUDE += -I "$(MATLAB_ROOT)\extern\include"
SYS_INCLUDE += -I "."

EML_LIBS = -llibemlrt -llibcovrt -llibut -llibmwmathutil -llibmwblas 
SYS_LIBS += $(CLIBS) $(EML_LIBS)

EXPORTFILE = $(MEX_FILE_NAME_WO_EXT)_mex.map
EXPORTOPT = -Wl,--version-script,$(EXPORTFILE)
COMP_FLAGS = $(COMPFLAGS) -DMX_COMPAT_32 $(OMPFLAGS)
CXX_FLAGS = $(COMPFLAGS) -DMX_COMPAT_32 $(OMPFLAGS)
LINK_FLAGS = $(LINKFLAGS)
LINK_FLAGS += $(OMPLINKFLAGS)
ifeq ($(EMC_CONFIG),optim)
  COMP_FLAGS += $(OPTIMFLAGS)
  CXX_FLAGS += $(OPTIMFLAGS)
  LINK_FLAGS += $(LINKOPTIMFLAGS)
else
  COMP_FLAGS += $(DEBUGFLAGS)
  CXX_FLAGS += $(DEBUGFLAGS)
  LINK_FLAGS += $(LINKDEBUGFLAGS)
endif
LINK_FLAGS += -o $(TARGET)
LINK_FLAGS += 

CCFLAGS =  $(COMP_FLAGS) $(USER_INCLUDE) $(SYS_INCLUDE)
CPPFLAGS =   $(CXX_FLAGS) $(USER_INCLUDE) $(SYS_INCLUDE)

%.$(OBJEXT) : %.c
	$(CC) $(CCFLAGS) "$<"

%.$(OBJEXT) : %.cpp
	$(CXX) $(CPPFLAGS) "$<"

# Additional sources

%.$(OBJEXT) : $(START_DIR)/%.c
	$(CC) $(CCFLAGS) "$<"

%.$(OBJEXT) : $(START_DIR)\codegen\mex\Paired_pruning_DAFS_DAFS_DV/%.c
	$(CC) $(CCFLAGS) "$<"

%.$(OBJEXT) : interface/%.c
	$(CC) $(CCFLAGS) "$<"



%.$(OBJEXT) : $(START_DIR)/%.cu
	$(CC) $(CCFLAGS) "$<"

%.$(OBJEXT) : $(START_DIR)\codegen\mex\Paired_pruning_DAFS_DAFS_DV/%.cu
	$(CC) $(CCFLAGS) "$<"

%.$(OBJEXT) : interface/%.cu
	$(CC) $(CCFLAGS) "$<"



%.$(OBJEXT) : $(START_DIR)/%.cpp
	$(CXX) $(CPPFLAGS) "$<"

%.$(OBJEXT) : $(START_DIR)\codegen\mex\Paired_pruning_DAFS_DAFS_DV/%.cpp
	$(CXX) $(CPPFLAGS) "$<"

%.$(OBJEXT) : interface/%.cpp
	$(CXX) $(CPPFLAGS) "$<"



$(TARGET): $(OBJLIST) $(MAKEFILE)
	$(LD) $(EXPORTOPT) $(OBJLIST) $(LINK_FLAGS) $(SYS_LIBS)

#====================================================================

