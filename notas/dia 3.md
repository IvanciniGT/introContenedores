Kubernetes
------------------------------------------------------------
Tener servivios en un entorno seguro y aislado y controlado         <<<< No lo hacía ya docker? ..... :(
Automatización de controles de containers                           <<<< Docker algo también a este respecto

Permitirnos controlar/automatizar el despliegue y operación de servicios en un entorno PRODUCTIVO
    - Escalanilidad
    - Alta disponibilidad

Capa de abstracción sobre la infraestructura que tenemos:
    - Máquinas
    - Redes
    - Volumenes de almacenamiento
    
Perfiles:
-------------------------------------------------------------
Desarrollo: 
    El resultado del desarrollo debe ser una IMAGEN DE CONTENEDOR
    Además, nuestros desarrolladores deben tener en cuenta que su app va a ser ejecutada dentro de un contenedor:
        Identificar los distintos volumenes de almecamiento que su app requiere
            Necesito almacenamiento para guardar tales o cuales datos... que tengo en "esta carpeta"
                Logs <<<< Tal tipo de almacenamiento
                Ficheros con datos (base de datos... otros) <<<< Tal otro tipo de alcenamiento
        Configurar mi app:
            Configurar mi app desde variables de entorno
            Ficheros de configuración <<<<< También los que tengo que tener bien identificados
        Mi app puede ser parada / iniciada en cualquier momento
        Todas las dependencias de mi app
    ---> Generando una IMAGEN DE CONTENEDOR (Dockerfiles, bash)
                                                ^^^^ Quien hace esto?
                                                        Desarrollador
                                                            ^^^^
                                                        Equipo "Devops"
                                                        Que lo haga una herramienta externa que hayamos configurado: <<< Hay que configurarlo
                                                            source2Image <<< Openshift
    A la hora de montar una imagen de contenedor (DOCKERFILE, BASH):
        1 - Partimos de una imagen base de SO
            Esa imagen base NO CONTIENE UN SO (No contiene el KERNEL DEL SO)
            Contiene utilidades básicas y la estructura basica del FileSystem
                /bin
                    ls, mkdir, bash, sh
                    UBUNTU: apt, apt-get
                    FEDORA: yum
                /lib
                /etc
                /var
                /home
                /tmp
                /opt
        2 - Montamos ahí las dependencias de mi app
            Depende de la imagen que use.... apt, yum, ....
        3 - Configuraciones que necesite mi app
            Inyectar archivos que tenga yo ya creados
        4 - Instalo dentro mi app
            Copiar archivos dentro de alguna carpeta     /opt
        5 - Configuraciones de mi app
            Crear variables de entorno
            Copiar fichero de conf de mi app             /etc
        6 - Explicitar el funcionamiento de la imagen:
            Uso los siguientes directorios de forma estandar para guardar los datos:
                - Directorio 1                           /var <<<   logs    datos persistente
                - Directorio 2
            Cual es el comando que arranca mi programa desde linea comandos
            En qué puertos trabaja mi app
    Nuestra imagen >>> REPOSITORIO DE IMAGENES

---> Lo quiero llevar a Kubernetes     
    Esto lo hará:
        - Producción "devops"
        - Desarrollo
    Necesito montar un descriptor de Kubernetes YAML
        PODS - Mis contenedores    <<<  DEPLOYMENT
        SERVICES - Nombre DNS + Balanceador de carga
        CONFIGMAPs / SECRETs
        INGRESS  < Configuraciones para un reverse proxy que permitían publicar mi servicio fuera del cluster
        PERSISTENT VOLUME CLAIM
            PETICION DE VOLUMEN 
            NECESITO UN VOLUMEN DE ALMACENAMIENTO:
                Espacio: 20Gb
                Tipo de alcenamiento: REDUNDANTE, RAPIDITO, NO REDUNDANTE, LENTO
        HPA
    Montar un CHART DE HELM ----> Un programa que genera esos YAML por nosotros
    
---> Instalo dentro de Kubernetes
    Quién lo hará?
        - Desarrollo
        - Devops
        - Operadores del cluster
        - Jenkins **

--->  Disponer de un cluster
        Instalar y configurar un cluster de Kubernetes
        Mantenerlo / Operar
        
        
-----------------------------------------------------------------------
Cual es la minima unidad de gestión en Docker?          Contenedor
Cual es la minima unidad de gestión en Kubernetes?      PODs

Pero de hecho, NUNCA JAMAS vamos a crear un pod en Kubernetes
Si creo un POD.... que pasa si el pod se cae, se borra, me quedo sin pod.
Que pasa si lo quiero escalar.... Crear otro POD

El concepto con el que trabajamos realmente en KUBERNETES es el concepto de PLANTILLA DE POD

Deployment
    Plantilla de POD
    Número de replicas INICIAL que quiero de esa plantilla
StatefulSet
    Plantilla de POD
    Plantilla(s) de Petición de volumen
    Número de replicas INICIAL que quiero de esa plantilla
DaemonSet
    Plantilla de POD
    No doy el numero de replicas que quiero: Va a montar un pod en cada nodo de mi cluster



Balanceador
nginx                  Tomcat
apache                 Tomcat
haproxy                Tomcat


iptables    >>>> netFilter

He creado el pod desde un deployment al que he configurado solamente 1 replica

Maquina 1 
Maquina 2
Maquina 3 
Maquina 4 
    Pod:
        nginx: CPU 50% - 20 segundos                        Cluster? Activo-Pasivo

HA? SI
    99%     99,9% ---> 7-8 horas al año down    99,99%
Escalabilidad?


Servicio 
    Pod: nginx 25% 
    Pod: nginx 25% 
    Pod: nginx 25% 
    Pod: nginx 25% 

Weblogic



------------------------------------------
Wordpress
    Apache < php       <<<<<<<<<<    Container

MariaDB                <<<<<<<<<<    Container


Ki:  Kibibyte
Mi   Mebibyte
Gi : Gibibyte

YA NO
1 Gb  =   1000  Mb  = 1000x1000 Kb = 1000x1000x1000 bytes

1 Gi  =   1024  Mi  = 1024x1024 Ki = 1024x1024x1024 bytes



Limitación de recursos:
cpu: 300m

Cuanta cpu puedo usar cada segundo de tiempo
300m : 300 ms de 1 cpu cada segundo
1300m : 1,3 cpus / segundo
            me den 1 cpu entera para mi... y de otra un tercio cda segundo
            me den 0,5 cpus 2 veces y un tercio de otra cada segundo







Linea 81    iavn
Linea 85    password
Linea 102  Mi superblog!!!!
Linea 451: ClusterIP (Servicio PRIVADO)


Linea 778 781 < password

--------

helm Siempre se usa:
    Estos son los que prevalecen --set PROPIEDAD_CONCREAT=VALOR_CONCRETO
    Sobre ese se modifican los valores que tu pases en un propio fichero -f
        Informacion de WORDPRESS    <<<<<
        Informacion de MARIADB      <<<<<
        Informacion de KUBERNETES   <<<<< Configuracion distinta de kubernetes (otro cluster... prudccion/preproduccion)
        
    values.yaml que exista en el repo del chart


---------

He montado un Wordpress y un mariadb
POD Mariadb
POD Wordpress
.... cómo sabe kubernetes si siguen en funcionamiento o si debe de reiniciarlos...???
Qué está monitorizando Kubernetes?
   Por defecto, si yo no digo nada... Kubernetes mira si el proceso PRINCIPAL (command) asociado al contenedor está en marcha
   Podría ser que yo tuviera un apache... cuyo proceso esté en marcha... pero que no responda a las peticiones... SI
---
    Pruebas para la monitorización de procesos... pruebas que se van a ejecutar periodicamente
    Startup Probe --- Me sirve para ver si el contenedor ha arrancado bien
        Si falla. Decición de kubernetes?
            Recrear el pod
    Lifeness Probe -- Sirve para comprobar si el contenedor sigue vivo?
        Si falla, que va  hacer kubernetes? 
            Recrear el pod
    ReadinessProbe -- Me sirve para determinar si YA está listo para prestar servicio
        Si falla, que va a hacer kubernetes?
            Lo saca del Balancedor 
        
        ejecuta un comando sh
        ejecuta una conexión por tcp a un puertos
        ejecuta una conexión por http a una url... y si te un codigo de respuesta >= 400 ... es que está fallando



Quien sea el responsable del cluster DPTO 1-300
    Instalación y operación más bajo nivel del cluster (Openshift-kubernetes)
    Operadores del cluster                             (Openshift-kubernetes)
    
Sistema de Almacenamiento < Cabinas de almacenamiento *** / backups

Monitorización no del cluster... apps <<<<<

Equipo devops 
    Preparar todo para que entre al kubernetes/openshift HELM
    IMAGEN DE CONTENEDOR desde repos git                DOCKER BUILD
    
Seguridad <<<<< ISTIO

Desarrollo >> Directrices
    Volumenes
    Env
    Secrets