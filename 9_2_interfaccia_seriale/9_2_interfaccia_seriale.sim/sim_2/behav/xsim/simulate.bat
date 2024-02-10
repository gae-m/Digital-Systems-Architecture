@echo off
REM ****************************************************************************
REM Vivado (TM) v2019.1 (64-bit)
REM
REM Filename    : simulate.bat
REM Simulator   : Xilinx Vivado Simulator
REM Description : Script for simulating the design by launching the simulator
REM
REM Generated by Vivado on Mon Jan 22 13:24:57 +0100 2024
REM SW Build 2552052 on Fri May 24 14:49:42 MDT 2019
REM
REM Copyright 1986-2019 Xilinx, Inc. All Rights Reserved.
REM
REM usage: simulate.bat
REM
REM ****************************************************************************
echo "xsim nodoA_tb_behav -key {Behavioral:sim_2:Functional:nodoA_tb} -tclbatch nodoA_tb.tcl -view C:/Users/Donato/Desktop/vivado_projects/9_2_interfaccia_seriale/9_2_interfaccia_seriale.srcs/sim_2/imports/9_interfaccia_seriale/nodoA_CU_tb_behav.wcfg -view C:/Users/Donato/Desktop/vivado_projects/9_2_interfaccia_seriale/9_2_interfaccia_seriale.srcs/sim_2/imports/9_interfaccia_seriale/nodoA_tb_behav.wcfg -log simulate.log"
call xsim  nodoA_tb_behav -key {Behavioral:sim_2:Functional:nodoA_tb} -tclbatch nodoA_tb.tcl -view C:/Users/Donato/Desktop/vivado_projects/9_2_interfaccia_seriale/9_2_interfaccia_seriale.srcs/sim_2/imports/9_interfaccia_seriale/nodoA_CU_tb_behav.wcfg -view C:/Users/Donato/Desktop/vivado_projects/9_2_interfaccia_seriale/9_2_interfaccia_seriale.srcs/sim_2/imports/9_interfaccia_seriale/nodoA_tb_behav.wcfg -log simulate.log
if "%errorlevel%"=="0" goto SUCCESS
if "%errorlevel%"=="1" goto END
:END
exit 1
:SUCCESS
exit 0
