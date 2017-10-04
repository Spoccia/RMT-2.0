@echo off
set MATLAB=C:\PROGRA~1\MATLAB\R2015b
set MATLAB_ARCH=win64
set MATLAB_BIN="C:\Program Files\MATLAB\R2015b\bin"
set ENTRYPOINT=mexFunction
set OUTDIR=.\
set LIB_NAME=Unpaired_pruning_DAFS_DAFS_DV_mex
set MEX_NAME=Unpaired_pruning_DAFS_DAFS_DV_mex
set MEX_EXT=.mexw64
call setEnv.bat
echo # Make settings for Unpaired_pruning_DAFS_DAFS_DV > Unpaired_pruning_DAFS_DAFS_DV_mex.mki
echo COMPILER=%COMPILER%>> Unpaired_pruning_DAFS_DAFS_DV_mex.mki
echo COMPFLAGS=%COMPFLAGS%>> Unpaired_pruning_DAFS_DAFS_DV_mex.mki
echo OPTIMFLAGS=%OPTIMFLAGS%>> Unpaired_pruning_DAFS_DAFS_DV_mex.mki
echo DEBUGFLAGS=%DEBUGFLAGS%>> Unpaired_pruning_DAFS_DAFS_DV_mex.mki
echo LINKER=%LINKER%>> Unpaired_pruning_DAFS_DAFS_DV_mex.mki
echo LINKFLAGS=%LINKFLAGS%>> Unpaired_pruning_DAFS_DAFS_DV_mex.mki
echo LINKOPTIMFLAGS=%LINKOPTIMFLAGS%>> Unpaired_pruning_DAFS_DAFS_DV_mex.mki
echo LINKDEBUGFLAGS=%LINKDEBUGFLAGS%>> Unpaired_pruning_DAFS_DAFS_DV_mex.mki
echo MATLAB_ARCH=%MATLAB_ARCH%>> Unpaired_pruning_DAFS_DAFS_DV_mex.mki
echo BORLAND=%BORLAND%>> Unpaired_pruning_DAFS_DAFS_DV_mex.mki
echo OMPFLAGS= >> Unpaired_pruning_DAFS_DAFS_DV_mex.mki
echo OMPLINKFLAGS= >> Unpaired_pruning_DAFS_DAFS_DV_mex.mki
echo EMC_COMPILER=mingw64>> Unpaired_pruning_DAFS_DAFS_DV_mex.mki
echo EMC_CONFIG=optim>> Unpaired_pruning_DAFS_DAFS_DV_mex.mki
"C:\Program Files\MATLAB\R2015b\bin\win64\gmake" -B -f Unpaired_pruning_DAFS_DAFS_DV_mex.mk
