# Reading the Cloudflare edge network IP addresses 

locals {
  ip_v4_list = compact(split("\n", file("${path.module}/ips-v4.txt")))
}

locals {
  ip_v6_list = compact(split("\n", file("${path.module}/ips-v6.txt")))
}
