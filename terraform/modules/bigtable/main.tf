resource "google_bigtable_instance" "default" {
  name = "bigtable-instance"
  cluster {
    cluster_id   = "bigtable-cluster"
    zone         = "${var.region}-a"
    num_nodes    = 3
    storage_type = "SSD"
  }
  project = var.project_id
}
