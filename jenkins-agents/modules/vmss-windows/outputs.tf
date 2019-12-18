output "vmss_win_id" {
  value = "${azurerm_virtual_machine_scale_set.vm-windows.*.id}"
}
