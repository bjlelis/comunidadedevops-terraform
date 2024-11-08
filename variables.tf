variable "cidr_block" {
  type        = string
  description = "CIDR value"
  default     = "10.0.0.0/16"
}

variable "project_name" {
  type        = string
  description = "Project name to be used to name  the resources (name tag)"
}

variable "tags" {
  type        = map(any)
  description = "Tags to be added to aws resources"
}