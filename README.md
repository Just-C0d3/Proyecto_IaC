# Proyecto_IaC
Sumario del codigo empleado en el despliegue del proyecto
Este es un despliegue complejo de terraform a traves de pipeline, tiene como resultado la creacion de : 
  -Una red (10.0.0.0/16) 
  -Una subred (10.0.1.0/24)
  -Un nsg con reglas de filtrado de puertos en el trafico de la subred.
  -3 ips publicas
  -3 network interfaces
  - 1 cliente w11 
  - 2 servidores ws2022
 
 Algunos datos relevantes a destacar sobre este despliegue son: 
 El despliegue ha sido completamente parametrizado, permitiendo asi la reutilizacion del codigo
 Con el fin de optimizar el tamaño de nuestro codigo se han empleado variables map(object)
 
