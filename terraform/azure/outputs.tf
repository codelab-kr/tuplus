resource "local_file" "kubeconfig" {
  depends_on = [azurerm_kubernetes_cluster.cluster]
  filename   = "kubeconfig"
  content    = azurerm_kubernetes_cluster.cluster.kube_config_raw
}

output "registry_id" {
  value = azurerm_container_registry.container_registry.id
}

output "registry_hostname" {
  value = azurerm_container_registry.container_registry.login_server
}

output "registry_un" {
  value = azurerm_container_registry.container_registry.admin_username
}

output "registry_pw" {
  value     = azurerm_container_registry.container_registry.admin_password
  sensitive = true
}

data "azurerm_storage_account" "storage_account" {
  name                = azurerm_storage_account.storage_account.name
  resource_group_name = azurerm_resource_group.resource_group.name
}

output "storage_account_connection_string" {
  value     = data.azurerm_storage_account.storage_account.primary_connection_string
  sensitive = true
}
