variable "prefix" {
    type = string
  description = "Prefixo do ambiente"
}

variable "location" {
  description = "The location/region to keep all your network resources. To get the list of all locations with table format from azure cli, run 'az account list-locations -o table'"
  default     = ""
}

variable "custom_data" {
  description = "custom OS Data"
}

variable "interface_ids" { 
  type = list(string)
}
variable "availability_set_id" {
  description = "id of availability set"
}
variable "subnet_ID" {
  type = string
  description = "Variable with the subnet ID"
}

#variable "component_count" {
#  type = number
#  description = "numero de componentes a serem criados no modulo"
#}

variable "resource_group_name" {
  description = "A container that holds related resources for an Azure solution"
  default     = ""
}


variable "virtual_network_name" {
  description = "The name of the virtual network"
  default     = ""
  type = string
}

variable "subnet_name" {
  description = "The name of the subnet to use in VM scale set"
  default     = ""
}

variable "public_ip_allocation_method" {
  description = "Defines the allocation method for this IP address. Possible values are `Static` or `Dynamic`"
  default     = "Dynamic"
}
