`import Ember from 'ember'`

DashboardAccountsRoute = Ember.Route.extend
  model: ->
    @store.findAll "account"

`export default DashboardAccountsRoute`