# Proyecto_IaC
Sumario del codigo empleado en el despliegue del proyecto

Archivo BashDeployPipe.yml

trigger:
- master ## En estas dos primera lineas declaramos un trigger que se desata con el modulo master y hace que todo lo siguiente se desencadene.
stages:  ##Abrimos el separador stages para crear el sub-stage cli 
- stage: 'cli'
  displayName: 'Deploy' ##Le damos el displayName Deploy para que se indique en la fase del pipeline
  jobs: ##Abrimos el separador jobs para poder crear un job en el que especificamos que queremos trabajar con un cli (Bash)
  - job: clijob
  - deployment: DeployWeb ##Abrimos el deployment y lo declaramos como DeployWeb
    displayName: deploy Web App  ##Indicamos que queremos que en el pipeline se indique como "deploy Web App" en el pipeline
    pool: ##Añadimos un pool que contendra las imagenes que queremos desplegar 
      vmImage: 'Ubuntu-latest' ##Indicamos la imagen en especifico que queremos que despliegue en la subcat vmImage
    environment: authorization ##Enviroment sirve para que se ejecute una confirmacion en DevOps que no permita el despliegue sin una confirmacion manual
    strategy: ##Hasta steps haremos apertura de todos los separadores necesarios para ejecutar el task CLI2
      runOnce:
        deploy:
          steps:
          - task: AzureCLI@2
            inputs: ##Dentro de inputs declararemos varias cosas necesarias para el deploy
             azureSubscription: 'experiment' ##experiment es un service conexion que crea un puente entre Devops y las imagenes de azure
             scriptType: 'bash' ##En scriptType especificamos que vamos a trabajar con bash
             scriptLocation: 'inlineScript' ##En scriptLocation indicamos si el script esta en un archivo aparte o inline como es el caso.
             inlineScript: az vm create --resource-group RGlocalContext --name Alberto --image Win2022AzureEditionCore --public-ip-sku Standard --admin-username Martin --admin-password P@ssw0rd1234
## En el inline script creamos una maquina contenida en el rg RGlocalContext que se va a llamar Alberto que va a basarse en la imagen Win2022AzureEditionCore y en la que las credenciales son Martin t P@ssw0rd1234
