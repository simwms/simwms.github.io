`import Ember from 'ember'`

simplifyError = ({detail, source}) -> 
  if typeof detail is "string"
    msg = detail
    [..., key] = source.pointer.split("/")
  else
    key = detail.key
    msg = detail.msg
  {key, msg}


unify = (obj, error) ->
  if obj.get(error.key)?
    obj.get(error.key).pushObject error.msg
  else
    obj.set error.key, Ember.A [error.msg]
  obj

hashifyErrors = (obj, errors) ->
  Ember.A(errors)
  .map simplifyError
  .reduce unify, obj

SessionController = Ember.Controller.extend
  queryParams: ["tab"]
  tab: "login"
  showLogin: Ember.computed.equal "tab", "login"
  showRegister: Ember.computed.equal "tab", "register"
  errors: Ember.Object.create()
  user: Ember.computed.alias("model")
  passwordMatchError: Ember.computed "model.password", "model.passwordConfirmation", ->
    p = @get 'model.password'
    pc = @get 'model.passwordConfirmation'
    return ["Password doesn't match confirmation"] if pc isnt p

  hashifyErrors: (errors) ->
    hashifyErrors @get("errors"), errors
  actions:
    clicked: (tab) ->
      @set "tab", tab
    submitLogin: ->
      @set "isBusy", true
      @set "errors", Ember.Object.create()
      @get("user").login @store
      .then =>
        @transitionToRoute "o.dashboard"
      .catch ({errors}) =>
        @hashifyErrors errors
      .finally =>
        @set "isBusy", false
    submitRegister: ->
      @set "isBusy", true
      @set "errors", Ember.Object.create()
      @get("user").register @store
      .then =>
        @transitionToRoute "o.dashboard"
      .catch ({errors}) =>
        @hashifyErrors errors
      .finally =>
        @set "isBusy", false
      

`export default SessionController`
