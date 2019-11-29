# bennuproject
Repositorio para las pruebas de bennu.

## Lista de actividades:

- [x] Crear una máquina virtual con terraform sobre el free tier de AWS.
- [ ] Provisionar docker-engine con ansible en tu máquina virtual creada
- [ ] Desplegar el container de kong-ce sobre la máquina virtual.
- [ ] Buscar o codificar un servicio que retorne un mensaje (HelloWorld), luego:
<ul>
- [ ] Dockerizar la aplicación
- [ ] Crear una api en kong que haga una llamada a el servicio.
</ul>
- [ ] Hacer un script que ejecute los cuatro puntos anteriores.

### Crear una máquina virtual con terraform sobre el free tier de AWS.

#### Requerimientos:

<ul>
<li>ACCESS y SECRET KEY de una cuenta en AWS</li>
<li>IAM User debe tener permisos en EC2</li>
<li>Disponer de terraform localmente</li>
</ul>

#### Variables de entorno:

<ul>
<li><code>export TF_VAR_aws_ak="AWS ACCESS KEY"</code></li>
<li><code>export TF_VAR_aws_sk="AWS SECRET KEY"</code></li>
<li><code>export TF_VAR_aws_region="AWS REGION"</code></li>
<li><code>export TF_VAR_ec2_ami_id="AWS AMI ID"</code></li>
</ul>

> Para el tema de AMI, se sugiere usar: ami-0a7d051a1c4b54f65 (Ubuntu 18.04)

#### Pasos a seguir:

> Si solo se quiere ejecutar esta actividad se tiene que usar esta rama.

<ol>
<li>Clonar repositorio y usar rama task-terraform</li>
<li>Configurar varaibles de Entorno</li>
<li>Ejecutar: </li>
<ul>
<li>terraform plan</li>
<li>terraform apply</li>
<li>terraform destroy - Para eliminar todos los recursos que se crearon</li>
</ul>
</ol>