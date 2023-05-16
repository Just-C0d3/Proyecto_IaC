# Proyecto_IaC
En este pipeline yml se hace lo siguiente: 
  -Se comprueba si el servicio IIS y sus roles estan asignados, en caso de que no sea asi estos se instalaran.
  -Se crea una AplicationPool para la pagina web
  -Se crea una pagina web 
  -Se crea un directorio virtual conectado a la web
  -Se modifican los parametros del Default Document para que admitan index.aspx como una opcion valida
  -Se sincroniza el documento Index.aspx local con su version subida en un repositorio 
  -Se crea un Binding para el puerto 8087
