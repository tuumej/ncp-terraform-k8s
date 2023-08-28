# Login Key
resource "ncloud_login_key" "login_key" {
  key_name = "tf-server-key"
}

# Server
resource "ncloud_server" "tf_master_server" {
  subnet_no = ncloud_subnet.tf_public_subnet_01.id
  name = "tf-master-server"
  server_image_product_code = data.ncloud_server_image.server_image.id
  server_product_code       = data.ncloud_server_product.product_master.id
  login_key_name = ncloud_login_key.login_key.key_name
  network_interface {
    network_interface_no = ncloud_network_interface.tf_master_nic.id
    order = 0
  }
  description = "k8s Control Plane Server"
}

resource "ncloud_server" "tf_worker_server" {
  subnet_no = ncloud_subnet.tf_public_subnet_01.id
  name = "tf-worker-server"
  server_image_product_code = data.ncloud_server_image.server_image.id
  server_product_code       = data.ncloud_server_product.product_worker.id
  login_key_name = ncloud_login_key.login_key.key_name
  network_interface {
    network_interface_no = ncloud_network_interface.tf_worker_nic.id
    order = 0
  }
  description = "k8s Worker Node Server"
}

#resource "ncloud_server" "tf_worker_server_02" {
#  subnet_no = ncloud_subnet.tf_public_subnet_01.id
#  name = "tf-worker-server-02"
#  server_image_product_code = data.ncloud_server_image.server_image.id
#  server_product_code       = data.ncloud_server_product.product_worker.id
#  login_key_name = ncloud_login_key.login_key.key_name
#  network_interface {
#    network_interface_no = ncloud_network_interface.tf_worker_nic_02.id
#    order = 0
#  }
#  description = "k8s Worker Node Server 02"
#}

# Public IP
resource "ncloud_public_ip" "public_ip_worker" {
  server_instance_no = ncloud_server.tf_worker_server.id
  description        = "for tf_worker_server public ip"
}

resource "ncloud_public_ip" "public_ip_master" {
  server_instance_no = ncloud_server.tf_master_server.id
  description        = "for tf_master_server public ip"
}

#resource "ncloud_public_ip" "public_ip_worker_02" {
#  server_instance_no = ncloud_server.tf_worker_server_02.id
#  description        = "for tf_worker_server_02 public ip"
#}

# Server - detail data
data "ncloud_server_image" "server_image" {
    filter {
      name = "product_name"
      values = [ "ubuntu-20.04" ]
    }
}

data "ncloud_server_product" "product_worker" {
  server_image_product_code = data.ncloud_server_image.server_image.id

  filter {
    name   = "product_code"
    values = ["SSD"]
    regex  = true
  }
  filter {
    name   = "cpu_count"
    values = ["2"]
  }
  filter {
    name   = "memory_size"
    values = ["4GB"]
  }
  /*
   * product_type : STAND, HICPU, HIMEM
   */
  filter {
    name   = "product_type"
    values = ["HICPU"]
  }
}

data "ncloud_server_product" "product_master" {
  server_image_product_code = data.ncloud_server_image.server_image.id

  filter {
    name   = "product_code"
    values = ["SSD"]
    regex  = true
  }
  filter {
    name   = "cpu_count"
    values = ["2"]
  }
  filter {
    name   = "memory_size"
    values = ["8GB"]
  }
  /*
   * product_type : STAND, HICPU, HIMEM
   */
  filter {
    name   = "product_type"
    values = ["STAND"]
  }
}
