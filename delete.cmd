REM TODO: ask are you sure?

if "%1" == "azure" (
	REM TODO: Remove APIS
	REM TODO: Remove Database
	REM TODO: Remove Website
)
if "%1" == "aws" (
	REM TODO: Remove APIS
	REM TODO: Remove Database
	cd website
		serverless client remove
	cd ..
)