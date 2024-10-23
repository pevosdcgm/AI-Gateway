@description('List of Mock webapp names used to simulate OpenAI behavior.')
param mockWebApps array = []

@description('The name of the OpenAI mock backend pool')
param mockBackendPoolName string = 'openai-backend-pool'

@description('The description of the OpenAI mock backend pool')
param mockBackendPoolDescription string = 'Load balancer for multiple OpenAI Mocking endpoints'

@description('List of OpenAI resources to create. Add pairs of name and location.')
param openAIConfig array = []

@description('Deployment Name')
param openAIDeploymentName string

@description('Azure OpenAI Sku')
@allowed([
  'S0'
])
param openAISku string = 'S0'

@description('Model Name')
param openAIModelName string

@description('Model Version')
param openAIModelVersion string

@description('Model Capacity')
param openAIModelCapacity int = 20

@description('The name of the API Management resource')
param apimResourceName string

@description('Location for the APIM resource')
param apimResourceLocation string = resourceGroup().location

@description('The pricing tier of this API Management service')
@allowed([
  'Consumption'
  'Developer'
  'Basic'
  'Basicv2'
  'Standard'
  'Standardv2'
  'Premium'
])
param apimSku string = 'Consumption'

@description('The instance size of this API Management service.')
@allowed([
  0
  1
  2
])
param apimSkuCount int = 1

@description('The email address of the owner of the service')
param apimPublisherEmail string = 'noreply@microsoft.com'

@description('The name of the owner of the service')
param apimPublisherName string = 'Microsoft'

@description('The name of the APIM API for OpenAI API')
param openAIAPIName string = 'openai'

@description('The relative path of the APIM API for OpenAI API')
param openAIAPIPath string = 'openai'

@description('The display name of the APIM API for OpenAI API')
param openAIAPIDisplayName string = 'OpenAI'

@description('The description of the APIM API for OpenAI API')
param openAIAPIDescription string = 'Azure OpenAI API inferencing API'

@description('Full URL for the OpenAI API spec')
param openAIAPISpecURL string = 'https://raw.githubusercontent.com/Azure/azure-rest-api-specs/main/specification/cognitiveservices/data-plane/AzureOpenAI/inference/stable/2024-02-01/inference.json'

@description('The name of the APIM Subscription for OpenAI API')
param openAISubscriptionName string = 'openai-subscription'

@description('The description of the APIM Subscription for OpenAI API')
param openAISubscriptionDescription string = 'OpenAI Subscription'

@description('The name of the OpenAI backend pool')
param openAIBackendPoolName string = 'openai-backend-pool'

@description('The description of the OpenAI backend pool')
param openAIBackendPoolDescription string = 'Load balancer for multiple OpenAI endpoints'

// buult-in logging: additions BEGIN

@description('Name of the Log Analytics resource')
param logAnalyticsName string = 'workspace'

@description('Location of the Log Analytics resource')
param logAnalyticsLocation string = resourceGroup().location

@description('Name of the Application Insights resource')
param applicationInsightsName string = 'insights'

@description('Location of the Application Insights resource')
param applicationInsightsLocation string = resourceGroup().location

@description('Name of the APIM Logger')
param apimLoggerName string = 'apim-logger'

@description('Description of the APIM Logger')
param apimLoggerDescription string  = 'APIM Logger for OpenAI API'

@description('Number of bytes to log for API diagnostics')
param apiDiagnosticsLogBytes int = 8192

@description(' Name for the Workbook')
param workbookName string = 'OpenAIUsageAnalysis'

@description('Location for the Workbook')
param workbookLocation string = resourceGroup().location

@description('Display Name for the Workbook')
param workbookDisplayName string = 'OpenAI Usage Analysis'

// buult-in logging: additions END

// semantic-caching: additions BEGIN

@description('Embeddings Deployment Name')
param embeddingsDeploymentName string

@description('Embeddings Model Name')
param embeddingsModelName string

@description('Embeddings Model Version')
param embeddingsModelVersion string = '1'

@description('Embeddings Model Capacity')
param embeddingsModelCapacity int = 20

@description('Location of the Redis Enterprise Cache')
param redisCacheLocation string = resourceGroup().location

@description('Name of the Redis Enterprise Cache')
param redisCacheName string = 'redisCache'

@description('SKU of the Redis Enterprise Cache')
param redisCacheSKU string = 'Enterprise_E5'

@description('Capacity of the Redis Enterprise Cache')
param redisCacheCapacity int = 2

@description('Specify the family for the sku. C = Basic/Standard, P = Premium.')
@allowed([
  'C'
  'P'
])
param redisCacheFamily string = 'C'

@description('Specify a boolean value that indicates whether to allow access via non-SSL ports.')
param enableNonSslPort bool = false

@description('Eviction Policy of the Redis Enterprise Cache')
param redisEvictionPolicy string = 'NoEviction'

@description('Port of the Redis Enterprise Cache')
param redisPort int = 10000



// semantic-caching: additions END

var resourceSuffix = uniqueString(subscription().id, resourceGroup().id)



// semantic-caching: additions BEGIN
/*
resource redisEnterprise 'Microsoft.Cache/redisEnterprise@2022-01-01' = {
  name: '${redisCacheName}-${resourceSuffix}'
  location: redisCacheLocation
  sku: {
    name: redisCacheSKU
    capacity: redisCacheCapacity
  }
}

resource redisCache 'Microsoft.Cache/redisEnterprise/databases@2022-01-01' = {
  name: 'default'
  parent: redisEnterprise
  properties: {
    evictionPolicy: redisEvictionPolicy
    clusteringPolicy: 'EnterpriseCluster'
    modules: [
      {
        name: 'RediSearch'
      }
    ]
    port: redisPort
  }
}
*/

resource redisCache 'Microsoft.Cache/redis@2023-08-01' = {
  name: '${redisCacheName}-${resourceSuffix}'
  location: redisCacheLocation
  properties: {
    enableNonSslPort: enableNonSslPort
    minimumTlsVersion: '1.2'
    sku: {
      capacity: redisCacheCapacity
      family: redisCacheFamily
      name: redisCacheSKU
    }
  }
}

output redisCache string = redisCache.properties.hostName


