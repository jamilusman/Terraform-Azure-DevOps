terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=3.20.0"
    }
  }
}


provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "tf-az-devops" {
  name     = "tf-az-devops-rg"
  location = "East US"
}

resource "azurerm_container_group" "tf-continst" {
  name                = "weatherapi"
  location            = azurerm_resource_group.tf-az-devops.location
  resource_group_name = azurerm_resource_group.tf-az-devops.name

  ip_address_type     = "Public"
  dns_name_label      = "terraformweatherapi"
  os_type             = "Linux"

  container {
    name   = "weatherapi"
    image  = "jamilusman/weatherapi:latest"
    cpu    = "1"
    memory = "1"

    ports {
      port     = 80
      protocol = "TCP"
    }
  }

  tags = {
    environment = "testing"
  }
}