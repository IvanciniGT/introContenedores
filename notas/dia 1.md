# Contenedores

Entorno aislado dentro de un SO LINUX donde poder ejecutar procesoS.


App1        | App2
-------------------------
C1          |    C2
-------------------------
    Gestor de Contenedores (Docker (estandares), Podman - CRIO, ContainerD)
-------------------------
         SO LINUX
-------------------------
          HIERRO V
          Hipervisor  ?
          SO          ??
          Hierro      ???
  
 Problemas: Unas apps pueden afectar a otras
            Seguridad

Entorno aislado:
    Cada contenedor tendrá:
        - Su propio FileSystem (HDD)
        - Su propia conexión(es) a red
        - Su propio entorno de ejecución (env)
        - Limitación de acceso a recursos
        
# Imagen de contenedor < Desarrollo
    Fichero ZIP que dentro lleva una aplicación YA INSTALADA
        FileSystem similar al de cualquier SO Linux:
            /
                bin
                    mkdir
                    ls
                lib
                opt
                    programa YA INSTALADO
                etc
                    configuraciones de mi programa
                home
                var
                    /datos
                tmp
    Junto con una configuración por defecto
        environment: Variables de entorno
        proceso que debe arrancarse como proceso principal dentro del contenedor: que programa, que comando
    Datos informacionales
        La aplicación funciona en el puerto 80
        Dentro del contenedor los datos de la aplicación se van a guardar en tal determinada carpeta
        
Las creamos con ayuda de programas como DOCKER

Al descargar una imágen de contenedor:
    Descargado un ZIP
    Descomprimido el ZIP
    
    

HOST
/
    bin
    lib
    home
        /ubuntu
    opt
    var
        /lib
            /docker
                /images...IMAGEN --- chroot
                            /bin
                            /lib
                            /etc
                                /nginx
                                    nginx.conf
                            /tmp
                            /home
                            /var
    tmp


----
Docker Inc. 2013
    Docker engine:
        CE : Opensource y gratuita, Siguendo estándares, que ellos fueron montando.
            Redhat, AWS, GCL, Microsoft
        EE : Hoy en día no es de Docker Inc. ---> Mirantis... Esto no lo usa nadie
    Docker For Mac
    Docker For Windows
    Docker hub
        2 formas de uso:
            Gratuitamente: Pero aceptando que las imagenes que subes pueden ser descargadas por cualquier persona (publicas)
            Subscripción de pago: Se me permite subir imagenes privadas, con distribución controlada
            
    ContainerD: Es quien realmente gestiona imagenes de contenedor y crea contenedores

---------------
Dev-->Test->Adm-> Inst->Sec-> Ops No es/era un perfil de una persona dentro de una organización
CI
CD
AUTOMATIZAR TODO lo que pueda ser automatizado

----------------
Metodologías ágiles

Entorno de Producción:
- Alta disponibilidad - Redundancia
- Escalabilidad: Capacidad de ajustarse a las necesidades de cada momento
- Seguridad <<<< En todos los entornos


Montamos Clusters
    Activo-Pasivo
    Activo-Activo

Dia 1 - 100 usuarios
Dia 30 - 200 usuarios
Dia 100 - 300 usuarios


Dia n    - 100 usuarios
Dia n+1  - 1000000 usuarios - Black Friday <<<<<
Dia n+2  - 3000 usuarios
Dia n+3  - 800000 usuarios -  Ciber monday

Infraestructura - Alquilo (Proveedor de cloud)  - Automatizado

Kubernetes/Openshift < Controlar un cluster de máquinas y automatizar en ellas:
    Depliegues de apps
    Y su operación (monitorización, escalado,...)
    
Docker crea un red virtual dentro del host, en la que "pinchan" los contenedores

HOST: Interfaces de red:
    ethernet
    loopback -< 127.0.0.1 - localhost
    docker
    
    
## FileSystem de un contenedor está montado mediante capas superpuestas

                    VVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVV

VOLUMEN
                                                            /datos (TIENE PERSISTENCIA EN OTRO SITIO)   ----> HOST /home/misdatos
                                                                Mis ficheros de BBDD
CARPETA CONTENEDOR:     /bin            /home               /datos
                         ls xxx           saluda.txt            
CARPETA IMAGEN:         /bin    /lib    /home    /var    /etc    /opt           * ES INTOCABLE
                         ls
                         bash
                         
MySQL MariaDB OracleDB 


Red:
    Que la IP Cambie  <<< DNS
    Donde se ha montado la red de docker? Dentro del HOST
    Quién podrá acceder a la IP de un contenedor?
        Cualquiera que esté conectado a esa red....
        ¿Quién está conectado a esa red?
            Los contenedores que estén arrancados... y quién más?
            HOST
            Alguien más? NO
        Y si quiero que acceda un cliente externo?
    
    
Internet IPPublica 82.12.34.56 - ROUTER - 192.168.1.1  - RED PRIVADA - 192.168.1.2:80 SERVIDOR (web)
Redireccion de puertos: NAT
    Cuando se pida algo en el puerto 80 (u otro que configure) de la IP Publica 82.12.34.56
        reenvia esa petición a: 192.168.1.2:80
    
Docker, dentro de esa red virtual que monta docker, crea un Servidor de DNS, que se AUTOCONFIGURA

Lo que os he contado hasta ahora de la red y de los volumenes, nos vale para un entorno de producción?
    Cluster - Ejecución de procesos
    Volumenes con almacenamiento redundante

2 Nodos (maquinas):
    Ser maligno vikingo con cuernos y gorro de pirata
    Maquina 1   IP PUBLICA : 8080 -> C1: 172.17.0.2:8080
        IP DE LA RED DE KUBERNETES: 172.17.0.2 - C1: Tomcat (Servidor de apps web Java): Puerto 8080: Accesible el mundo
    Maquina 2   IP PUBLICA : 1521 -> C1: 172.17.0.3:1521
        IP DE LA RED DE KUBERNETES: 172.17.0.3 - C2: OracleDB Puerto: 1521: Accesible por el Tomcat

Cuando instalo DOCKER se me genera un rad virtual dentro de mi maquina

Cuando instalo KUBERNETES se me genera una red virtual intermaquinas del cluster


Maquina 1                                 LB           DNS        CLIENTE
    C1: IP1 Tomcat: 8080  <<<< C1:8080 IP3:8080       <<<<<
Maquina 2  PUF !
    C2: IP2 Tomcat: 8080  <<<< C2:8080 xxxx
Maquina 3
    C3: Tomcat: 8080
    
      Cluster
HTTPs<<<<<<  MS1->
               HTTPs     MS2             -> SQLServer
               HTTPs     MS3-> 
                             HTTPs MS4
mTLS

HTTPS: Frustra 2 tipos de ataques
    Man in the middle - Encripción
    Phishing          - Suplantación de identidad - Certificados firmador por entidades certificadores de confianza

Openshift -< Distribución de Kubernetes

Kubernetes es opensource y GRATUITO <<< Google
Openshift  es opensource? SI como todo producto de redhat
           es gratuito? SI Openshift Origin  
                        NO Openshift Container Platform


Fedora---> RHEL
minikube


Desarrolladores
    Código JAVA Entorno de desarrollo (Editor Eclipse, IntelliJ, Netbeans)
        ---> Repo SCM : Git -> Gitlab
                                ^^^
            Jenkins/ GitlabCI/Bamboo/AzureDevs / Servidor CI/CD
                Arrancar el proceso de depspliegue de la app en entorno de pruebas
                Descargar en algun sitio el codigo del desarrollador,
                    Va a pedir que se empaquete como proyecto JAVA : MAVEN, GRADLE, ANT   <<<< DESARROLLADOR
                    Va a pedir que se genere una imagend e contenedor: Docker (Dockerfile)  >> DESARROLLADOR
                    Esa imagen de contenedor la subiremos a otro REPO de artefactos
                    Jenkisn le pedira por ejemplo a Kubernetes que instale en un NAMESPACE de pruebas
                        la aplciación (imagen de contenedor) - Archivos de despliegue en Kubernetes (YAML) <<< HELM <<< Chart DESARROLLADOR
                    Se le aplicarán unas pruebas automatizadas: SOAPUI, POSTMAN, SELENIUM,... JMETER, LOADRUNNER Testers
                    Si todo ha ido bien.... DECIDIMOS 
                    A lo mejor me quedo aquí <<<<<<<<<<<<< Integración Continua - CI
                    Automatizar la puesta en disposición del artefacto (Imagen, Chart) en manos del cliente final (interno/externo)
                        -> CD Continuous Delivery
                    Le automatizo la instalación en un entornode producción:
                        -> CD Continuous deployment
                        Contratar infra nueva.... Aprovisionarla...
                            Terraform       Vagrant        Ansible
            Monitorizar todo en automatico
                Prometheus/grafana
                ElasticSearch/Kibana
                Istio/Kiali