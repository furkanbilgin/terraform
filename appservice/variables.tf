variable "location" {
    default = "West Europe"
}

variable "rg_name" {
    default = "rg-AppService-Test-00TR"
}


variable "default_tags" {
  type = map(any)
  default = {
    "Terraform Project" : "AppServiceTest"
    "Project Owner" : "Furkan Bilgin"
    "Project Contact" : "furkanbilgin@.....com"
    "Env" : "Test"
  }
}