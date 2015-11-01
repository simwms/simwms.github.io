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
      @notify.success "you are logged in"
      @transitionTo "dashboard"
    else
      @notify.alert "unable to log in"
      @transitionTo "session"

`export default LoginRoute`