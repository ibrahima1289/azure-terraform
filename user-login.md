### Authenticate to Azure using Microsoft Account

* Verify you have installed Terraform

![](images/az1.PNG)

* Verify you have install Azure CLI

![](images/az2.PNG)

* Run command `az login`

![](images/az3.PNG)

* Follow the link and login through the web browser:first enter thr domain, then the password followed by MFA if you have multi-factor authentication enabled.

<img src="images/az4.PNG" width=40% height=30%>
<img src="images/az5.PNG" width=38.5% height=30%>

* You should see this on your browser

<img src="images/az6.PNG" width=80% height=80%>

* Run command `az account show` to verify you are logged in

<img src="images/az7.PNG" width=39% height=50%>

* If you want to use a specific subscription, run the command below: <br>
`az account set --subscription "subscription_id_or_name"`

### Create resources in Azure via Terraform
#### Set up Terraform files
See `main.tf` file in this repo as an example.
#### Run commands locally
* Initiate Terraform by running `terraform init`

<img src="images/az8.PNG" width=39% height=50%>

* Run `terraform plan`

<img src="images/az9.PNG" width=40% height=50%>

* Run `terraform apply`. Type `yes` when prompted to enter value

<img src="images/az10.PNG" width=40% height=50%>

* You can see the resources (resource group, virtual network and subnet) have been created

<img src="images/az11.PNG" width=90% height=90%>

* To clean, run `terraform destroy`. Type `yes` when prompted to enter value.

<img src="images/az12.PNG" width=40% height=50%>

