`import Ember from 'ember'`

DashboardIndexRoute = Ember.Route.extend
  beforeModel: ->
    @transitionTo "o.dashboard.accounts"

`export default DashboardIndexRoute`