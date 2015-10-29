`import Ember from 'ember'`
`import {hashifyErrors} from '../utils/session-tools'`
{computed, A, Object} = Ember
{alias, equal} = computed

RegisterController = Ember.Controller.extend
  user: alias "model"
  email: alias "user.email"
  password: alias "user.password"
  passwordConfirmation: alias "user.passwordConfirmation"
  passwordMatchError: computed "password", "passwordConfirmation", 
    get: ->
      p = @get 'password'
      pc = @get 'passwordConfirmation'
      return ["Password doesn't match confirmation"] if pc isnt p

  hashifyErrors: (errors) ->
    hashifyErrors @get("errors"), errors
  actions:
    submitRegister: ->
      @set "isBusy", true
      @set "errors", Ember.Object.create()
      password = @get "password"
      email = @get "email"
      @get "user"
      .save()
      .then =>
        @currentUser.login {email, password}
      .catch ({errors}) =>
        @hashifyErrors errors
      .finally =>
        if @currentUser.get("isLoggedIn")
          @transitionToRoute "dashboard"
        @set "isBusy", false

`export default RegisterController`
