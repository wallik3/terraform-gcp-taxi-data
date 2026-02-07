variable "dataset_id" {
  description = "The ID of the BigQuery dataset"
  type        = string
}

variable "location" {
  description = "BigQuery dataset location"
  type        = string
}

variable "description" {
  description = "Description of the dataset"
  type        = string
  default     = ""
}

variable "default_expiration_days" {
  description = "Default table and partition expiration in days"
  type        = number
  default     = 90
}

variable "delete_contents_on_destroy" {
  description = "Whether to delete dataset contents when destroying"
  type        = bool
  default     = false
}

variable "labels" {
  description = "Labels to apply to the dataset"
  type        = map(string)
  default     = {}
}
