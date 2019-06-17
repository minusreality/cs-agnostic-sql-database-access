if "%1" == "azure" (
	ECHO "Deploying APIs..."
	cd apis
		dotnet restore
		func azure functionapp publish AgnosticHello --dotnet-cli-params /p:Provider=azure
		REM Cannot use serverless framework for this due to open bug: https://github.com/serverless/serverless-azure-functions/issues/45
	cd ..
	ECHO "Deploying website frontend..."
	cd website
		az storage blob upload-batch -s client/dist -d $web --account-name agnostichellostorage
		REM Powershell will require this if executed via CLI independently: az storage blob upload-batch -s client/dist -d `$web --account-name agnostichellostorage
		ECHO "Log in to Azure Storage and go to Storage Accounts -> agnostichellostorage -> Static Website -> Primary Endpoint to get website URL."
	cd ..
	
)
if "%1" == "aws" (
	ECHO "Deploying APIs..."
	cd apis
		dotnet restore
		dotnet lambda package --configuration release --framework netcoreapp2.1 --output-package bin/release/netcoreapp2.1/deploy-package.zip /p:Provider=aws
		REM serverless deploy --config serverless.aws.yml -v
		copy serverless.aws.yml serverless.yml
		serverless deploy -v
	cd ..
	ECHO "Deploying website frontend..."
	cd website
		serverless client deploy -v
	cd ..
)