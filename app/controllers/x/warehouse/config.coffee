`import Ember from 'ember'`

WarehouseConfigController = Ember.Controller.extend
  configHost: Ember.computed "model.id", "model.configHost", "currentUser.rememberToken", ->
    url = @get "model.configHost"
    token = @get "currentUser.rememberToken"
    id = @get "model.id"
    paramString = Ember.$.param token: token, account: id
    "#{url}?#{paramString}"

`export default WarehouseConfigController`