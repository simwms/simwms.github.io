`import Ember from 'ember'`

WarehouseController = Ember.Controller.extend
  configHost: Ember.computed "model.id", "model.configHost", "currentUser.rememberToken", ->
    url = @get "model.configHost"
    token = @get "currentUser.rememberToken"
    id = @get "model.id"
    paramString = Ember.$.param token: token, account: id
    "#{url}/#/?#{paramString}"
    
  uiuxHost: Ember.computed "model.id", "model.uiuxHost", "currentUser.rememberToken", ->
    url = @get "model.uiuxHost"
    token = @get "currentUser.rememberToken"
    id = @get "model.id"
    paramString = Ember.$.param token: token, account: id
    "#{url}/#/?#{paramString}"

  actions:
    hashchange: (url) ->
      @set "popLink", url

`export default WarehouseController`