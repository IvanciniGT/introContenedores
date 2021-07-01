# Comando docker

docker TIPO_OBJETO OPERACION argumentos

# Imagenes

## Descargar imagenes de contenedor en nuestro host

docker image pull IMAGEN:TAG                                >>>> docker pull IMAGEN:TAG

## Listar imagenes de contenedor que tengo en mi ordenador

docker image list                                           >>>> docker images

## Borrar una imagen de mi host

docker image rm ID                                          >>> docker rmi ID

# Contenedores

## Crear un contenedor

docker container create --name NOMBRE <args> IMAGEN
    args:
        volumenes                -v ruta_host:ruta_contenedor
        variables de entorno     -e VAR=VALOR
        redirecciones de puertos que quiero tener
                                 -p IP_HOST:PUERTO_HOST:PUERTO_CONTENEDOR
        # usuario                  -u usuario que ejecutará el comando principal ( y en cuyo enviroment se establecerán la vars de entorno)


docker exec NOMBRE_CONTENEDOR <args> comando
    usuario -u root
    
## Listar los contenedores en ejecución

docker container list                                       >>> docker ps

## Listar todos los contenedores 

docker container list --all                                 >>> docker ps --all

## Arrancar el contenedor

docker container start NOMBRE                               >>> docker start NOMBRE

## Dame los detalles de un contenedor

docker container inspect NOMBRE                             >>> docker inspect NOMBRE

## Muestra el log de un contenedor

docker logs NOMBRE

## Eliminar un contenedor

docker rm NOMBRE

## Parar el contenedor

docker container stop NOMBRE                               >>> docker stop NOMBRE

# Todo en 1

docker run --name mi-nginx nginx:VERSION [:latest]

Pull de la imagen
Container create
Container start
Logs <<< Atrapado en la consola

## Ejecutar un proceso/programa dentro de un contenedor

docker exec NOMBRE_CONTENEDOR COMANDO arg