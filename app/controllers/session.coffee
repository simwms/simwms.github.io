`import Ember from 'ember'`
{computed, A, Object} = Ember
{alias, equal} = computed

SessionController = Ember.Controller.extend
  errors: alias "model.errors"
  user: alias "model"

  actions:
    submitLogin: ->
      @set "isBusy", true
      @get("user").smartLogin
        email: @get "model.email"
        password: @get "model.password"
      .finally =>
        if @currentUser.get("isLoggedIn")
          @transitionToRoute "dashboard"
        @set "isBusy", false
      

`export default SessionController`
