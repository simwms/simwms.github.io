`import Ember from 'ember'`

WarehouseIndexRoute = Ember.Route.extend
  model: ->
    @modelFor "x.warehouse"
`export default WarehouseIndexRoute`