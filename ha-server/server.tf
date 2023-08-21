# Login Key
resource "ncloud_login_key" "login_key" {
  key_name = "tf-server-key"
}

# Server
resource "ncloud_server" "tf_web_server" {
  subnet_no = ncloud_subnet.tf_public_subnet_01.id
  name = "tf-web-server"
  server_image_product_code = data.ncloud_server_image.server_image.id
  server_product_code       = data.ncloud_server_product.product.id
  login_key_name = ncloud_login_key.login_key.key_name
}

resource "ncloud_server" "tf_was_server" {
  subnet_no = ncloud_subnet.tf_public_subnet_01.id
  name = "tf-was-server"
  server_image_product_code = data.ncloud_server_image.server_image.id
  server_product_code       = data.ncloud_server_product.product.id
  login_key_name = ncloud_login_key.login_key.key_name
}

# Server - detail data
data "ncloud_server_image" "server_image" {
    filter {
      name = "product_name"
      values = [ "ubuntu-20.04" ]
    }
}

data "ncloud_server_product" "product" {
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

# Public IP
resource "ncloud_public_ip" "public_ip_web" {
  server_instance_no = ncloud_server.tf_web_server.id
  description        = "for tf_web_server public ip"
}

resource "ncloud_public_ip" "public_ip_was" {
  server_instance_no = ncloud_server.tf_was_server.id
  description        = "for tf_was_server public ip"
}