/*
 * ipv4_cidr_block : 10.0.0.0/16, 172.16.0.0/16, 192.168.0.0/16
 */
# VPC
resource "ncloud_vpc" "vpc" {
  name = "tf-vpc"
  ipv4_cidr_block = "172.16.0.0/16"
}

/*
resource "ncloud_network_acl" "nacl" {
  vpc_no = ncloud_vpc.vpc.id
  name = "tf-nacl"
}
*/