This example is not yet complete, but will show how to provision and acces an SQL database from multiple cloud platforms.

The instructions below are meant to be performed in the CLI on your platform and not necessarily in visual studio.

Working deployment targets: -NONE YET

# Setup
- Install .NET SDK: https://www.microsoft.com/net/download
- Install npm: https://www.npmjs.com/get-npm

- dotnet add package Microsoft.NET.Sdk.Functions --version 1.0.23
- (skip) dotnet tool install -g Amazon.Lambda.Tools
- npm install -g serverless
- cd apis && npm i --save serverless-azure-functions
- cd website && npm install --save serverless-finch

# AWS Lambda
- Sign up for Amazon AWS
- Install AWS CLI: https://docs.aws.amazon.com/cli/latest/userguide/installing.html
- Set up AWS Credentials: https://serverless.com/framework/docs/providers/aws/guide/credentials/
- ./build.cmd aws


# Azure Functions
- Sign up for Azure Functions (you need an active Azure Functions subscription)
- Install Azure Functions Core Tools: npm install -g azure-functions-core-tools@core
- Install Azure CLI: https://docs.microsoft.com/en-us/cli/azure/install-azure-cli?view=azure-cli-latest
- Set up Azure Credentials: https://serverless.com/framework/docs/providers/azure/guide/credentials/
    Note that the Client ID is the "name" attribute (ex "http://azure-cli-2018...")
- az group create --name AgnosticHello-rg --location "Central US"
- az storage account create --name agnostichellostorage --location centralus --resource-group AgnosticHello-rg --sku Standard_LRS
- az storage account update -g AgnosticHello-rg -n agnostichellostorage --set kind=StorageV2
- az storage account keys list --account-name agnostichellostorage --resource-group AgnosticHello-rg
- $env:AZURE_STORAGE_KEY="YOUR_KEY_FROM_ABOVE"
- $env:AZURE_STORAGE_ACCOUNT="agnostichellostorage"
- az storage blob service-properties update --account-name agnostichellostorage --static-website  --index-document index.html
- az functionapp create --resource-group AgnosticHello-rg --consumption-plan-location centralus --name AgnosticHello --storage-account agnostichellostorage --runtime dotnet
- ./build.cmd azure
