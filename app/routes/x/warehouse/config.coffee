`import Ember from 'ember'`

WarehouseConfigRoute = Ember.Route.extend
  model: ->
    @modelFor "x.warehouse"
`export default WarehouseConfigRoute`