# Network Interface Card (NIC)
/*
resource "ncloud_network_interface" "tf_bation_nic" {
  name = "tf-bation-nic"
  description = "Network Interface Card for tf-bation"
  subnet_no = ncloud_subnet.tf_public_subnet_01.id
  private_ip = "172.0.1.6"
  access_control_groups = [ncloud_vpc.vpc]
}
*/