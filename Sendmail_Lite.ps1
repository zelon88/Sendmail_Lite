# --------------------------------------------------
# Sendmail_Lite.ps1
# v0.8 - 3/2/2020

# Justin Grimes (@zelon88)
# Made on Windows 7 with PowerShell

# This program is for sending emails over SMTP using the Windows Net.Mail.SmtpClient class.
# This program DOES NOT support SMTPS over port 587.
# --------------------------------------------------

# --------------------------------------------------
# VALID ARGUMENTS / PARAMETERS / SWITCHES

#  1st Argument (Required) - From Email
#  2nd Argument (Required) - To Email
#  3rd Argument (Required) - Subject
#  4th Argument (Required) - Body
# --------------------------------------------------

# --------------------------------------------------
# ENVIRONMENT VARIABLES
# Modify the variables in the following code block to match your environment.

# The SMTPServer is the URL, IP, or internal FQDN of your SMTP email server.
$SMTPServer = "your-email-server.com"
# This value defines the port that your email server is listening on.
# This script DOES NOT support SMTPS over port 587.
$SMTPClient = New-Object Net.Mail.SmtpClient($SmtpServer, 465)
# This value determines if the connection to the SMTP server is encrypted or not.
# Set to $True to enable encryption. Set to $False to disable encryption.
# You may have to alter the SMTP port used after changing this value. 
$SMTPClient.EnableSsl = $True
# These two string values at the end of the following line define the email account to use & the password for that account.
$SMTPClient.Credentials = New-Object System.Net.NetworkCredential("test@company.com", "TEST-EMAIL-ACCOUNT-PASSW0RD");
# --------------------------------------------------

# --------------------------------------------------
# ARGUMENT VARIABLES
# These variables define the command line API for this script.

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
$Body = $Args[3]
# --------------------------------------------------

# --------------------------------------------------
# MAIN LOGIC
# This is the main logical part of the script which sends the actual email.

# Send the email using the deprecated Windows Net.Mail.SmtpClient class.
$SMTPClient.Send($EmailFrom, $EmailTo, $Subject, $Body)
# --------------------------------------------------