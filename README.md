# Prerequisite

Project `$PROJECT_ID` exists in region `$REGION` and has the Container Registry enabled: `gcloud services enable --project $PROJECT_ID containerregistry.googleapis.com`

# Build

## API

```
(cd api \
    && docker build --platform linux/amd64 . -t gcr.io/$PROJECT_ID/gcp-cloud-run-go \
    && docker push gcr.io/$PROJECT_ID/gcp-cloud-run-go)
```

## Terraform

```
terraform -chdir=terraform init
terraform -chdir=terraform plan -var project=$PROJECT_ID -var region=$REGION -out plan.out
terraform -chdir=terraform apply plan.out
```

# Test

```
curl $(terraform -chdir=terraform output -json \
    | jq -r .uri.value)/World
```

You should receive `Hello, World!`