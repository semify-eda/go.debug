#!/usr/bin/bash

[[ $_ != $0 ]] && export EA_ROOT=`pwd` || echo -e "\e[91mWARNING\e[39m: EA_ROOT not set.\nUsage: \"\e[1m\e[32msource Setup.sh\e[0m\e[39m\"\n    or \"\e[32m\e[1m. Setup.sh\e[0m\e[39m\"\n   \e[1m\e[91mNOT\e[39m \"./Setup.sh\e[0m\""
if [[ -v EA_ROOT ]];
  then echo -e "(INFO) ErrorAnalyzer setup done\n  EA_ROOT set at $EA_ROOT"; 
fi