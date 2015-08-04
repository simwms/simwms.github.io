`import Ember from 'ember'`

WarehouseRoute = Ember.Route.extend
  model: ({id}) ->
    @store.findRecord "account", id

`export default WarehouseRoute`