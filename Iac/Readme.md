# Infrastructure explanation
---
## Modules and explanation
Every components regarding the infrastructure here is modulatized, for example the **VPC, SG, EC2** are completely bundled in the folders respective to their names.
The files in the module's directory are the
- Main.tf -> Contains the resources
- Providers.tf -> It is where the provider, region and the backend (S3) for the terraform.tfstate is defined
- Outputs.tf -> Contains the ouptuts requrired for the root main.tf
- Variables.tf -> Used to declare the variables 
- data.tf -> Mostly it is used here to find the available AZs and Finding the latest ami of an ubuntu instance (do data search within the AWS)
- terraform.tfvars -> In the root of Iac, where the variables are declared
---
## Prerequisites before running the Iac
### Backend has to be configured
- The S3 bucket is used here so the bucket has to be created
### Statelocking when using in team environments
- DynamoDB with statelock key could be used to statelock the Iac.
