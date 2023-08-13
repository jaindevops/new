// VPC outputs
output "vpc_name" {
  value = google_compute_network.vpc_network_01.name
}
output "vpc_id" {
  value = google_compute_network.vpc_network_01.id
}
output "vpc_self_link" {
  value = google_compute_network.vpc_network_01.self_link
}