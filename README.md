## azure-terraform
The objective of this repo is to set up the environment in order to deploy Azure resources using Terraform.

## Configure the environment
### Pre-requisites
* Have an [Azure subscription](https://www.educative.io/answers/how-to-create-a-microsoft-azure-subscription)
* Install [Terraform](https://developer.hashicorp.com/terraform/tutorials/azure-get-started/install-cli) and [Azure CLI](https://learn.microsoft.com/en-us/cli/azure/install-azure-cli)<br>
Note: We will be using [Windows WSL](https://code.visualstudio.com/docs/remote/wsl-tutorial) CLI in VS Code

### 1. Authenticate to Azure using Microsoft Account
* See [user-login.md](https://github.com/ibrahima1289/azure-terraform/blob/main/user-login.md) for details on how to deploy resources in **Azure** using Terraform and user login from CLI.
### 2. Use GitHub Action - A pipeline
* See [spn-login.md](https://github.com/ibrahima1289/azure-terraform/blob/main/spn-login.md) for details on how to deploy resources in **Azure** using Terraform, Azure [SPN](https://learn.microsoft.com/en-us/azure/active-directory/develop/app-objects-and-service-principals?tabs=browser) and GitHub Action.

### Source
1. [terraform-azure](https://github.com/LinkedInLearning/terraform-azure-2453108)