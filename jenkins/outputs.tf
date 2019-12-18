output "vmss_id-1804acc" {
  value = "${module.vmss-1804acc.vmss_lin_id}"
}

output "vmss_id-1604acc" {
  value = "${module.vmss-1604acc.vmss_lin_id}"
}

output "vmss_id-1804nonacc" {
  value = "${module.vmss-1804nonacc.vmss_lin_id}"
}

output "vmss_id-2016acc" {
  value = "${module.vmss-2016acc.vmss_win_id}"
}

output "vmss_id-2016sgx" {
  value = "${module.vmss-2016sgx.vmss_win_id}"
}

output "vmss_id-2016nonsgx" {
  value = "${module.vmss-2016nonsgx.vmss_win_id}"
}

output "linux_vm_public_name"{
  value = "${module.jenkins-master.public_ip_dns_name}"
}