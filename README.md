# bennuproject
Repositorio para las pruebas de bennu.

## Lista de actividades:

- [x] Crear una máquina virtual con terraform sobre el free tier de AWS.
- [x] Provisionar docker-engine con ansible en tu máquina virtual creada
- [x] Desplegar el container de kong-ce sobre la máquina virtual.
- [x] Buscar o codificar un servicio que retorne un mensaje (HelloWorld), luego Dockerizar la app y crear un API en kong que haga una llamada al servicio.
- [x] Hacer un script que ejecute los cuatro puntos anteriores.

### Pasos para la actividad 1.

##### Requerimientos:

<ul>
<li>Instalar Terraform</li>
<li>Instalar Ansible</li>
<li>ACCESS y SECRET KEY de una cuenta en AWS</li>
<li>IAM User debe tener permisos en EC2</li>
</ul>

##### Variables de entorno:

<ul>
<li><code>export TF_VAR_aws_ak="AWS ACCESS KEY"</code></li>
<li><code>export TF_VAR_aws_sk="AWS SECRET KEY"</code></li>
<li><code>export TF_VAR_aws_region="AWS REGION"</code></li>
<li><code>export TF_VAR_ec2_name="AWS SERVER NAME"</code></li>
<li><code>export TF_VAR_ec2_ami_id="AWS AMI ID"</code></li>
<li><code>export TF_VAR_ec2_sg_name="AWS SECURITY GROUP NAME"</code></li>
</ul>

> Para el tema de AMI, se sugiere usar: ami-0a7d051a1c4b54f65 (Ubuntu 18.04)

#### Pasos a seguir:

> Si solo se quiere ejecutar esta actividad 1 (Terraform)

<ol>
<li>Clonar repositorio</li>
<li>Configurar variables de Entorno</li>
<li>Ingresar al directorio terraform</li>
<li>Ejecutar: </li>
<ul>
<li>terraform init</li>
<li>terraform plan</li>
<li>terraform apply</li>
<li>terraform destroy - Para eliminar todos los recursos que se crearon</li>
</ul>
</ol>

### Pasos para la actividad 2 (Ansible)

Son los mismos pasos que se ejecutaron para la primera actividad ya que solo se usa Ansible para instalar y configurar Docker.

##### Variables de entorno:

<ul>
<li><code>export TF_VAR_ec2_key_pub="Llave Pública"</code></li>
<li><code>export TF_VAR_ec2_key_priv="Llave privada"</code></li>
</ul>

La llave publica y privada que se usaran para gestinar los recursos creados en AWS EC2 con Ansible.

##### Verificar:

Si todo se ejecuto correctamente se va a tener un output parecido a:

![Drag Racing](https://minecraftbox-extras.s3.amazonaws.com/output-task-1.png)

### Pasos para la actividad 3 (Docker kong-ce)

Se repite lo mismo que en la actividad 1 - 2 solo que ahora se agregan uno pasos y requerimientos adicionales.
*(No tienen que usar el comando terraform destroy ya que se van a necesitar los recursos creados).*

##### Requerimientos:

<ul>
<li>Instalar AWS CLI</li>
</ul>

##### Variables de entorno:

<ul>
<li><code>export AWS_ACCESS_KEY_ID=$TF_VAR_aws_ak</code></li>
<li><code>export AWS_SECRET_ACCESS_KEY=$TF_VAR_aws_sk</code></li>
<li><code>export AWS_DEFAULT_REGION=$TF_VAR_aws_region</code></li>
</ul>

En estas nuevas variables de entorno solo se asignan los varoles previamente asignado a las variables que se usaron para Terraform.

##### Pasos a seguir:

<ol>
<li>ansible-playbook ./infrafacts.yml -v</li>
<li>ansible-playbook ./inventoryaws.yml  -v</li>
<li>ansible-playbook --ssh-common-args='-o StrictHostKeyChecking=no' -i awshosts ./kongce.yml -v </li>
</ol>

- El primer comando va a generar la llave privada usando la variables de entorno TF_VAR_ec2_key_priv
- El segundo comando va a generar un archivo (awshosts) con la lista de IPs públicas que tengan el tag Name que se asigno a la variable TF_VAR_ec2_name.
- El tercer comando, se le pasa como listo de host el archivo previamente creado y se comienza a ejecutar las tareas necesarias para que se tenga activado un contenedor con kong (red, base de datos y contenedor para la app).

### Pasos para la actividad 4 (Docker hello api - kong-ce)

Se repite lo mismo que en la actividad 1, 2 y 3 solo que ahora se agregan uno pasos y requerimientos adicionales.
*(No tienen que usar el comando terraform destroy ya que se van a necesitar los recursos creados).*

##### Pasos a seguir:

<ol>
<li>ansible-playbook --ssh-common-args='-o StrictHostKeyChecking=no' -i awshosts ./apitask.yml -v v</li>
</ol>

El comando que se ejecuta primero se conecta a los servidores que estan en el archivo awshosts. Luego descarga la imagen del servicio rest hellobennugo (Se uso Go). Por ultimo se agrega el servicio y ruta a kong.

- Docker Repo: https://hub.docker.com/r/martip07/hellobennugo
- Github Repo: https://github.com/martip07/hellobennugo

##### Verificar:

Se puede verificar en: EC-IP-PUBLICA:9000/api/hello

![hellobennugo](https://minecraftbox-extras.s3.amazonaws.com/output-task-4.jpg)

### Pasos para la actividad 5 (Script para automatizar tareas)

Es un script que automatiza la gestion de configuracion de la mayoria de variables y actividades.

*(El script no cubre la opción para eliminar todo lo que se tiene (PENDIENTE) asi que se debe de eliminar manualmente).*

##### Variables Obligatorias a configurar:

<ul>
<li><code>export TF_VAR_ec2_key_pub="Llave Pública"</code></li>
<li><code>export TF_VAR_ec2_key_priv="Llave privada"</code></li>
</ul>

##### Pasos a seguir:

<ul>
<li>sh bennuscripts.sh</li>
<li>Agregar las variables que solicita.</li>
<li>Prepara un cafe ☕ y espera un momento.</li>
</ul>

*(Si desean eliminar todo lo que tienen y quieren usar terraform solo configuren las variables de entorno y ejecuten terraform destroy en la carpeta terraform).*