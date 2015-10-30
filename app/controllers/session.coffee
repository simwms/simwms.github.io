`import Ember from 'ember'`
{computed, A, Object} = Ember
{alias, equal} = computed

SessionController = Ember.Controller.extend
  errors: alias "model.errors"
  user: alias "model"
  email: alias "user.email"
  password: alias "user.password"
  actions:
    submitLogin: ->
      email = @get "email"
      password = @get "password"
      @transitionToRoute "login", 
        queryParams: {email, password}

`export default SessionController`
