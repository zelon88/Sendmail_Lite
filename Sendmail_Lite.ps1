# ----------------------------------------------------------------------------------------------------
# Sendmail_Lite.ps1
# v0.9 - 6/22/2020
# Licensed under GPLv3, https://www.gnu.org/licenses/gpl-3.0.txt

# Justin Grimes (@zelon88)
# Made on Windows 7 with PowerShell

# This program is for sending emails over SMTP using the Windows Net.Mail.SmtpClient class.
# This program DOES NOT support SMTPS over port 587.
# ----------------------------------------------------------------------------------------------------

# ----------------------------------------------------------------------------------------------------
# VALID ARGUMENTS / PARAMETERS / SWITCHES

#  1st Argument (Required) - From Email (String)
#  2nd Argument (Required) - To Email (String)
#  3rd Argument (Required) - Subject (String)
#  4th Argument (Required) - Body (String)
#  5th Argument (Optional) - Debug Mode (d, -d, /d, debug)
# ----------------------------------------------------------------------------------------------------

# ----------------------------------------------------------------------------------------------------
# VARIABLE DECLARATIONS
# This section declares most of the variables used in this script & initializes them to default values.
# Modify the variables in the following code block to match your environment.

# The Version is a unique identifier for the revision of this codebase.
$Version = "v0.9"
# The Debug flag is a boolean which will cause this program to create console output describing it's functionality during operation.
# Set Debug to True to display all console output by default.
# Set Debug to False to only display console output when a valid Debug argument is passed to the script.
$Debug = $False
# The SendMessage flag is a boolean used during internal sanity checks on user-supplied input. 
# SendMessage should be initialized to True by default.
$SendMessage = $True
# The WelcomeText is a string displayed at the top of the Help text & during Debug mode.
$WelcomeText = 'Sendmail_Lite Version '+$Version+' by Justin Grimes (GPLv3, @Zelon88, https://github.com/zelon88)'
# The SMTPServer is the URL, IP, or internal FQDN of your SMTP email server.
$SMTPServer = "your_email_server.com"
# The SMTPUser is the user name to use when connecting to your SMTP server. 
$SMTPUser = "IT@company.com"
# The SMTPPassword is the password to use when connecting to your SMTP server.
$SMTPPassword = "Such_a_G0od_p4s5w0rd_i7_hurt5"
# The SMTPClientPort value defines the port that your email server is listening on.
# The default SMTPClientPort is 25. Another common port is 465. This value must be an integer from 1-65535. 
# This script DOES NOT support SMTPS over port 587.
$SMTPClientPort = 25
# The SMTPClient object uses the SmtpClient class by Microsoft to send emails using the SMTP protocol.
$SMTPClient = New-Object Net.Mail.SmtpClient($SmtpServer, $SMTPClientPort)
# This value determines if the connection to the SMTP server is encrypted or not.
# Set to $True to enable encryption. Set to $False to disable encryption.
# You may have to alter the SMTP port used after changing this value. 
$SMTPClient.EnableSsl = $True
# ----------------------------------------------------------------------------------------------------

# ----------------------------------------------------------------------------------------------------
# ARGUMENT PARSER
# This section contains the argument parser which processes & validates user-input supplied by the command line.
# If user-supplied input is invalid no emails will be sent. 

# Check if there are more than 4 arguments being passed.
if ($Args.Length -gt 4) {
  # Check if the 5th argument intends to enable Debug mode.
  if ($Args[4].ToLower() -eq "debug" -or $Args[4].ToLower() -eq "d" -or $Args[4].ToLower() -eq "-d" -or $Args[4].ToLower() -eq "/d") {
    $Debug = $True } 
  # Output progress update to the console if Debug mode is enabled.
  if ($Debug) { 
    Write-Host ""
    Write-Host $WelcomeText -ForegroundColor DarkGreen } }

if ($Args.Length -ge 4) {
  # Output progress update to the console if Debug mode is enabled.
  if ($Debug) { 
    Write-Host "Gathering supplied arguments..." -ForegroundColor Green }
  # Define the email address to display in the "From" field of the email. 
  # First argument. Required.
  $EmailFrom = $Args[0]
  # Define the email address to send the email to. Must be a valid recipient. 
  # Second Argument. Required
  $EmailTo = $Args[1]
  # Define the subject of the email message.
  # Third Argument. Required.
  $Subject = $Args[2]
  # Define the body of the email message. 
  # Don't forget to be clever when escaping or encapsulating complex strings!
  # Fourth Argument. Required.
  $Body = $Args[3] }

# Check that enough arguments are present to successfully send an email.
if ($Args.Length -lt 4) { 
  # If not enough input was supplied to send an email, set the SendMessage flag to false & display some help text.
  $SendMessage = $False
  # Display some help text with instructions if the supplied input is invalid.
  Write-Host ""
  Write-Host "----------------------------------------------------------------------------" -ForegroundColor Green
  Write-Host $WelcomeText -ForegroundColor Green
  Write-Host ""
  Write-Host "A lightweight PowerShell script for sending emails directly over SMTP." -ForegroundColor DarkGreen
  Write-Host ""
  Write-Host "----------------------------------------------------------------------------" -ForegroundColor Green
  Write-Host "  VALID ARGUMENTS / PARAMETERS / SWITCHES" -ForegroundColor Green
  Write-Host ""
  Write-Host "    1st Argument (Required) - From Email Address (String)" -ForegroundColor DarkGreen
  Write-Host "    2nd Argument (Required) - To Email Address (String)" -ForegroundColor DarkGreen
  Write-Host "    3rd Argument (Required) - Subject (String)" -ForegroundColor DarkGreen
  Write-Host "    4th Argument (Required) - Body (String)" -ForegroundColor DarkGreen
  Write-Host "    5th Argument (Optional) - Debug Mode (d, -d, /d, debug)" -ForegroundColor DarkGreen
  Write-Host ""
  Write-Host "----------------------------------------------------------------------------" -ForegroundColor Green
  Write-Host "  EXAMPLE RUNNING FROM POWERSHELL CONSOLE" -ForegroundColor Green
  Write-Host ""
  Write-Host '    PS>Sendmail_Lite.ps1 "From_Email@Company.com" "To_Email@Company.com" "RE:Subject Line" "Body of email which is several paragraphs long!"' -ForegroundColor DarkGreen
  Write-Host '    PS>Sendmail_Lite.ps1 "From_Email@Company.com" "To_Email@Company.com" "RE:Subject Line" "Body of email which is several paragraphs long!" d' -ForegroundColor DarkGreen
  Write-Host '    PS>Sendmail_Lite.ps1 "From_Email@Company.com" "To_Email@Company.com" "RE:Subject Line" "Body of email which is several paragraphs long!" -d' -ForegroundColor DarkGreen
  Write-Host '    PS>Sendmail_Lite.ps1 "From_Email@Company.com" "To_Email@Company.com" "RE:Subject Line" "Body of email which is several paragraphs long!" /d' -ForegroundColor DarkGreen
  Write-Host '    PS>Sendmail_Lite.ps1 "From_Email@Company.com" "To_Email@Company.com" "RE:Subject Line" "Body of email which is several paragraphs long!" debug' -ForegroundColor DarkGreen
  Write-Host ""
  Write-Host "----------------------------------------------------------------------------" -ForegroundColor Green
  Write-Host "  EXAMPLE RUNNING FROM COMMAND PROMPT (CMD) CONSOLE" -ForegroundColor Green
  Write-Host ""
  Write-Host "    C:\>powershell -command `"`'"'Sendmail_Lite.ps1'`'' '`''From_Email@Company.com'`'' '`''RE:Subject Line!'`'' '`''Body of email which is several paragraphs long!' -ForegroundColor DarkGreen
  Write-Host "    C:\>powershell -command `"`'"'Sendmail_Lite.ps1'`'' '`''From_Email@Company.com'`'' '`''RE:Subject Line!'`'' '`''Body of email which is several paragraphs long!'`' 'd' -ForegroundColor DarkGreen
  Write-Host "    C:\>powershell -command `"`'"'Sendmail_Lite.ps1'`'' '`''From_Email@Company.com'`'' '`''RE:Subject Line!'`'' '`''Body of email which is several paragraphs long!'`' '-d' -ForegroundColor DarkGreen
  Write-Host "    C:\>powershell -command `"`'"'Sendmail_Lite.ps1'`'' '`''From_Email@Company.com'`'' '`''RE:Subject Line!'`'' '`''Body of email which is several paragraphs long!'`' '/d' -ForegroundColor DarkGreen
  Write-Host "    C:\>powershell -command `"`'"'Sendmail_Lite.ps1'`'' '`''From_Email@Company.com'`'' '`''RE:Subject Line!'`'' '`''Body of email which is several paragraphs long!'`' 'debug' -ForegroundColor DarkGreen
  Write-Host ""
  Write-Host "----------------------------------------------------------------------------" -ForegroundColor Green
  Write-Host "" }
# ----------------------------------------------------------------------------------------------------

# ----------------------------------------------------------------------------------------------------
# MAIN LOGIC
# Check that the SendMessage flag is still true before preparing to send an email.
# If the SendMessage flag is false then one of the earilier sanity checks has failed.
if ($SendMessage) {
  
  # Output progress update to the console if Debug mode is enabled.
  if ($Debug) { 
    Write-Host 'Initializing objects & variables...' -ForegroundColor Green }
  
  # These two string values at the end of the following line define the email account to use & the password for that account.
  $SMTPClient.Credentials = New-Object System.Net.NetworkCredential($SMTPUser, $SMTPPassword);
  
  # Output progress update to the console if Debug mode is enabled.
  if ($Debug) { 
    Write-Host "Connecting to the SMTP server..." -ForegroundColor Green }
  
  # Send the email using the deprecated Windows Net.Mail.SmtpClient class.
  $SMTPClient.Send($EmailFrom, $EmailTo, $Subject, $Body)
  
  # Output progress update to the console if Debug mode is enabled.
  if ($Debug) { 
    Write-Host "Operation Complete." -ForegroundColor Green } }

# If the SendMessage flag was set to false for any reason, display a generic error message to replace the usual program output.
else {
  if ($Debug) { 
    Write-Host "Operation Failed!" -ForegroundColor Red } }
# ----------------------------------------------------------------------------------------------------