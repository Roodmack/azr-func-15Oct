using namespace System.Net

# Input bindings are passed in via param block.
param($Request, $TriggerMetadata)

# Write to the Azure Functions log stream.
Write-Host "PowerShell HTTP trigger function processed a request."

# Interact with query parameters or the body of the request.
$name = $Request.Query.Name
if (-not $name) {
    $name = $Request.Body.Name
}


$body = "This HTTP triggered function executed successfully. Pass a name in the query string or in the request body for a personalized response."

if ($name) {
    $body = "Hello, $name. This HTTP triggered function executed successfully."
}

# Associate values to output bindings by calling 'Push-OutputBinding'.
Push-OutputBinding -Name Response -Value ([HttpResponseContext]@{
    StatusCode = [HttpStatusCode]::OK
    Body = $body
})



Connect-AzAccount

New-AzADServicePrincipal -DisplayName "azr-sp-func15oct" -Role "contributor" -Scope  "/subscriptions/aef3cca3-9788-4576-aa6a-a95168443808/resourceGroups/AZR-RG-Func15OCT-dev" `
-AppDescription "Service principal to manage app deployment on git hub f lo" -KeyCredential -WhatIf



get-help New-AzADServicePrincipal -Examples
