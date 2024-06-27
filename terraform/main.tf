provider "google" {
  project = var.project_id
  region  = var.region
}

module "vpc" {
  source              = "./modules/vpc"
  project_id          = var.project_id
  region              = var.region
  tags                = var.tags
  vpc_name            = var.vpc_name
  public_subnet_cidr  = var.public_subnet_cidr
  private_subnet_cidr = var.private_subnet_cidr
}

module "compute_instance" {
  source         = "./modules/compute_instance"
  private_subnet = module.vpc.private_subnet
  region         = var.region
}

provider "kubernetes" {
  host                   = google_container_cluster.primary.endpoint
  cluster_ca_certificate = base64decode(google_container_cluster.primary.master_auth.0.cluster_ca_certificate)
  token                  = data.google_client_config.default.access_token
}

provider "helm" {
  kubernetes {
    host                   = google_container_cluster.primary.endpoint
    cluster_ca_certificate = base64decode(google_container_cluster.primary.master_auth.0.cluster_ca_certificate)
    token                  = data.google_client_config.default.access_token
  }
}

module "gke" {
  source     = "./modules/gke"
  project_id = var.project_id
  region     = var.region
}

module "cloud_sql" {
  source         = "./modules/cloud_sql"
  vpc_id         = module.vpc.vpc_id
  private_subnet = module.vpc.private_subnet
  region         = var.region
  tags           = var.tags
}

module "memorystore" {
  source         = "./modules/memorystore"
  vpc_id         = module.vpc.vpc_id
  private_subnet = module.vpc.private_subnet
  region         = var.region
  tags           = var.tags
}

module "bigtable" {
  source      = "./modules/bigtable"
  project_id  = var.project_id
  region      = var.region
  tags        = var.tags
}

module "cloud_functions" {
  source         = "./modules/cloud_functions"
  vpc_id         = module.vpc.vpc_id
  private_subnet = module.vpc.private_subnet
  project_id     = var.project_id
  region         = var.region
  tags           = var.tags
  bucket_name    = var.bucket_name
}

module "cloud_storage" {
  source      = "./modules/cloud_storage"
  bucket_name = var.bucket_name
  project_id  = var.project_id
  region      = var.region
  tags        = var.tags
}

module "load_balancer" {
  source                    = "./modules/load_balancer"
  public_subnet             = module.vpc.public_subnet
  project_id                = var.project_id
  region                    = var.region
  tags                      = var.tags
  instance_group_self_link  = module.compute_instance.instance_group_self_link
}

module "cdn" {
  source      = "./modules/cdn"
  bucket_name = var.bucket_name
  project_id  = var.project_id
  region      = var.region
  tags        = var.tags
}

output "vpc_id" {
  value = module.vpc.vpc_id
}
