variable "network_name" {
  default = "ttech"
}


variable "location" {   
    default = "West Us"
}

variable "rg_name" {
  default = "rg-ttech-workshop"
}


variable "addres_space" {
    default = ["10.0.0.0/16"]
}

variable "ip_name" {
    type = string
    default = "ttech-ip"
}

variable "subnetid" {
  description = "(optional) describe your variable"
}
