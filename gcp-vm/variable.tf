# variables.tf

variable "project_id" {
  description = "The project ID where the resources will be created"
  type        = string
}

variable "region" {
  description = "Region for the resources"
  type        = string
  default     = "us-central1"
}

variable "zone" {
  description = "The zone where the VM will be created"
  type        = string
  default     = "us-central1-a"
}

variable "instance_name" {
  description = "Name of the VM instance"
  type        = string
  default     = "my-vm-instance"
}
