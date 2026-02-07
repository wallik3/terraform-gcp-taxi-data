Read this blog to understand the process how we make TF 
https://zainabmosunmola.medium.com/understanding-terraforms-fundamentals-a0eac0d8c9ed

Understand better GCS feature (TH) : 
https://cloud-ace.co.th/blogs/f7z3s8-google-cloud-storage

brew install hashicorp/tap/terraform


ensure to have .tf file that have this block

```
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
    }
  }
}
```

```
terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "4.51.0"
    }
  }
}
```

you can have many tf, but ensure have only one other wise 

terraform init

once you init

there will have this 1 files : .terraform.lock

.terraform/providers/registry.terraform.io/hashicorp/google/4.51.0/darwin_arm64/terraform-provider-google_v4.51.0_x5

which contain binary code


now you are ready for planing by modify .tf file adding resource


Documentation for GCS & Bigquery 
GCS : https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/storage_bucket
Bigquery Dataset : https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/bigquery_dataset
Bigquery Table : https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/bigquery_table

Great Resource
https://zainabmosunmola.medium.com/understanding-terraforms-fundamentals-a0eac0d8c9ed