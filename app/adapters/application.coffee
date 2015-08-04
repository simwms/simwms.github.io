`import Ember from 'ember'`
`import ENV from 'forw/config/environment'`
`import ActiveModelAdapter from 'active-model-adapter'`

volatile = ->
  Ember.computed(arguments...).volatile()
ApplicationAdapter = ActiveModelAdapter.extend
  namespace: ENV.namespace
  host: ENV.host
  headers: volatile "currentUser.rememberToken", ->
    "remember_token": @get("currentUser.rememberToken")

`export default ApplicationAdapter`
