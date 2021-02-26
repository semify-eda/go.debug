#!/usr/bin/env tcsh
set sourced = ($_)
if ("$sourced" == "") then
   echo "Script should be sourced."
   echo " Usage: 'source Setup.csh'"
   exit 1
endif

setenv EA_ROOT `pwd`
echo "(INFO) ErrorAnalyzer setup done";
echo "  EA_ROOT set at $EA_ROOT"; 

