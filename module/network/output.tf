// VPC outputs
output "vpc_name" {
  value = google_compute_network.vpc_network.name
}
output "vpc_id" {
  value = google_compute_network.vpc_network.id
}
output "vpc_self_link" {
  value = google_compute_network.vpc_network.self_link
}

output "project_name" {
  value = google_compute_network.vpc_network.project
}