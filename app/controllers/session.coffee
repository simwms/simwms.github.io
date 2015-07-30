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
  errors: Ember.computed.alias "model"
  passwordMatchError: Ember.computed "currentUser.password", "currentUser.passwordConfirmation", ->
    p = @get 'currentUser.password'
    pc = @get 'currentUser.passwordConfirmation'
    return ["Password doesn't match confirmation"] if pc isnt p

  hashifyErrors: (errors) ->
    hashifyErrors @get("errors"), errors
  actions:
    clicked: (tab) ->
      @set "tab", tab
    submitLogin: ->
      @set "errors", Ember.Object.create()
      @currentUser.login @store
      .catch ({errors}) =>
        @hashifyErrors errors
      .then =>
        @transitionToRoute "dashboard"
    submitRegister: ->
      @set "errors", Ember.Object.create()
      @currentUser.register @store
      .catch ({errors}) =>
        @hashifyErrors errors
      .then =>
        @transitionToRoute "dashboard"
      

`export default SessionController`
