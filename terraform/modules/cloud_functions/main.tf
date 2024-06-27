resource "google_cloudfunctions_function" "function" {
  name        = "my-function"
  runtime     = "nodejs14"
  entry_point = "helloWorld"
  source_archive_bucket = var.bucket_name
  source_archive_object = "function-source.zip"
  trigger_http = true

  vpc_connector = google_vpc_access_connector.access.name

  project = var.project_id
}

resource "google_vpc_access_connector" "access" {
  name    = "connector"
  region  = var.region
  network = var.vpc_id

  project = var.project_id
}
