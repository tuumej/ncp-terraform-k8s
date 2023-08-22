# Network Interface Card (NIC)
resource "ncloud_network_interface" "tf_master_nic" {
  name = "tf-master-nic"
  subnet_no = ncloud_subnet.tf_public_subnet_01.id
  access_control_groups = [ncloud_access_control_group.tf_k8s_acg.id]
  description = "Network Interface Card for tf-mater"
}

resource "ncloud_network_interface" "tf_worker_nic" {
  name = "tf-worker-nic"
  subnet_no = ncloud_subnet.tf_public_subnet_01.id
  access_control_groups = [ncloud_access_control_group.tf_k8s_acg.id]
  description = "Network Interface Card for tf-worker"
}

resource "ncloud_network_interface" "tf_worker_nic_02" {
  name = "tf-worker-nic-02"
  subnet_no = ncloud_subnet.tf_public_subnet_01.id
  access_control_groups = [ncloud_access_control_group.tf_k8s_acg.id]
  description = "Network Interface Card for tf-worker"
}
