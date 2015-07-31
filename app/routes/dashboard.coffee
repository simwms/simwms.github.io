`import Ember from 'ember'`

DashboardRoute = Ember.Route.extend
  model: ->
    @currentUser
  afterModel: (model) ->
    @transitionTo "index" unless model.get("isLoggedIn")
      
  actions:
    logout: ->
      @currentUser.then (currentUser) ->
        currentUser.logout()
      .then =>
        @transitionTo "index"


`export default DashboardRoute`
