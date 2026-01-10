terraform {
  required_providers {
    cloudflare = {
      source  = "cloudflare/cloudflare"
      version = "~> 4.0"
    }
  }
}

terraform {
  backend "gcs" {
    bucket  = "tf-state-bucket456"
    prefix  = "app"
  }
}
