#!/bin/bash -l

echo "#############################"
echo "##   DEMO GO DOCKER KONG   ##"
echo "#############################"
echo "\n"

echo "\e[33m* Verificando requerimientos:"
echo "\n"

sleep 5

check_program () {
    command -v "$1" > /dev/null
}

if check_program ansible; then
    echo "\e[32m- Ansible instalado"
else
    echo "\e[31m- Tienes que instalar Ansible"
    exit
fi

if check_program terraform; then
    echo "\e[32m- Terraform instalado"
else
    echo "\e[31m- Tienes que instalar Terraform"
    exit
fi

if check_program aws; then
    echo "\e[32m- AWS CLI instalado"
else
    echo "\e[31m- Tienes que instalar AWS CLI"
    exit
fi

sleep 3

echo "\n"
echo "\e[33m* Ahora, agrega los siguientes valores:"
echo "\n"

var_aws_ak=
var_aws_sk=
var_aws_region=
var_ec2_name=
var_ec2_ami_id=ami-0a7d051a1c4b54f65
var_ec2_sg_name=
var_ec2_key_pub=
var_ec2_key_priv=

read -p "- AWS ACCESS KEY: " var_aws_ak
read -p "- AWS SECRET KEY: " var_aws_sk
read -p "- AWS REGION: " var_aws_region
read -p "- AWS EC2 NAME: " var_ec2_name
read -p "- AWS EC2 SECURITY GROUP NAME: " var_ec2_sg_name

export TF_VAR_aws_ak=$var_aws_ak
export TF_VAR_aws_sk=$var_aws_sk
export TF_VAR_aws_region=$var_aws_region
export TF_VAR_ec2_name=$var_ec2_name
export TF_VAR_ec2_ami_id=$var_ec2_ami_id
export TF_VAR_ec2_sg_name=$var_ec2_sg_name
export AWS_ACCESS_KEY_ID=$TF_VAR_aws_ak
export AWS_SECRET_ACCESS_KEY=$TF_VAR_aws_sk
export AWS_DEFAULT_REGION=$TF_VAR_aws_region

echo "\n"
echo "\e[33m* Creando infraestructura con Terraform y configurando Docker: "
echo "\n"

cd terraform && terraform init && terraform plan && terraform apply -auto-approve

echo "\n"
echo "\e[33m* Generando hosts y keys para usar Ansible"
echo "\n"

cd ../ansible && ansible-playbook ./infrafacts.yml -v
ansible-playbook ./inventoryaws.yml -v

echo "\n"
echo "\e[33m* Instalando y configurando kong-ce"
echo "\n"

ansible-playbook --ssh-common-args='-o StrictHostKeyChecking=no' -i awshosts ./kongce.yml -v

echo "\n"
echo "\e[33m* Instalando y configurando kong-ce"
echo "\n"

ansible-playbook --ssh-common-args='-o StrictHostKeyChecking=no' -i awshosts ./kongce.yml -v

echo "\n"
echo "\e[33m* Instalando y configurando api + kong"
echo "\n"

ansible-playbook --ssh-common-args='-o StrictHostKeyChecking=no' -i awshosts ./apitask.yml -v

IPVAR=$(cat ./awshosts)

echo "\n"
echo "==> Para ver el resultado ingresa a \e[4m\e[36mhttp://$IPVAR:9000/api/hello"
echo "\n"