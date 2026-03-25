terraform {
  required_providers {
    random = {
        source = "hashicorp/random"
        version = "~> 3.5.1"
    }
    local = {
        source = "hashicorp/local"
        version = "~> 2.4.0"
    }
  }
}

# generate a mathematicallly secure random password
resource "random_password" "db_password" {
    length  = 16
    special = true
    override_special = "_%@"
}

# write the credencials to a local file .env file securely in the parent directory
resource "local_file" "encv_file" {
    content = <<-EOT
        POSTGRES_USER=${var.db_username}
        POSTGRES_PASSWORD=${random_password.db_password.result}
        POSTGRES_DB=${var.db_name}
        
        # Airflow needs this specific User ID to run safely in Docker
        AIRFLOW_UID=50000
    EOT
    filename = "../.env"
}