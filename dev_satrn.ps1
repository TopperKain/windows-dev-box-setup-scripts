# Description: Boxstarter Script
# Author: Microsoft
# Common dev settings for desktop app development

Disable-UAC

# Get the base URI path from the ScriptToCall value
$bstrappackage = "-bootstrapPackage"
$helperUri = $Boxstarter['ScriptToCall']
$strpos = $helperUri.IndexOf($bstrappackage)
$helperUri = $helperUri.Substring($strpos + $bstrappackage.Length)
$helperUri = $helperUri.TrimStart("'", " ")
$helperUri = $helperUri.TrimEnd("'", " ")
$helperUri = $helperUri.Substring(0, $helperUri.LastIndexOf("/"))
$helperUri += "/scripts"
write-host "helper script base URI is $helperUri"

function executeScript {
    Param ([string]$script)
    write-host "executing $helperUri/$script ..."
	iex ((new-object net.webclient).DownloadString("$helperUri/$script"))
}

#--- Setting up Windows ---
executeScript "FileExplorerSettings.ps1";
executeScript "SystemConfiguration.ps1";
executeScript "RemoveDefaultApps.ps1";
executeScript "CommonDevTools.ps1";
executeScript "Browsers.ps1";

choco install chocolatey-visualstudio.extension
choco install visualstudio2019-workload-node
choco install visualstudio2019-workload-azure  --package-parameters "--includeRecommended --includeOptional --passive --locale en-US"
choco install visualstudio2019-workload-data  --package-parameters "--includeRecommended --includeOptional --passive --locale en-US"
choco install visualstudio2019-workload-netcoretools
choco install visualstudio2019-workload-netweb --package-parameters "--includeRecommended --includeOptional --passive --locale en-US"
choco install visualstudio2019-workload-office  --package-parameters "--includeRecommended --includeOptional --passive --locale en-US"
choco install visualstudio2019-workload-netcrossplat
choco install visualstudio2019-workload-universal


choco install -y powershell-core
choco install -y azure-cli
Install-Module -Force Az
choco install -y microsoftazurestorageexplorer

choco install microsoft-teams

Enable-UAC
Enable-MicrosoftUpdate
Install-WindowsUpdate -acceptEula
