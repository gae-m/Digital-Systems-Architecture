@echo off
REM ****************************************************************************
REM Vivado (TM) v2019.1.3 (64-bit)
REM
REM Filename    : elaborate.bat
REM Simulator   : Xilinx Vivado Simulator
REM Description : Script for elaborating the compiled design
REM
REM Generated by Vivado on Sun Feb 04 14:22:07 +0100 2024
REM SW Build 2644227 on Wed Sep  4 09:45:24 MDT 2019
REM
REM Copyright 1986-2019 Xilinx, Inc. All Rights Reserved.
REM
REM usage: elaborate.bat
REM
REM ****************************************************************************
echo "xelab -wto 1ce801a7496c4351bb68a4cd71fa9d68 --incr --debug typical --relax --mt 2 -L xil_defaultlib -L secureip --snapshot system_tb_behav xil_defaultlib.system_tb -log elaborate.log"
call xelab  -wto 1ce801a7496c4351bb68a4cd71fa9d68 --incr --debug typical --relax --mt 2 -L xil_defaultlib -L secureip --snapshot system_tb_behav xil_defaultlib.system_tb -log elaborate.log
if "%errorlevel%"=="0" goto SUCCESS
if "%errorlevel%"=="1" goto END
:END
exit 1
:SUCCESS
exit 0
