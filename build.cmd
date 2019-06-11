if "%1" == "azure" (
	cd apis
		dotnet restore
		func azure functionapp publish AgnosticHello --dotnet-cli-params /p:Provider=azure
	cd ..
	REM dotnet lambda package --configuration release --framework netcoreapp2.1 --output-package bin/release/netcoreapp2.1/deploy-package.zip /p:Provider=azure
	REM serverless deploy --config serverless.azure.yml -v
	REM cp serverless.azure.yml serverless.yml
	REM serverless deploy -v
)
if "%1" == "aws" (
	cd apis
		dotnet restore
		dotnet lambda package --configuration release --framework netcoreapp2.1 --output-package bin/release/netcoreapp2.1/deploy-package.zip /p:Provider=aws
		REM serverless deploy --config serverless.aws.yml -v
		copy serverless.aws.yml serverless.yml
		serverless deploy -v
	cd ..
	cd website
		serverless client deploy -v
	cd ..
)