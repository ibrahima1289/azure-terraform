import os
import hcl2

# Validate multiple Terraform files in a directory
def validate_hcl_in_directory(directory_path):
  try:
    for file_name in os.listdir(directory_path):
      if file_name.endswith(".tf"):
        file_path = os.path.join(directory_path, file_name)
        print(f"Validating {file_path}...")
        with open(file_path, 'r') as file:
          try:
            hcl2.load(file)
            print(f"Validation successful for {file_name}.")
            print(" ")
          except hcl2.HCLParseError as e:
            print(f"Validation failed for {file_name}: {e}")
      else:
        print(f"Error!!! Skipping {file_name}, not a .tf file.")
  except Exception as e:
    print(f"Error occurred while processing the {file_name} file: {e}")

if __name__ == "__main__":
  
  print("Validating all Terraform files in the directory...")
  print("----  ---- DEV  ----  ----")   
  terraform_directory_dev = "/home/runner/work/azure-terraform/azure-terraform/az-terraform/dev"  
  validate_hcl_in_directory(terraform_directory_dev)
  print("----  ----  ----  ----")
  print("----  ---- PROD ----  ----")   
  terraform_directory_prod = "/home/runner/work/azure-terraform/azure-terraform/az-terraform/prod"  
  validate_hcl_in_directory(terraform_directory_prod)
  print("----  ----  ----  ----")
  print("----  ---- BACKEND ----  ----")   
  terraform_directory_backend = "/home/runner/work/azure-terraform/azure-terraform/az-terraform/backend"  
  validate_hcl_in_directory(terraform_directory_backend)
  print("----  ----  ----  ----")
