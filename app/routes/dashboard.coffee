`import Ember from 'ember'`

DashboardRoute = Ember.Route.extend
  beforeModel: ->
    @transitionTo "index" unless @currentUser.get("isLoggedIn")
  model: ->
    @store.findAll "service-plan"
      
  actions:
    logout: ->
      @currentUser.logout()
      .then =>
        @currentUser.accountLogout()
        @transitionTo "index"

`export default DashboardRoute`
