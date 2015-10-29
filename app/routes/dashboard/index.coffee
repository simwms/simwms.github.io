`import Ember from 'ember'`

DashboardIndexRoute = Ember.Route.extend
  beforeModel: ->
    @transitionTo "dashboard.accounts"

`export default DashboardIndexRoute`