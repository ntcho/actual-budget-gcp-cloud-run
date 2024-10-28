## Actual Budget for Google Cloud (Cloud Run)

This is a Terraform configuration for deploying the Actual Budget server to a Cloud Run service in GCP, which should stay under the always free tier with normal usage (as long as you are not syncing with the server for ~2 hours per day).

### Prerequisites

1. Terraform CLI
1. Google Cloud CLI
2. HCP Terraform account with a workspace created (ensure the "Execution Mode" is set to "Local".)

### Instructions

1. In provider.tf, set the `organization` and `workspace` to your HCP organization and workspace.
1. Create a new project in Google Cloud Console.
1. Find your project ID and billing account ID.
1. Create a `tfvars.auto.tfvars` file in the root of the project with the following variables:
    ```hcl
    project_id = "your-project-id"
    billing_account_id = "your-billing-account-id"
    currency_code = "your-currency-code"
    cloud_run_service_name = "your-cloud-run-service-name"
    ```
    The `cloud_run_service_name` can be anything you want.
1. Run `gcloud auth application-default login` to authenticate with Google Cloud.
1. Enable GCP services in the project:
    ```bash
    gcloud services enable cloudbilling.googleapis.com
    gcloud services enable billingbudgets.googleapis.com
    gcloud services enable run.googleapis.com
    gcloud services enable iam.googleapis.com
    gcloud services enable compute.googleapis.com
    gcloud services enable cloudresourcemanager.googleapis.com
    ```
1. Run `terraform init` to initialize the project.
1. Run `terraform apply` to deploy the project.
