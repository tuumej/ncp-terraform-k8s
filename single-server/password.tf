# Export Root Password
data "ncloud_root_password" "default" {
  server_instance_no = ncloud_server.tf_bation_server.instance_no # ${ncloud_server.vm.id}
  private_key = ncloud_login_key.login_key.private_key # ${ncloud_login_key.key.private_key}
}
resource "local_file" "bastion_svr_root_pw" {
  filename = "${ncloud_server.tf_bation_server.name}-root_password.txt"
  content = "${ncloud_server.tf_bation_server.name} => ${data.ncloud_root_password.default.root_password}"
}
