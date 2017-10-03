@echo off
set MATLAB=C:\PROGRA~1\MATLAB\R2015b
set MATLAB_ARCH=win64
set MATLAB_BIN="C:\Program Files\MATLAB\R2015b\bin"
set ENTRYPOINT=mexFunction
set OUTDIR=.\
set LIB_NAME=pruning_DAFS_DAFS_1_mex
set MEX_NAME=pruning_DAFS_DAFS_1_mex
set MEX_EXT=.mexw64
call setEnv.bat
echo # Make settings for pruning_DAFS_DAFS_1 > pruning_DAFS_DAFS_1_mex.mki
echo COMPILER=%COMPILER%>> pruning_DAFS_DAFS_1_mex.mki
echo COMPFLAGS=%COMPFLAGS%>> pruning_DAFS_DAFS_1_mex.mki
echo OPTIMFLAGS=%OPTIMFLAGS%>> pruning_DAFS_DAFS_1_mex.mki
echo DEBUGFLAGS=%DEBUGFLAGS%>> pruning_DAFS_DAFS_1_mex.mki
echo LINKER=%LINKER%>> pruning_DAFS_DAFS_1_mex.mki
echo LINKFLAGS=%LINKFLAGS%>> pruning_DAFS_DAFS_1_mex.mki
echo LINKOPTIMFLAGS=%LINKOPTIMFLAGS%>> pruning_DAFS_DAFS_1_mex.mki
echo LINKDEBUGFLAGS=%LINKDEBUGFLAGS%>> pruning_DAFS_DAFS_1_mex.mki
echo MATLAB_ARCH=%MATLAB_ARCH%>> pruning_DAFS_DAFS_1_mex.mki
echo BORLAND=%BORLAND%>> pruning_DAFS_DAFS_1_mex.mki
echo OMPFLAGS= >> pruning_DAFS_DAFS_1_mex.mki
echo OMPLINKFLAGS= >> pruning_DAFS_DAFS_1_mex.mki
echo EMC_COMPILER=mingw64>> pruning_DAFS_DAFS_1_mex.mki
echo EMC_CONFIG=optim>> pruning_DAFS_DAFS_1_mex.mki
"C:\Program Files\MATLAB\R2015b\bin\win64\gmake" -B -f pruning_DAFS_DAFS_1_mex.mk
