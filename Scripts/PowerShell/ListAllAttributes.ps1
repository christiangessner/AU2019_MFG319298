Add-Type -Path "C:\Program Files\Autodesk\Autodesk Vault 2020 SDK\bin\x64\Autodesk.Connectivity.WebServices.dll"
$vaultServer = "localhost"
$vaultName = "Vault"
$vaultUser = "Administrator"
$vaultPassword = ""

$identities = New-Object Autodesk.Connectivity.WebServices.ServerIdentities
$identities.DataServer = $vaultServer
$identities.FileServer = $vaultServer
$credentials = New-Object Autodesk.Connectivity.WebServicesTools.UserPasswordCredentials($identities, $vaultName, $vaultUser, $vaultPassword, $false)
$vault = New-Object Autodesk.Connectivity.WebServicesTools.WebServiceManager ($credentials)

# Files
$namespaces = @("coolorange.flc.transfer.filebom.attributes", "coolorange.flc.transfer.file.attributes")
foreach($namespace in $namespaces) {
    $attribues = $vault.PropertyService.FindAllEntityAttributes($namespace)
    foreach($a in $attribues) {
        $file = $vault.DocumentService.GetLatestFileByMasterId($a.EntityId)
        $file.Name + ": " + $a.Val
    }
}

# Folder
$namespaces = @("coolorange.flc.sync.folder.attributes")
foreach($namespace in $namespaces) {
    $attribues = $vault.PropertyService.FindAllEntityAttributes($namespace)
    foreach($a in $attribues) {
        $folder = $vault.DocumentService.GetFolderById($a.EntityId)
        $folder.FullName + ": " + $a.Val
    }
}