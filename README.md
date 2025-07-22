# AWS Terraform Proyecto

Este proyecto crea una infraestructura básica en AWS utilizando Terraform.

## Componentes

- **VPC** en la región `us-east-1` con subnets pública y privada
- **RDS MySQL** con acceso privado y datos de ejemplo
- **EC2** que ejecuta una aplicación Flask para gestionar inventario
- **Pipelines** de GitHub Actions para crear, desplegar y destruir la infraestructura

La aplicación web permite ver, agregar, eliminar y actualizar productos almacenados en la base de datos.

## Uso

1. Configure las variables necesarias en `terraform/variables.tf` (usuario, contraseña de la base de datos y `key_name`).
2. Ejecute `terraform init` y `terraform apply` dentro de la carpeta `terraform` para crear la infraestructura.
3. La instancia EC2 ejecutará la aplicación Flask automáticamente mediante el script de `userdata`.
4. Utilice los workflows de GitHub Actions para automatizar la creación y destrucción de la infraestructura (`terraform_apply.yml` y `terraform_destroy.yml`) y para desplegar actualizaciones de la aplicación (`app_deploy.yml`).

