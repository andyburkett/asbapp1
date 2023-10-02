Initialize Terraform

Run terraform init to initialize the Terraform deployment. This command downloads the Azure provider required to manage your Azure resources.
Console

terraform init

Create a Terraform execution plan

Run terraform plan to create an execution plan.
Console

terraform plan -out main.tfplan

Key points:

    The terraform plan command creates an execution plan, but doesn't execute it. Instead, it determines what actions are necessary to create the configuration specified in your configuration files. This pattern allows you to verify whether the execution plan matches your expectations before making any changes to actual resources.
    The optional -out parameter allows you to specify an output file for the plan. Using the -out parameter ensures that the plan you reviewed is exactly what is applied.
    To read more about persisting execution plans and security, see the security warning section.

Apply a Terraform execution plan

Run terraform apply to apply the execution plan to your cloud infrastructure.
Console

terraform apply main.tfplan

Clean up resources

When you no longer need the resources created via Terraform, do the following steps:

    Run terraform plan and specify the destroy flag.
    Console 

terraform plan -destroy -out main.destroy.tfplan

Key points:

    The terraform plan command creates an execution plan, but doesn't execute it. Instead, it determines what actions are necessary to create the configuration specified in your configuration files. This pattern allows you to verify whether the execution plan matches your expectations before making any changes to actual resources.
    The optional -out parameter allows you to specify an output file for the plan. Using the -out parameter ensures that the plan you reviewed is exactly what is applied.
    To read more about persisting execution plans and security, see the security warning section.

Run terraform apply to apply the execution plan.
Console

terraform apply main.destroy.tfplan