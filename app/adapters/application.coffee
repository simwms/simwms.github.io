`import ENV from 'forw/config/environment'`
`import ActiveModelAdapter from 'active-model-adapter'`

ApplicationAdapter = ActiveModelAdapter.extend
  namespace: ENV.namespace
  host: ENV.host

`export default ApplicationAdapter`
