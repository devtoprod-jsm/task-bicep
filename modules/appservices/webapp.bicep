@description('Web app name.')
@minLength(2)
param webAppName string

@description('The standard tagging used for resources in the organization.')
param resourceTags object

@description('The app service plan input to be used where the web apps will be created.')
param appServicePlanId string

@description('Is TimeZone change required?')
param changeTimeZone bool = false

@description('Alternate timezone to be used.')
param timeZone string

@description('The runtime stack of webapp.')
param windowsFxVersion string

@description('Location for all resources.')
param location string = resourceGroup().location 

  resource appService 'Microsoft.Web/sites@2022-03-01' = {
    name: '${webAppName}-${uniqueString(resourceGroup().id)}'
    location: location
    tags: resourceTags
    properties: {
      serverFarmId: appServicePlanId
      siteConfig: {
        windowsFxVersion: windowsFxVersion
        websiteTimeZone: ((changeTimeZone) ? timeZone : null)
      }
    }
  }
