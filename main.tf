terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "4.33.0"
    }
  }
}

provider "azurerm" {
  features {}
  subscription_id = "7e6e68a5-7ab3-4545-9dac-739679af99ea"  
}

locals {
  rgname   = "RG-denisa-badara"
  location = "West Europe"
}

resource "azurerm_resource_group" "denisa" {
  name     = local.rgname
  location = local.location
}

resource "azurerm_service_plan" "denisa_plan" {
  name                = "denisa-plan"
  location            = azurerm_resource_group.denisa.location
  resource_group_name = azurerm_resource_group.denisa.name

  sku_name = "B1"
  os_type  = "Linux"
}

resource "azurerm_linux_web_app" "denisa_app" {
  name                = "denisa-webapp"
  location            = azurerm_resource_group.denisa.location
  resource_group_name = azurerm_resource_group.denisa.name
  service_plan_id     = azurerm_service_plan.denisa_plan.id

  identity {
    type = "SystemAssigned"
  }

  site_config {
    always_on = true
    application_stack {
      docker_image_name = "hello-world-api:latest"
      docker_registry_url = "https://cgkacademy2025.azurecr.io"
    }
  }


  app_settings = {
    WEBSITES_PORT = "80"
  }

  https_only = true
}


