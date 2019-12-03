# bennuproject
Repositorio para las pruebas de bennu.

## Lista de actividades:

- [x] Crear una máquina virtual con terraform sobre el free tier de AWS.
- [x] Provisionar docker-engine con ansible en tu máquina virtual creada
- [ ] Desplegar el container de kong-ce sobre la máquina virtual.
- [ ] Buscar o codificar un servicio que retorne un mensaje (HelloWorld), luego Dockerizar la app y crear un API en kong que haga una llamada al servicio.
- [ ] Hacer un script que ejecute los cuatro puntos anteriores.

### Crear una máquina virtual con terraform sobre el free tier de AWS.

#### Requerimientos:

<ul>
<li>Instalar Terraform</li>
<li>Instalar Ansible</li>
<li>ACCESS y SECRET KEY de una cuenta en AWS</li>
<li>IAM User debe tener permisos en EC2</li>
</ul>

#### Variables de entorno:

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

> Si solo se quiere ejecutar esta actividad 2 (Ansible)

Son los mismos pasos que se ejecutaron para la primera actividad ya que solo se usa Ansible para instalar y configurar Docker.

#### Variables de entorno:

<ul>
<li><code>export TF_VAR_ec2_key_pub="Llave Pública"</code></li>
<li><code>export TF_VAR_ec2_key_priv="Llave privada"</code></li>
</ul>

La llave publica y privada que se usaran para gestinar los recursos creados en AWS EC2 con Ansible.

#### Verificar:

Si todo se ejecuto correctamente se va a tener un output parecido a:

![Drag Racing](https://minecraftbox-extras.s3.amazonaws.com/output-task-1.png)

> Pasos para la actividad 3 (Docker kong-ce)

Se repite lo mismo que en la actividad 1 - 2 solo que ahora se agregan uno pasos y requerimientos adicionales.
*(No tienen que usar el comando terraform destroy ya que se van a necesitar los recursos creados).*

###### Requerimientos:

<ul>
<li>Instalar AWS CLI</li>
</ul>

###### Variables de entorno:

<ul>
<li><code>export AWS_ACCESS_KEY_ID=$TF_VAR_aws_ak</code></li>
<li><code>export AWS_SECRET_ACCESS_KEY=$TF_VAR_aws_sk</code></li>
<li><code>export AWS_DEFAULT_REGION=$TF_VAR_aws_region</code></li>
</ul>

En estas nuevas variables de entorno solo se asignan los varoles previamente asignado a las variables que se usaron para Terraform.

###### Pasos a seguir:

<ol>
<li>ansible-playbook ./infrafacts.yml -v</li>
<li>ansible-playbook ./inventoryaws.yml  -v</li>
<li>ansible-playbook -i awshosts ./kongce.yml -v </li>
</ol>

- El primer comando va a generar la llave privada usando la variables de entorno TF_VAR_ec2_key_priv
- El segundo comando va a generar un archivo (awshosts) con la lista de IPs públicas que tengan el tag Name que se asigno a la variable TF_VAR_ec2_name.
- El tercer comando, se le pasa como listo de host el archivo previamente creado y se comienza a ejecutar las tareas necesarias para que se tenga activado un contenedor con kong (red, base de datos y contenedor para la app).