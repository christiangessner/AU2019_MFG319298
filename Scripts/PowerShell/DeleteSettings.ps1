#=============================================================================#
# PowerShell script to delete all settings in Vault for vaultFLC              #
#                                                                             #
# This script deletes all settings (tenants and workspaces related settings   #
# such as tenant name, Client ID+secret, mappings for variuos workflows etc.) #
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

$vault.KnowledgeVaultService.SetVaultOption("VAULTFLC_CONNECTION_SETTINGS", $null)
$vault.KnowledgeVaultService.SetVaultOption("VAULTFLC_MAPPING_SETTINGS", $null)