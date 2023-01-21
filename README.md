
#  Docker Deployment in Azure Cloud with Terraform

## Project Structure:
```
.
├── main.tf
└──output.tf
└── README.md
└── Screenshots.pdf
└──setup.sh
└──variables.tf
```
## Project Diagram

![Alt text](Screenshot%202023-01-20%20234233.png)


[main.tf](main.tf)

```
terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = "3.40.0"
    }
  }
}

provider "azurerm" {
  # Configuration options
  features {

  }
}


resource "azurerm_resource_group" "savtf" {
  name     = "${var.prefix}-resources"
...
```


## Deploy Azure Resources with Terraform

```
PS C:\Users\12048\Desktop\sav> terraform apply -auto-approve
data.template_file.userdata: Reading...
data.template_file.userdata: Read complete after 0s [id=64ba620b5c6a3012a4b50631b374310230c3e7e533dfd7f5b98134fdbbe3b6d1]
azurerm_resource_group.savtf: Refreshing state... [id=/subscriptions/9305bb20-ec55-4ee4-a68c-ee0db160dd61/resourceGroups/tfvmex-resources]
azurerm_network_security_group.nsg1: Refreshing state... [id=/subscriptions/9305bb20-ec55-4ee4-a68c-ee0db160dd61/resourceGroups/tfvmex-resources/providers/Microsoft.Network/network
SecurityGroups/nsgwithsshopen]

Note: Objects have changed outside of Terraform

Terraform detected the following changes made outside of Terraform since the last "terraform apply" which may have affected this plan:

  # azurerm_network_security_group.nsg1 has been deleted
  - resource "azurerm_network_security_group" "nsg1" {
      - id                  = "/subscriptions/9305bb20-ec55-4ee4-a68c-ee0db160dd61/resourceGroups/tfvmex-resources/providers/Microsoft.Network/networkSecurityGroups/nsgwithsshopen"
 -> null
        name                = "nsgwithsshopen"
        tags                = {}
...

```


## Expected Result with Apply

```
...
  + id                  = (known after apply)
      + location            = "westeurope"
      + name                = "tfvmex-network"
      + resource_group_name = "tfvmex-resources"
      + subnet              = (known after apply)
    }

Plan: 8 to add, 0 to change, 0 to destroy.

Changes to Outputs:
  + Public_IP = (known after apply)
azurerm_resource_group.savtf: Creating...
azurerm_resource_group.savtf: Creation complete after 3s [id=/subscriptions/9305bb20-ec55-4ee4-a68c-ee0db160dd61/resourceGroups/tfvmex-resources]
azurerm_virtual_network.main: Creating...
azurerm_public_ip.pip1: Creating...
azurerm_network_security_group.nsg1: Creating...
azurerm_public_ip.pip1: Creation complete after 5s [id=/subscriptions/9305bb20-ec55-4ee4-a68c-ee0db160dd61/resourceGroups/tfvmex-resources/providers/Microsoft.Network/publicIPAddre
sses/tfvmex-pip]
azurerm_network_security_group.nsg1: Creation complete after 8s [id=/subscriptions/9305bb20-ec55-4ee4-a68c-ee0db160dd61/resourceGroups/tfvmex-resources/providers/Microsoft.Network/
networkSecurityGroups/nsgwithsshopen]
azurerm_virtual_network.main: Creation complete after 8s [id=/subscriptions/9305bb20-ec55-4ee4-a68c-ee0db160dd61/resourceGroups/tfvmex-resources/providers/Microsoft.Network/virtual
Networks/tfvmex-network]
azurerm_subnet.internal: Creating...
azurerm_subnet.internal: Creation complete after 7s [id=/subscriptions/9305bb20-ec55-4ee4-a68c-ee0db160dd61/resourceGroups/tfvmex-resources/providers/Microsoft.Network/virtualNetwo
rks/tfvmex-network/subnets/internal]
azurerm_network_interface.main: Creating...
azurerm_network_interface.main: Creation complete after 4s [id=/subscriptions/9305bb20-ec55-4ee4-a68c-ee0db160dd61/resourceGroups/tfvmex-resources/providers/Microsoft.Network/netwo
rkInterfaces/tfvmex-nic]
azurerm_network_interface_security_group_association.example: Creating...
azurerm_virtual_machine.main: Creating...
azurerm_network_interface_security_group_association.example: Creation complete after 3s [id=/subscriptions/9305bb20-ec55-4ee4-a68c-ee0db160dd61/resourceGroups/tfvmex-resources/pro
viders/Microsoft.Network/networkInterfaces/tfvmex-nic|/subscriptions/9305bb20-ec55-4ee4-a68c-ee0db160dd61/resourceGroups/tfvmex-resources/providers/Microsoft.Network/networkSecurit
yGroups/nsgwithsshopen]
azurerm_virtual_machine.main: Still creating... [10s elapsed]
azurerm_virtual_machine.main: Still creating... [20s elapsed]
azurerm_virtual_machine.main: Still creating... [30s elapsed]
azurerm_virtual_machine.main: Still creating... [40s elapsed]
azurerm_virtual_machine.main: Still creating... [50s elapsed]
azurerm_virtual_machine.main: Creation complete after 55s [id=/subscriptions/9305bb20-ec55-4ee4-a68c-ee0db160dd61/resourceGroups/tfvmex-resources/providers/Microsoft.Compute/virtua
lMachines/tfvmex-vm]

Apply complete! Resources: 8 added, 0 changed, 0 destroyed.

Outputs:

Public_IP = "51.234.133.1327"
;;;
```

## To Destroy the Resources

```
PS C:\Users\12048\Desktop\sav> terraform destroy -auto-approve
```

## Expected Result with Destroy

```
...
    - guid                    = "5e6591cb-e1c7-45d7-b945-244fb9dd824c" -> null
      - id                      = "/subscriptions/9305bb20-ec55-4ee4-a68c-ee0db160dd61/resourceGroups/tfvmex-resources/providers/Microsoft.Network/virtualNetworks/tfvmex-network" -
> null
      - location                = "westeurope" -> null
      - name                    = "tfvmex-network" -> null
      - resource_group_name     = "tfvmex-resources" -> null
      - subnet                  = [
          - {
              - address_prefix = "10.0.2.0/24"
              - id             = "/subscriptions/9305bb20-ec55-4ee4-a68c-ee0db160dd61/resourceGroups/tfvmex-resources/providers/Microsoft.Network/virtualNetworks/tfvmex-network/sub
nets/internal"
              - name           = "internal"
              - security_group = ""
            },
        ] -> null
      - tags                    = {} -> null
    }

Plan: 0 to add, 0 to change, 8 to destroy.

Changes to Outputs:
  - Public_IP = "52.174.133.187" -> null
azurerm_network_interface_security_group_association.example: Destroying... [id=/subscriptions/9305bb20-ec55-4ee4-a68c-ee0db160dd61/resourceGroups/tfvmex-resources/providers/Micros
oft.Network/networkInterfaces/tfvmex-nic|/subscriptions/9305bb20-ec55-4ee4-a68c-ee0db160dd61/resourceGroups/tfvmex-resources/providers/Microsoft.Network/networkSecurityGroups/nsgwi
thsshopen]
azurerm_virtual_machine.main: Destroying... [id=/subscriptions/9305bb20-ec55-4ee4-a68c-ee0db160dd61/resourceGroups/tfvmex-resources/providers/Microsoft.Compute/virtualMachines/tfvm
ex-vm]
azurerm_network_interface_security_group_association.example: Destruction complete after 9s
azurerm_network_security_group.nsg1: Destroying... [id=/subscriptions/9305bb20-ec55-4ee4-a68c-ee0db160dd61/resourceGroups/tfvmex-resources/providers/Microsoft.Network/networkSecuri
tyGroups/nsgwithsshopen]
azurerm_virtual_machine.main: Still destroying... [id=/subscriptions/9305bb20-ec55-4ee4-a68c-...soft.Compute/virtualMachines/tfvmex-vm, 10s elapsed]
azurerm_network_security_group.nsg1: Still destroying... [id=/subscriptions/9305bb20-ec55-4ee4-a68c-...k/networkSecurityGroups/nsgwithsshopen, 10s elapsed]
azurerm_virtual_machine.main: Still destroying... [id=/subscriptions/9305bb20-ec55-4ee4-a68c-...soft.Compute/virtualMachines/tfvmex-vm, 20s elapsed]
azurerm_network_security_group.nsg1: Destruction complete after 11s
azurerm_virtual_machine.main: Still destroying... [id=/subscriptions/9305bb20-ec55-4ee4-a68c-...soft.Compute/virtualMachines/tfvmex-vm, 30s elapsed]
azurerm_virtual_machine.main: Still destroying... [id=/subscriptions/9305bb20-ec55-4ee4-a68c-...soft.Compute/virtualMachines/tfvmex-vm, 40s elapsed]
azurerm_virtual_machine.main: Destruction complete after 44s
azurerm_network_interface.main: Destroying... [id=/subscriptions/9305bb20-ec55-4ee4-a68c-ee0db160dd61/resourceGroups/tfvmex-resources/providers/Microsoft.Network/networkInterfaces/
tfvmex-nic]
azurerm_network_interface.main: Destruction complete after 6s
azurerm_subnet.internal: Destroying... [id=/subscriptions/9305bb20-ec55-4ee4-a68c-ee0db160dd61/resourceGroups/tfvmex-resources/providers/Microsoft.Network/virtualNetworks/tfvmex-ne
twork/subnets/internal]
azurerm_public_ip.pip1: Destroying... [id=/subscriptions/9305bb20-ec55-4ee4-a68c-ee0db160dd61/resourceGroups/tfvmex-resources/providers/Microsoft.Network/publicIPAddresses/tfvmex-p
ip]
azurerm_subnet.internal: Still destroying... [id=/subscriptions/9305bb20-ec55-4ee4-a68c-...tworks/tfvmex-network/subnets/internal, 10s elapsed]
azurerm_public_ip.pip1: Still destroying... [id=/subscriptions/9305bb20-ec55-4ee4-a68c-...t.Network/publicIPAddresses/tfvmex-pip, 10s elapsed]
azurerm_subnet.internal: Destruction complete after 12s
azurerm_public_ip.pip1: Destruction complete after 12s
azurerm_virtual_network.main: Destroying... [id=/subscriptions/9305bb20-ec55-4ee4-a68c-ee0db160dd61/resourceGroups/tfvmex-resources/providers/Microsoft.Network/virtualNetworks/tfvm
ex-network]
azurerm_virtual_network.main: Still destroying... [id=/subscriptions/9305bb20-ec55-4ee4-a68c-...Network/virtualNetworks/tfvmex-network, 10s elapsed]
azurerm_virtual_network.main: Destruction complete after 12s
azurerm_resource_group.savtf: Destroying... [id=/subscriptions/9305bb20-ec55-4ee4-a68c-ee0db160dd61/resourceGroups/tfvmex-resources]
azurerm_resource_group.savtf: Still destroying... [id=/subscriptions/9305bb20-ec55-4ee4-a68c-...60dd61/resourceGroups/tfvmex-resources, 10s elapsed]
azurerm_resource_group.savtf: Destruction complete after 19s

Destroy complete! Resources: 8 destroyed.
...
```
