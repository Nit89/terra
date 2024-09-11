
# Step 3.2: Reference existing resource group
data "azurerm_resource_group" "existing_rg" {
  name = "example2"  # Replace with your actual resource group name
}
resource "random_id" "rand_id" {
    byte_length = 8
  
}

# Step 3.3: Create Azure Storage Account
resource "azurerm_storage_account" "storage" {
  name                     = "mystorageaccount78gt5"  # Ensure it's globally unique
  resource_group_name      = data.azurerm_resource_group.existing_rg.name
  location                 = data.azurerm_resource_group.existing_rg.location
  account_tier             = "Standard"
  account_replication_type = "LRS"

  # Advanced Configuration: Enable Azure Blob Storage Delete feature
#   allow_blob_public_access = false
#   enable_delete_retention_policy = true
#   delete_retention_policy {
#    days = 7  # Customize as per your retention needs
#   }
}

# Step 3.4: Create Blob Container
resource "azurerm_storage_container" "container" {
  name                  = "mystorageaccount78gt5"
  storage_account_name  = azurerm_storage_account.storage.name
  container_access_type = "private"
}

# Step 3.5: CORS Rule Configuration for the Container
# resource "azurerm_storage_account_customer_managed_keys" "cors_rule" {
#   storage_account_id = azurerm_storage_account.storage.id
#   cors_rule {
#     allowed_headers    = ["*"]
#     allowed_methods    = ["GET", "POST"]
#     allowed_origins    = ["*"]
#     exposed_headers    = ["*"]
#     max_age_in_seconds = 3600
#   }
# }
