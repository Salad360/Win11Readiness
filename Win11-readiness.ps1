# Run by pasting into Admin Powershell window: 

#  iex ((New-Object System.Net.WebClient).DownloadString('<URL of repo here>'))
# May reqire first running this command: [Net.ServicePointManager]::SecurityProtocol = "tls12, tls11, tls"
HOSTNAME.EXE > report.txt

$SERIALNUMBER = (Get-CimInstance -ClassName Win32_BIOS).SerialNumber

Write-Output "Serialnumber: $SERIALNUMBER" >> report.txt

# Get CPU

Write-Output "CPU:" >> .\report.txt
Get-WmiObject -Class Win32_Processor | Select-Object Name, Manufacturer, Description >> report.txt

# Get Installed RAM
"Installed RAM: {0} GB" -f [math]::Round((Get-CimInstance -ClassName Win32_ComputerSystem).TotalPhysicalMemory / 1GB, 2) >> report.txt


# Check Disk Media Type
Write-Output "Disks:" >> .\report.txt
Get-PhysicalDisk | Select-Object MediaType,FriendlyName >> report.txt


# Check if TPM Module is present, ready and enabled
Write-Output "TPM Status:" >> report.txt

get-tpm | select-object TpmPresent,TpmReady,TpmEnabled >> .\report.txt


Get-Content report.txt