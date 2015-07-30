`import Ember from 'ember'`

DashboardAccountRoute = Ember.Route.extend
  model: ({id}) ->
    @store.findRecord("account", id)

`export default DashboardAccountRoute`