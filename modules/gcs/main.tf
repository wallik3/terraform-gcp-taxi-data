resource "random_id" "bucket_suffix" {
  byte_length = 4
}

resource "google_storage_bucket" "this" {
  name     = "${var.bucket_name_prefix}-${random_id.bucket_suffix.hex}"
  location = var.location

  storage_class               = var.storage_class
  uniform_bucket_level_access = true

  versioning {
    enabled = true
  }

  lifecycle_rule {
    action {
      type          = "SetStorageClass"
      storage_class = "NEARLINE"
    }
    condition {
      age = 10
    }
  }

  lifecycle_rule {
    action {
      type = "Delete"
    }
    condition {
      age = 30
    }
  }

  force_destroy = var.force_destroy
}
