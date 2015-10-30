`import Ember from 'ember'`

RegisterRoute = Ember.Route.extend
  model: -> 
    @store.createRecord "user"

  tearDown: Ember.on "deactivate", ->
    model = @controller.get "model"
    model.deleteRecord() if Ember.get(model, "hasDirtyAttributes")

`export default RegisterRoute`