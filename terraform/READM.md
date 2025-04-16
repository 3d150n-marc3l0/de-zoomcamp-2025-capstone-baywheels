
## Project

Within the project we have the following file structure:


```plaintext
.
├── main.tf            # Define los recursos de infraestructura.
├── providers.tf       # Configura los proveedores de la infraestructura.
├── output.tf          # Define las salidas que Terraform mostrará al aplicar cambios.
├── variables.tf       # Declara las variables que serán utilizadas en la configuración.
└── terraform.tfvars    # Asigna valores específicos a las variables definidas en `variables.tf`.
```

* [main.tf](main.tf). This is the main file where you define the infrastructure resources you want to manage with Terraform. This is where you declare instances, buckets, datasets, tables, etc..
* [providers.tf](providers.tf). Defines the providers that Terraform will use to manage the infrastructure, in our case the cloud provider GCP.
* [output.tf](output.tf). This file is used to define the outputs that Terraform will display after applying changes to the infrastructure. Outputs are useful when you want to get information about resources you've created, such as IP addresses, instance IDs, etc.
* [variables.tf](variables.tf). En este archivo defines las variables que puedes utilizar en tu configuración de Terraform.
* [terraform.tfvars](terraform.tfvars). This file contains the actual values ​​of the variables defined in variables.tf.
* [gcp-credentials.json](gcp-credentials.json). This file should contain your GCP project credentials.

```bash

```

## Configuration

### Install Terraform

To use Terraform, you'll need to install it. The "[Install Terraform](https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli)" link describes the installation guide for installing it locally.



### Verify the installation
Verify that the installation worked by opening a new terminal session and listing Terraform's available subcommands.

```bash
terraform --help
```

```bash
Usage: terraform [global options] <subcommand> [args]

The available commands for execution are listed below.
The primary workflow commands are given first, followed by
less common or more advanced commands.

Main commands:
  init          Prepare your working directory for other commands
  validate      Check whether the configuration is valid
  plan          Show changes required by the current configuration
  apply         Create or update infrastructure
  destroy       Destroy previously-created infrastructure
...
...
```

## Run Terraform


### Initialize Terraform

To initialize the terraform project we execute the following command: 
```bash
terraform init
```

The result of executing the command should return a result similar to the following:
```bash
Initializing the backend...
Initializing provider plugins...
- Finding hashicorp/google versions matching "~> 6.27"...
- Installing hashicorp/google v6.29.0...
- Installed hashicorp/google v6.29.0 (signed by HashiCorp)
Terraform has created a lock file .terraform.lock.hcl to record the provider
selections it made above. Include this file in your version control repository
so that Terraform can guarantee to make the same selections by default when
you run "terraform init" in the future.

Terraform has been successfully initialized!

You may now begin working with Terraform. Try running "terraform plan" to see
any changes that are required for your infrastructure. All Terraform commands
should now work.

If you ever set or change modules or backend configuration for Terraform,
rerun this command to reinitialize your working directory. If you forget, other
commands will detect it and remind you to do so if necessary.
```

### Review the execution plan:

```bash
terraform plan
```


The result of executing the command should return a result similar to the following:
```bash
Terraform used the selected providers to generate the following execution plan. Resource actions are indicated with the following
symbols:
  + create

Terraform will perform the following actions:

  # google_bigquery_dataset.airplane-dataset will be created
  + resource "google_bigquery_dataset" "airplane-dataset" {
      ...
      ...
      + access (known after apply)
    }

  # google_storage_bucket.raw-airplane-bucket will be created
  + resource "google_storage_bucket" "raw-airplane-bucket" {
      ...
      ...
      + website (known after apply)
    }

Plan: 2 to add, 0 to change, 0 to destroy.

Changes to Outputs:
  + bigquery_dataset_name = "airplane_data"
  + bucket_name           = "emmuzoo-zoomcamp-de-airplane-raw"
```

### Apply the changes:

```bash
terraform apply -auto-approve
```

The result of executing the command should return a result similar to the following:
```bash
Terraform used the selected providers to generate the following execution plan. Resource actions are indicated with the following
symbols:
  + create

Terraform will perform the following actions:

  # google_bigquery_dataset.airplane-dataset will be created
  + resource "google_bigquery_dataset" "airplane-dataset" {
      ...
      ...
    }

  # google_storage_bucket.raw-airplane-bucket will be created
  + resource "google_storage_bucket" "raw-airplane-bucket" {
      ...
      ...
    }

Plan: 2 to add, 0 to change, 0 to destroy.

Changes to Outputs:
  + bigquery_dataset_name = "airplane_data"
  + bucket_name           = "emmuzoo-zoomcamp-de-airplane-raw"

Do you want to perform these actions?
  Terraform will perform the actions described above.
  Only 'yes' will be accepted to approve.

  Enter a value: yes

google_bigquery_dataset.airplane-dataset: Creating...
google_storage_bucket.raw-airplane-bucket: Creating...
google_storage_bucket.raw-airplane-bucket: Creation complete after 1s [id=emmuzoo-zoomcamp-de-airplane-raw]
google_bigquery_dataset.airplane-dataset: Creation complete after 2s [id=projects/zoomcamp-de-452200/datasets/airplane_data]

Apply complete! Resources: 2 added, 0 changed, 0 destroyed.

Outputs:

bigquery_dataset_name = "airplane_data"
bucket_name = "emmuzoo-zoomcamp-de-airplane-raw"
```

### Delete the changes:

```bash
terraform destroy -auto-approve
```

