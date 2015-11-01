`import Ember from 'ember'`

DashboardAccountsNewRoute = Ember.Route.extend
  model: ->
    @store.createRecord "account"

  tearDown: Ember.on "deactivate", ->
    model = @controller.get "model"
    model.deleteRecord() if Ember.get(model, "hasDirtyAttributes")

`export default DashboardAccountsNewRoute`