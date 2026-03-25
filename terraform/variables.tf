variable "db_username" {
    description = "PostgreSQL admin username"
    type        = string
    default     = "npd_admin"

}

variable "db_name" {
    description = "PostgreSQL database name"
    type        = string
    default     = "npd_production"  
}