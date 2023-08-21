# Export Root Password
data "ncloud_root_password" "tf_web_server" {
  server_instance_no = ncloud_server.tf_web_server.instance_no # ${ncloud_server.vm.id}
  private_key = ncloud_login_key.login_key.private_key # ${ncloud_login_key.key.private_key}
}

data "ncloud_root_password" "tf_was_server" {
  server_instance_no = ncloud_server.tf_web_server.instance_no # ${ncloud_server.vm.id}
  private_key = ncloud_login_key.login_key.private_key # ${ncloud_login_key.key.private_key}
}

resource "local_file" "bastion_svr_root_pw" {
  filename = "root_password.txt"
  content = "${ncloud_server.tf_web_server.name} => ${data.ncloud_root_password.tf_web_server.root_password}\n${ncloud_server.tf_was_server.name} => ${data.ncloud_root_password.tf_was_server.root_password}"
}
