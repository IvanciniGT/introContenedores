# Contenedor

Entorno aislado donde ejecutar procesos dentro de un SO Linux

# Entorno aislado :
    FileSystem propio
        Se montaba en capas
            Capa base: Imagen del contenedor
            Segunda capa: Contenedor
            + Volumenes . Permiten 2 cosas:
                Persistencia de la información si se elimina un contenedor
                Compartir información entre contenedores
    Configuración RED
    Variables de Entorno
    Limitación de acceso a los recursos Hardware de la Maquina

Siempre que creamos un contenedor partimos de una IMAGEN DE CONTENEDOR

# Imagen de contenedor
    Un archivo zip con una estructura de archivos y carpetas
        La estructura de carpetas es similar a la de un filesystem de LINUX
        Entre ellas encontramos nuestro programa ya instalado, con sus configuraciones
    Configuraciones por defecto
    Información adicional: Qué puertos se usan por el proceso principal
                           En que carpetas se guarda la información dentro de el contenedor que se genere
    Esas imágenes de contenedor donde existen? A través de un repositorio => DOCKER HUB

Disponemos de gestores de contenedores:
    Programas que permiten descargar y controlar imagenes de contenedor
    Crear contenedores, borarrlos, arrancarlos
    Ejemplo: Docker, ContainerD, CRIO, Podman

Al instalar cualquiera de estos programas, que ocurre dentro de nuestro SO?
    Se me genera una red propia dentro del SO, para conectar los contenedores
    Si mis contenedores se conectan a esa red... quien podría acceder a ellos?
        Solo el HOST y el resto de contenedores.... y si quiero que acceda más gente?
            Hacíamos un Port Forwaring, a nivel del HOST < EXPONER UN SERVICIO que ofrezco a través del contenedor

Software: Programa:
    Aplicación:     Un programa que se ejecuta de forma indefinida en el tiempo, en primer plano e
                    interactuar con el usuario (persona humana)
                    --------------------------------------------------------------------------------- VVVVV
    Servicio:       Un programa que se ejecuta de forma indefinida en el tiempo, en segundo plano e
                    interactuar con otros programas
    Demonio:        Un programa que se ejecuta de forma indefinida en el tiempo, en segundo plano no
                    interactua con nadie. Él sabe lo que tiene que hacer.
    Script:         Un programa que se ejecuta de forma finita en el tiempo, no
                    interactua con nadie. Hace una serie de tareas preprogramadas y finaliza.
                    
De cara a interactura con los procesos que se ejecutan en un contenedor usamos un puerto: SERVICIO
    Serbidor WEB / Servidor de aplicaciones WEB, BBDD, INDEXADOR,...
Podría tener un contenedor que ejecute un programa con el que no interactuo:
    DEMONIO - SCRIPT


# Qué ventajas tiene el usar contenedores?
- Permiten generar entornos aislados consumiendo menos recursos que una MV
- Agilidad a la hora de hacer instalaciones/despliegues
    - Parto de una imagen que ya tiene todo listo para funcionar <<< Solo le añado algo de configuración por encima
    - Rápido + Fácil
- Al ser las imágenes de contenedor y los contenedores un ESTANDAR, da igual 
    la pp que tengan dentro que siempre los gestiono / opero de la misma forma
- Al existir ese nivel de estandarización puedo AUTOMATIZAR
- Y de hecho surgen programas que me ayudan a AUTOMATIZAR TODO:
    - Kubernetes / Openshift 
- Esto me ayuda a generar entornos facilmente ESCALABLES

# Quién va a usar contenedores y para qué?
--------------------------------------------------------------------------------vvvvv Kubernetes/Openshift
- Para instalar los servicios de la empresa en un entorno de producción /pre-prod
    DESARROLLO: Monta las imágenes de contenedor    >>>???>>>   PRODUCCION - SEGURIDAD: Hacer/Planificar/Configurar la instalación
- Para inatalar scripts o demonios en un entorno de producción
                 VVVVV      VVVV
                  ETL       Monitorización
--------------------------------------------------------------------------------vvvvv Docker-compose
- Desarrollador? Para montar su entorno de desarrollo (BBDD desarrollo, S. aplicaciones desarrollo)
- Testers         Generar un entorno donde poder hacer pruebas
                  Para instalar los propios programas con los que hace las pruebas
                    Me puedo instalar un entorno con Selenium Grid: Opera, Chrome, Firefox, en distintas versiones... 5 minutos
- Administrador de sistemas:
                    Terraform < Automatizar la contratación de servicios con un proveedor de Cloud
                    Ansible
                
App WEB del banco. Acceder a mis cuentas bancarias, hacer una transferencia, ver mis movimientos.
    Si pruebo una app web.... desde donde se va a usar esa APP WEB?
        Desde un navegador... cual?
            Chrome 91.0.4472.114..... 90 .... 85
            Edge
            Firefox
        En que versión vamos a tener el navegador?
        Desde qué plataforma?
            Windows?, Linux, MacOS, iPhone iOS, Android, Tablet...
    Esto no lo puedo hacer... no hay pasta
    
    AUTOMATIZAR. Tester >>> Programa (Selenium) >>> Selenium GRID: Conjunto de configuraciones 

----------------------------
Wordpress  <<< App web para montar sitios web
    Archivos.. que quiero que tengan persistencia
    Puerto...

BBDD
    Mariadb
        Directorio donde guardar los ficheros de BBDD
        Tambien trabaja en un puerto
        Password
        Nombre usuario
        
------------------------------------------------------------------------------------------------

Tienda ultramarinos                             <<<<<<<< Uno o varios contenedores... docker-compose
    - Local
    - Permisos
    - Luz agua
    - Proveedores
    - Caja registradora / TPV
    - Neveras
    - Productos / Inventario
    - Yo... a lo mejor tengo alguien por ahi para que me ayuda
    
-------------------------------------------------------------------------------------------------
                                                                                                usuario --> Navegador de internet (aplicación)
                                                                                                                VVVVVV
                                                                                                Cliente???? PROGRAMAS !!!!  USUARIO PERSONA HUMANA !!!
Supermercado                                                                    <<<<<<<< Cluster de Kubernetes
    - Cajas                                                                         <<<<<<    Servicio <<<<< Contenedores *** Web del banco
        - Muchas Cajas registradora / TPVs                                          <<<<<<    Recursos Hardware (infraestructra cpu, ram... gpu)
            - Cola
            - Cajeros   (perfil de empleado)                                        <<<<<<    Pod : Contenedor
        - Caja 1
            -                                                                       <<<<<<    Pod: Grupo de contenedores
                - Cajero/a                                                          <<<<<<       Contenedor   *** Apache Web Server
                - Embolsa                                                           <<<<<<       Contenedor   ***   FluentD | Filebeat  ----> Captura del accesslog del apache para mandarla a un ES y monitorizar los accesos a la web en tiempo real
        - Caja 2
                - Cajero/a                                                          <<<<<<       Contenedor   *** Apache Web Server
                - Embolsa                                                           <<<<<<       Contenedor   ***   FluentD | Filebeat  ----> Captura del accesslog del apache para mandarla a un ES y monitorizar los accesos a la web en tiempo real
        - Caja 3
                - Cajero/a                                                          <<<<<<       Contenedor   *** Apache Web Server
                - Embolsa                                                           <<<<<<       Contenedor   ***   FluentD | Filebeat  ----> Captura del accesslog del apache para mandarla a un ES y monitorizar los accesos a la web en tiempo real
    - Neveras (carne, pescado)                                                      <<<<<<    Volumenes <<<< Datos
    - Productos / Inventario
    - Preparación de sushi
    - Compra de colchones                                                           <<<<<<    Servicio muy sencillo... CRITICO, HA, Escalabilidad, Cola, DNS
    - Carnicería                                                                    <<<<<<    Servicio Publico!!!  *** Aplicación Web del Banco publica
        - Cartel que pone CARNICERIA                                                <<<<<<          NombreDNS
        - Maquina con numeritos / Pantalla donde vea el numero actual               <<<<<<          Balanceador de Carga
        - Mostradores                                                               <<<<<<    Volumenes
        - Puesto de trabajo (, cuchillos, picadora)
            - Tabla                                                                 <<<<<<    Volumenes
            - Carnicero                                                             <<<<<<    Pod: Contenedor <<< Atiende peticiones
        - Puesto de trabajo (tabla, cuchillos, picadora, bascula)
            - Carnicero                                                             <<<<<<    Pod: Contenedor
    - Pescadería                                                                    <<<<<<    Servicio            *** Aplicación que se usa desde las oficinas
        - Pescaderos
    - Frutería                                                                      <<<<<<    Servicio 
        - Fruteros
    - Empleados
    - Administración:                                                               <<<<<<    Servicio Privado !!! *** Base de datos Oracle
        Cartel:                                                                                   Nombre DNS
        Ticker... numericos, ... cola                                                             Balanceador
        Mesas:
            Administrativo                                                          <<<<<<    Pod: Contenedor
            Administrativo                                                          <<<<<<    Pod: Contenedor
    - IT....
    - Seguridad
        - Guardas de seguridad                                                      <<<<<<    Contenedor <<< Demonio
            - Tu estás trabajando en una puerta                                     <<<<<<    ConfigMap
            - Deja entrar una parsona cada 5 minutos
        - Guardas de seguridad                                                      <<<<<<    Contenedor <<< Demonio
            - Tu estás trabajando en una puerta                                     <<<<<<    ConfigMap
            - Deja entrar una parsona cada 5 minutos
        - Guardas de seguridad cuya misión es llevar la pasta de la caja fuerte     <<<<<<    Contenedor <<< Demonio
             a los que la recogen por la mañana                                     
            - Tu estas llevando pasta desde la caja fuerte
            - Clave de la caja fuerte (llave)                                       <<<<<<    Secret
    - Limpieza
        - Persona de limpieza                                                       <<<<<<    Contenedor <<< Demonio
        - Persona de limpieza                                                       <<<<<<    Contenedor <<< Demonio
        - Persona de limpieza                                                       <<<<<<    Contenedor <<< Demonio
    - Mantenimiento
    - Gerente !!!!!!!                                                               <<<<<<    KUBERNETES !!!!  <<< Mis intereses (INSTRUCCIONES)
    - Puerta (2) clientes                                                           <<<<<<    IngressController
        - Normas de uso                                                             <<<<<<    Ingress                  
    - Puerta proveedores                                                            <<<<<<    IngressController
        - Normas de uso                                                             <<<<<<    Ingress
    - Reglas de seguridad acerca de quien puede ir por donde dentro de la tienda    <<<<<<    NetworkPolicy (Firewall a nivel de red)



-----

Cluster de Kubernetes / Openshift --- 4 nodos gorditos

4 Clusters de 50 nodos
-------------------------------------------------------------------------
2 cluster de produccion redundantes wen zonas geograficas diferentes
2 cluster de pre.produccion redundantes wen zonas geograficas diferentes
    
Administradores que sepan un huevo y medio de Kubernetes/Openshift



--------
Operar el cluster   <<<< Kubernetes    <<<< Reglas que definan unos operadores (seguridad)
    Quienes son mis proveedores de volumenes preferido
    Reglas de seguridad
    Limitaciones en cuanto a los recursos que pueden usarse por parte de las aplciaciones
    Clasificando los tipos de nodos

Instalar apps /servicios en el cluster <<<< ???
                                            Jenkins (otro programa AUTO) muy largo plazo
                                            
        Desarrolladores hacen las apps  >>> codigo >>> gitlab
                                                            Dockerfile >>       ESTOS SCRIPTS HAY QUE MONTARLOS?
                                                                                quien los monta?
                                                                                    Desarrollo <<< 
                                                                                    Devops     <<<
                                                                imagen de contenedor
                                                                    Archivos de despliegue en Kubernetes
                                                                                QUIEN LO PREPARA?
                                                                                    Devops Produccion <<<<
                                                                        Values->        CHARTS DE HELM -> para distintos entornos
                                                                                    Estos son los que hablaran con Kunernetes


--------
Ordenador externo
     Cliente de kubernetes
        kubectl
        oc
        rancher
        ---> Instala una aplciacion
        ---> Escala una aplcación ahora... quiero 5 replicas
        ---> Escala una aplciacion segun unas reglas automaticamente
        ---> Quiero aplicar una determinada politica de red
            TODAS las instrucciones serán entregadas mediante ficheros YAML >>>>> GITlab  >>>>> Jenkins >>>> kubectl

Cluster de Kubernetes / Openshift
    Conjunto MAQUINAS físicas o virtuales donde tengo funcionando un producto que se llama KUBERNETES
    
    Maquina M0 - ControlPlane Kubernetes
    Maquina M1 - ControlPlane Kubernetes
                        BBDD: etcd
                        DNS: coreDNS
                        
    
    Maquina 1 --- más RAM
        SO Linux
            Docker, CRIO, ContainerD
            Kubernetes
            POD2_replica 1 - tomcat--- Web del banco
    Maquina 2 --- más CPU
        SO Linux
            Docker, CRIO, ContainerD
            Kubernetes
            POD1-replica 1 - mariadb       <<<<<< Volumenes
            POD2_replica 2 - tomcat--- Web del banco
    Maquina 3 --- GPUs
        SO Linux
            Docker, CRIO, ContainerD
            Kubernetes
            POD1_replica 2 - mariadb
    ....
        SO Linux
            Docker, CRIO, ContainerD
            Kubernetes
    Maquina N
        SO Linux
            Docker, CRIO, ContainerD
            Kubernetes

Proveedor de Volumenes Externo
    Cloud
    On premisses
        Cabinas de almacenamiento
        iscsi
        nfs

# POD:
    Conjunto de contenedores que tienen en comúm:
        - Kubernetes me va a asegurar que esos contenedores se instalan en la mismo NODO (máquina "física")
        - Kubernetes me asegura que se escalan de la misma forma
        - Kubernetes me permite que compartan volumenes de información no persistente (también persistente)
        - Todos los contenedores de un POD tienen una única dirección IP
            Entre ellos hablan usando la palabra: localhost

NAMESPACE:    Desarrollo   |    Produccion   | Preproducción    |   Cliente 1   | Cliente 2
    Servicio BBDD <<< Balanceador de carga
        POD MDB 1: C1: MariaDB * <<<|    MariaDB cluster
        POD MDB 2: C1: MariaDB   <<<|
        POD MDB 3: C1: MariaDB   <<<|
      ^^
    Servicio de Tomcat 
        POD TOMCAT 1: C1: Tomcat
                            context.xml  <<<< Propio fichero context.xml se inyectaría en el FileSystem del contenedor desde un Secret
                                Connection Pool 
                                    JDBC: URL Conexión: A que apunto aquí!
                                            URL del servicio: Nombre DNS 
                            Generar un fichero access_log  <<<< VOLUMEN KUBERNETES TIPO DE VOLUMEN: RAM 
                      C2: FileBeat | Fluentd >>> ES
        POD TOMCAT 2: C1: Tomcat  
                            Generar un fichero access_log  <<<< VOLUMEN KUBERNETES TIPO DE VOLUMEN: RAM
                      C2: FileBeat | Fluentd >>> ES
        POD TOMCAT 3: C1: Tomcat  
                            Generar un fichero access_log  <<<< VOLUMEN KUBERNETES TIPO DE VOLUMEN: RAM
                      C2: FileBeat | Fluentd >>> ES
        POD TOMCAT 4: C1: Tomcat  
                            Generar un fichero access_log  <<<< VOLUMEN KUBERNETES TIPO DE VOLUMEN: RAM
                      C2: FileBeat | Fluentd >>> ES
        POD TOMCAT 5: C1: Tomcat                      
                            Generar un fichero access_log  <<<< VOLUMEN KUBERNETES TIPO DE VOLUMEN: RAM
                      C2: FileBeat | Fluentd >>> ES
        POD TOMCAT 6: C1: Tomcat                      
                            Generar un fichero access_log  <<<< VOLUMEN KUBERNETES TIPO DE VOLUMEN: RAM
                      C2: FileBeat | Fluentd >>> ES
        
    
    
    ElasticSearch+Kibana < MAPA / Monitorización de los accesos: las WEBs
    
    Los PODS en Kubernetes tienen un nombre... un identificador... ese nombre no es un nombre DNS
    Los SERVICES en Kubernetes tienen un nombre.... un identificador... que es además nombre DNS
    
    Algunos tipos muy especiales del PODS... pueden tener asociado un servicio
        A esos pods se les podrá referencias mediante un nombre DNS del tipo: pod1.servicio1  <<<<< ESearch
        
    El servicio de Kubernetes de la BBDD que esté publicado para que se accesible externamente
    
    
    ----
    
Cluster de Kubernetes    
    Máquina 1
    Máquina 2
    
    
    
Service mess
         VV
Service mesh < Istio , Linkerd


---


Gestión de APIs
Apigee


-
-----


Servicios / Microservicios   <<<<< Servicios con un nivel de acoplamiento muy debil
  ^^^ SOA --- SOAP Servicios con un nivel de acoplamiento muy rigido 
Aplicación monolitica