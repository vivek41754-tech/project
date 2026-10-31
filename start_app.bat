@echo off
title FinOps Cloud Waste Hunter & Auto-Remediator
cd /d "%~dp0"
echo ======================================================================
echo   FinOps Cloud Waste Hunter ^& Auto-Remediator
echo   Author: Vivek Pandey (24MIS0216)
echo ======================================================================
echo Starting local FinOps server and opening dashboard...
python run_app.py
pause
