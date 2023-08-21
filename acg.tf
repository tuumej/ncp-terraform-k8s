# ACG
resource "ncloud_access_control_group" "tf_bation_acg" {
  name = "tf-bation-acg-01"
  description = "Access Control Group for tf-bation"
  vpc_no = ncloud_vpc.vpc.id
}

# ACG Rule
resource "ncloud_access_control_group_rule" "tf_bation_acg_rule" {
  access_control_group_no = ncloud_access_control_group.tf_bation_acg.id

  inbound {
    protocol    = "TCP"
    ip_block    = "106.245.144.98/32"
    port_range  = "22"
    description = "accept 22 port for admin"
  }
  outbound {
    protocol = "TCP"
    ip_block = "0.0.0.0/0"
    port_range = "1-65535"
    description = "accept TCP 1-65535 port"
  }
  outbound {
    protocol    = "UDP"
    ip_block    = "0.0.0.0/0"
    port_range  = "1-65535"
    description = "accept UDP 1-65535 port"
  }
  outbound {
    protocol    = "ICMP"
    ip_block    = "0.0.0.0/0"
    description = "accept ICMP"
  }
}

