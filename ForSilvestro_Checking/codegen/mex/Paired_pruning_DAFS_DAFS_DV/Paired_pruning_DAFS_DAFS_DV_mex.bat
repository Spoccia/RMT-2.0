@echo off
set MATLAB=C:\PROGRA~1\MATLAB\R2015b
set MATLAB_ARCH=win64
set MATLAB_BIN="C:\Program Files\MATLAB\R2015b\bin"
set ENTRYPOINT=mexFunction
set OUTDIR=.\
set LIB_NAME=Paired_pruning_DAFS_DAFS_DV_mex
set MEX_NAME=Paired_pruning_DAFS_DAFS_DV_mex
set MEX_EXT=.mexw64
call setEnv.bat
echo # Make settings for Paired_pruning_DAFS_DAFS_DV > Paired_pruning_DAFS_DAFS_DV_mex.mki
echo COMPILER=%COMPILER%>> Paired_pruning_DAFS_DAFS_DV_mex.mki
echo COMPFLAGS=%COMPFLAGS%>> Paired_pruning_DAFS_DAFS_DV_mex.mki
echo OPTIMFLAGS=%OPTIMFLAGS%>> Paired_pruning_DAFS_DAFS_DV_mex.mki
echo DEBUGFLAGS=%DEBUGFLAGS%>> Paired_pruning_DAFS_DAFS_DV_mex.mki
echo LINKER=%LINKER%>> Paired_pruning_DAFS_DAFS_DV_mex.mki
echo LINKFLAGS=%LINKFLAGS%>> Paired_pruning_DAFS_DAFS_DV_mex.mki
echo LINKOPTIMFLAGS=%LINKOPTIMFLAGS%>> Paired_pruning_DAFS_DAFS_DV_mex.mki
echo LINKDEBUGFLAGS=%LINKDEBUGFLAGS%>> Paired_pruning_DAFS_DAFS_DV_mex.mki
echo MATLAB_ARCH=%MATLAB_ARCH%>> Paired_pruning_DAFS_DAFS_DV_mex.mki
echo BORLAND=%BORLAND%>> Paired_pruning_DAFS_DAFS_DV_mex.mki
echo OMPFLAGS= >> Paired_pruning_DAFS_DAFS_DV_mex.mki
echo OMPLINKFLAGS= >> Paired_pruning_DAFS_DAFS_DV_mex.mki
echo EMC_COMPILER=mingw64>> Paired_pruning_DAFS_DAFS_DV_mex.mki
echo EMC_CONFIG=optim>> Paired_pruning_DAFS_DAFS_DV_mex.mki
"C:\Program Files\MATLAB\R2015b\bin\win64\gmake" -B -f Paired_pruning_DAFS_DAFS_DV_mex.mk
