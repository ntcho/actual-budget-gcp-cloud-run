## Actual Budget for Google Cloud (Cloud Run)

This is a Terraform configuration for deploying the Actual Budget server to a Cloud Run service in GCP, which should stay under the always free tier with normal usage (as long as you are not syncing with the server for ~2 hours per day).

### Prerequisites

1. Terraform CLI
1. Google Cloud CLI
2. HCP Terraform account with a workspace created (ensure the "Execution Mode" is set to "Local".)

### Instructions

1. In provider.tf, set the `organization` and `workspace` to your HCP organization and workspace.
1. Create a new project in Google Cloud Console.
1. Create a new Firebase project in the Firebase Console.
    - https://console.firebase.google.com/u/0/?pli=1
    - Select "Get started with a Firebase project"
    - Select "Already have a Google Cloud project? Add Firebase to Google Cloud project"
    - Choose the project you created above
1. Find your project ID and billing account ID.
1. Create a `tfvars.auto.tfvars` file in the root of the project with the following variables:
    ```hcl
    project_id = "your-project-id"
    billing_account_id = "your-billing-account-id"
    currency_code = "your-currency-code"
    project_name = "your-project-name"
    ```
    The `project_name` can be anything you want.
1. Run `gcloud auth application-default login` to authenticate with Google Cloud.
1. Run `terraform init` to initialize the project.
1. Run `terraform apply` to deploy the project.

### Redeploying the Cloud Run Service

If you wish to update the version of Actual Budget that the Cloud Run service is running:

1. Run `terraform apply -replace="module.cloud_run.google_cloud_run_v2_service.main"`
1. Then, run `terraform apply` to update other resources.

### Changelogs

#### 2024-11-05

- Added support for Firebase Hosting.
- Renamed `cloud_run_service_name` to `project_name`, please update your `tfvars.auto.tfvars` file.
