# Proyecto_IaC
Sumario del codigo empleado en el despliegue del proyecto


trigger: 
- build-agent  ## en las lienas 5-6 declaramos el trigger que en este caso va a ser un build agent y que permitira que se desencadene todo el pipeline.

pool:
  vmImage: ubuntu-latest  ## en las lineas 8-9 declaramos el pool con una iso ubuntu ultima version.

steps:   ## en la linea 11 incluiremos el primer separador step
- task: AzurePowerShell@5  ##en la linea 12 abrimos el task y declaramos que trabajara con Powershell
  inputs:
    azureSubscription: 'experiment'
    ScriptType: 'InlineScript'
    Inline: 
      $VMLocalAdminUser = "LocalAdminUser"  ##de la linea 13 a la 23 declaramos los inputs que constaran de el conexion service la declaracion del inline-script y la declaracion de multiples variables que mas adelante aplicaremos sobre el script 

      $VMLocalAdminSecurePassword = ConvertTo-SecureString "P@ssw0rd1" -AsPlainText -Force 

      $Credential = New-Object System.Management.Automation.PSCredential ($VMLocalAdminUser, $VMLocalAdminSecurePassword)  

      New-AzResourceGroup -Name 'charlie' -Location 'uksouth' -force 
      
      New-AzVm -Credential $Credential -ResourceGroupName 'charlie'   -Name 'Omega'   -Location 'uksouth'   -Image Debian `  -size Standard_B2s  -PublicIpAddressName     myPubIP   -OpenPorts 80  -GenerateSshKey  -SshKeyName mySSHKey
      azurePowerShellVersion: 'LatestVersion'

## de la linea 25 a la 26 se incluira el propio codigo del inline script que despliega la maquina virtual
