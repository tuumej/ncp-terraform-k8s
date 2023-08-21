/*
 * subnet_type : PUBLIC(Public) | PRIVATE(Private)
 * usage_type : GEN(General) | LOADB(For load balancer)
 */
# Subnet (Public)
resource "ncloud_subnet" "tf_public_subnet_01" {
    vpc_no = ncloud_vpc.vpc.id
    subnet = "172.16.1.0/24"
    zone = "KR-2"
    network_acl_no = ncloud_vpc.vpc.default_network_acl_no
    subnet_type = "PUBLIC"
    name = "tf-public-subnet-01"
    usage_type = "GEN"
}

# Subnet (Private)
resource "ncloud_subnet" "tf_private_subnet_01" {
    vpc_no = ncloud_vpc.vpc.id
    subnet = "172.16.2.0/24"
    zone = "KR-1"
    network_acl_no = ncloud_vpc.vpc.default_network_acl_no
    subnet_type = "PRIVATE"
    name = "tf-private-subnet-01"
    usage_type = "GEN"
}