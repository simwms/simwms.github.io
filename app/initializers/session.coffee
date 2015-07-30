`import Ember from 'ember'`

UserSession = Ember.ObjectProxy.extend
  isLoggedIn: Ember.computed.and "id"
  loginSlug: Ember.computed "email", "password", "rememberMe", ->
    email: @get("email")
    password: @get("password")
    rememberMe: @get("rememberMe")
  registerSlug: Ember.computed "username", "password", "email", ->
    username: @get("username")
    password: @get("password")
    email: @get("email")
  setup: (store) ->
    rememberToken = Cookies.get("rememberToken")
    if rememberToken?
      store.createRecord "session", {rememberToken}
      .save()
      .then @handleLoginSuccess.bind(@)
    else
      new Ember.RSVP.Promise (resolve) -> resolve()

  init: ->
    @_super arguments...
    @set "content",
      rememberMe: true

  register: (store) ->
    store
    .createRecord "user", @get("registerSlug")
    .save()
    .then (user) =>
      @login store

  login: (store) ->
    store
    .createRecord "session", @get("loginSlug")
    .save()
    .then @handleLoginSuccess.bind(@)

  handleLoginSuccess: (session) ->
    Cookies.set "rememberToken", token if token = session.get("rememberToken")
    @set "session", session
    @set "content", session.get "user"

initialize = (registry, application) ->
  application.register "session:user", UserSession
  application.inject "controller", "currentUser", "session:user"
  application.inject "route", "currentUser", "session:user"

SessionInitializer =
  name: "session"
  initialize: initialize

`export {initialize}`
`export default SessionInitializer`