`import Ember from 'ember'`
alias = Ember.computed.alias
ifPresent = Ember.computed.and

UserSession = Ember.Object.extend
  rememberMe: true
  user: alias("session.user")
  rememberToken: alias("session.rememberToken")
  isLoggedIn: ifPresent "session.id"
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
      .catch (error) ->
        Cookies.remove("rememberToken")
        throw error
    else
      new Ember.RSVP.Promise (resolve) -> resolve()

  register: (store) ->
    store
    .createRecord "user", @get("registerSlug")
    .save()
    .then (user) =>
      @login store

  logout: ->
    if @get("isLoggedIn")
      promise = @get("session").destroyRecord()
    else
      promise = new Ember.RSVP.Promise (resolve) -> resolve()
    promise.then => 
      @set "session", null
      Cookies.remove("rememberToken")

  login: (store) ->
    store
    .createRecord "session", @get("loginSlug")
    .save()
    .then @handleLoginSuccess.bind(@)

  handleLoginSuccess: (session) ->
    Cookies.set "rememberToken", token if token = session.get("rememberToken")
    @set "session", session

UserSession.instance = UserSession.create()

`export default UserSession.instance`
`export { UserSession }`