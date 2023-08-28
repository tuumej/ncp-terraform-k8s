# Export Root Password

data "ncloud_root_password" "tf_master_server" {
  server_instance_no = ncloud_server.tf_master_server.instance_no # ${ncloud_server.vm.id}
  private_key = ncloud_login_key.login_key.private_key # ${ncloud_login_key.key.private_key}
}
data "ncloud_root_password" "tf_worker_server" {
  server_instance_no = ncloud_server.tf_worker_server.instance_no # ${ncloud_server.vm.id}
  private_key = ncloud_login_key.login_key.private_key # ${ncloud_login_key.key.private_key}
}

#data "ncloud_root_password" "tf_worker_server_02" {
#  server_instance_no = ncloud_server.tf_worker_server_02.instance_no # ${ncloud_server.vm.id}
#  private_key = ncloud_login_key.login_key.private_key # ${ncloud_login_key.key.private_key}
#}

resource "local_file" "k8s_svr_root_pw" {
  filename = "root_password.txt"
  content = "${ncloud_server.tf_worker_server.name} => ${data.ncloud_root_password.tf_worker_server.root_password}\n${ncloud_server.tf_master_server.name} => ${data.ncloud_root_password.tf_master_server.root_password}"
}
