`import Ember from 'ember'`

LoginRoute = Ember.Route.extend
  queryParams:
    email:
      refreshModel: true
    password:
      refreshModel: true

  model: (params) ->
    {email, password} = params
    @currentUser.clearErrors()
    @currentUser.login {email, password}

  afterModel: ->
    if @currentUser.get("isLoggedIn")
      @transitionTo "dashboard"
    else
      @transitionTo "session"

`export default LoginRoute`