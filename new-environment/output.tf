# ------ Output Oracle Server Public IPs
output "oracle_server_public_ip_zone1" {
  value = oci_core_instance.oci_compute_instance[0].public_ip
}


# ------ Initial Instructions
output "initial_instruction" {
  value = <<EOT
1.  Open an SSH client.
2.  Use the following information to connect to the instances:
OCI VM Connection: 
1. SSH to VM using your private key and opc username: opc@${oci_core_instance.oci_compute_instance[0].public_ip}
SSH Key
For example:
$ ssh –i id_rsa adminuser@82.32.XX.XX
After you connect to each instances you can do a ping test using private IP from Each VM. 
EOT

}
