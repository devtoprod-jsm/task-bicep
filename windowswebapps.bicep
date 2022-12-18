@description('The webapps to be deployed.')
param windowsWebApps object

//@batchSize(1) - if needed to be deployed in sequence instead of a parallel deployment
module windowsWebApp './modules/appservices/webapp.bicep' = [for webApp in items(windowsWebApps): {
  name: webApp.value.name
  params: {
    webAppName: webApp.value.name
    resourceTags: webApp.value.resourceTags
    appServicePlanId: webApp.value.appServicePlanId
    changeTimeZone: webApp.value.changeTimeZone
    timeZone: webApp.value.timeZone
    windowsFxVersion: webApp.value.windowsFxVersion
    location: webApp.value.location

  }
}]
