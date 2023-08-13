/***************************
       Google Network
    ***************************/
resource "google_compute_network" "vpc_network_01" {
  name                    = "vpc-01"
  auto_create_subnetworks = false
  routing_mode            = "GLOBAL"
}