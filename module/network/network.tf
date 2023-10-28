## Variable 
variable "project_id" { type = string}

/***************************
       Google Network
    ***************************/
resource "google_compute_network" "vpc_network" {
  name                    = "my-vpc"
  auto_create_subnetworks = false
  routing_mode            = "GLOBAL"
  project                 = "var.project_id"
}