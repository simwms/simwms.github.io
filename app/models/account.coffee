`import Ember from 'ember'`
`import DS from 'ember-data'`
`import ServicePlan from '../shekels/service-plan'`
`import ENV from 'forw/config/environment'`

alias = Ember.computed.alias

class TaskRunner
  constructor: (@account, @time) ->
  seconds: ->
    @time = @time * 1000
    @
  refreshUntil: (condition) ->
    @interval = window.setInterval @makeRefreshFun(condition), @time
  makeRefreshFun: (condition) ->
    => 
      if condition(@account)
        window.clearInterval @interval
        return @account
      if @account.id? and @account.get("isLoaded")
        return @account.reload()


Account = DS.Model.extend
  companyName: DS.attr "string"
  accessKeyId: DS.attr "string"
  secretAccessKey: DS.attr "string"
  timezone: DS.attr "string"
  namespace: DS.attr "string"
  host: DS.attr "string"
  uiuxHost: DS.attr "string", defaultValue: ENV.uiuxHost
  configHost: DS.attr "string", defaultValue: ENV.configHost
  user: DS.belongsTo "user", async: true
  insertedAt: DS.attr "date"
  status: DS.attr "string", defaultValue: "ok"
  region: alias "timezone"
  servicePlan: DS.belongsTo "servicePlan", async: true
  paymentSubscription: DS.belongsTo "paymentSubscription", async: true
  isProperlySetup: DS.attr "boolean"
  simwmsAccountKey: DS.attr "string"
  setupAttempts: DS.attr "number", defaultValue: 0

  considerProperSetup: Ember.on "ready", ->
    @every(2.5).seconds().refreshUntil => @get("isProperlySetup") or @get("setupAttempts") > 9

  every: (time) ->
    @taskRunner = new TaskRunner(@, time)

  configUri: Ember.computed "configHost", "id", "simwmsAccountKey", ->
    url = @get "configHost"
    token = @get "simwmsAccountKey"
    id = @get "id"
    paramString = Ember.$.param token: token, account: id
    "#{url}/#/?#{paramString}"

  uiuxUri: Ember.computed "uiuxHost", "id", "simwmsAccountKey", ->
    url = @get "uiuxHost"
    token = @get "simwmsAccountKey"
    id = @get "id"
    paramString = Ember.$.param token: token, account: id
    "#{url}/#/?#{paramString}"
`export default Account`