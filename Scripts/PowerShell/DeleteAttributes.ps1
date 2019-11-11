#=============================================================================#
# PowerShell script to delete all attributes in Vault created by vaultFLC     #
#                                                                             #
# This script deletes all relationships to Fusion Lifecycle items stored in   #
# Vault by vaultFLC. Please only run this script when you have purged all FLC #
# workspaces that where previously connected to Vault items!                  #
# The script requires the Vault SDK to be installed in the default location.  #
#                                                                             #
# Copyright (c) coolOrange s.r.l. - All rights reserved.                      #
#                                                                             #
# THIS SCRIPT/CODE IS PROVIDED "AS IS" WITHOUT WARRANTY OF ANY KIND, EITHER   #
# EXPRESSED OR IMPLIED, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES #
# OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE, OR NON-INFRINGEMENT.  #
#=============================================================================#

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


$namespaces = @("coolorange.flc.transfer.filebom.attributes", "coolorange.flc.transfer.file.attributes", "coolorange.flc.sync.folder.attributes")
foreach($namespace in $namespaces) {
    $attribues = $vault.PropertyService.FindAllEntityAttributes($namespace)
    foreach($a in $attribues) {
        $vault.PropertyService.SetEntityAttribute($a.EntityId, $namespace, $a.Attr, $null)
    }
}