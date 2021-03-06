# Sendmail_Lite
A simple Windows Powershell script for sending automated emails from scripts or programs via command line arguments.

![Sendmail_Lite](https://raw.githubusercontent.com/zelon88/Sendmail_Lite/master/Screenshots/Sendmail_Lite_Screenshot-1.png)

![Sendmail_Lite](https://raw.githubusercontent.com/zelon88/Sendmail_Lite/master/Screenshots/Sendmail_Lite_Screenshot-2.png)


NAME: Sendmail_Lite.ps1
 

TYPE: Powershell Script


PRIMARY LANGUAGE: Powershell

AUTHOR: Justin Grimes

ORIGINAL VERSION DATE: 3/2/2020

CURRENT VERSION DATE: 6/22/2020

VERSION: v0.9

DESCRIPTION: 

A simple script for sending automated emails from scripts or programs via command line arguments.

PURPOSE: 
To send emails programatically. Such as notification or warning emails from automated scripts or tasks.

INSTALLATION INSTRUCTIONS: 
1. Open the Sendmail_Lite.ps1 script with a text editor and modify the variables at the start of the script to match your environment.

2. Call this script using Powershell with the proper arrangement of command line arguments.
  1st Argument (Required) - From Email Address (String)" 
  2nd Argument (Required) - To Email Address (String)" 
  3rd Argument (Required) - Subject (String)" 
  4th Argument (Required) - Body (String)" 
  5th Argument (Optional) - Debug Mode (d, -d, /d, debug)" 

NOTES:
This script DOES NOT support SMTPS over port 587.
