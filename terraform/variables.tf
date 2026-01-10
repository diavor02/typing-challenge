variable "project_id" {
  description = "GCP project ID"
  type        = string
}

variable "region" {
  description = "GCP region"
  type        = string
}

variable "cloudflare_api_token" {
  description = "Cloudflare api token"
  type = string
}

variable "cloudflare_account_id" {
  type = string
}

variable "zone_id" {
  description = "The unique identifier in Cloudflare for the site's domain"
  type = string
}

variable "x-health-check-value" {
  description = "Header value to authenticate the load balancer for health checks"
  type = string
}
