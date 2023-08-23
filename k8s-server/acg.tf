# ACG
resource "ncloud_access_control_group" "tf_k8s_acg" {
  name = "tf-k8s-acg-01"
  description = "Access Control Group for tf-k8s"
  vpc_no = ncloud_vpc.vpc.id
}

# ACG Rule
resource "ncloud_access_control_group_rule" "tf_k8s_acg_rule" {
  access_control_group_no = ncloud_access_control_group.tf_k8s_acg.id

  inbound {
    protocol    = "TCP"
    ip_block    = "106.245.144.98/32"
    port_range  = "22"
    description = "accept 22 port for admin"
  }
  inbound {
    protocol    = "TCP"
    ip_block    = "106.245.144.98/32"
    port_range  = "30050"
    description = "accept 30050 port for nginx"
  }
  inbound {
    protocol    = "TCP"
    ip_block    = "106.245.144.98/32"
    port_range  = "30000"
    description = "accept 30000 port for mysql"
  }
  inbound {
    protocol    = "TCP"
    ip_block    = "106.245.144.98/32"
    port_range  = "8080"
    description = "accept 8080 port for tomcat"
  }
  inbound {
    protocol    = "TCP"
    ip_block    = "172.16.0.0/16"
    port_range  = "1-65535"
    description = "accept TCP 1-65535 between Servers in VPC ip bands "
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

