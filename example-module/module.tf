variable "command" {
  default = "echo 'Hello World'"
}

resource "null_resource" "null" {
  provisioner "local-exec" {
    command = "${var.command}"
  }
}

output "my_output" {
  value = "${null_resource.null.command}"
}
