`import Ember from 'ember'`
`import { module, test } from 'qunit'`
`import startApp from 'forw/tests/helpers/start-app'`

userParams =
  email: "test@test.test"
  password: "password"

pause = (time, f) ->
  new Ember.RSVP.Promise (resolve) ->
    window.setTimeout (-> resolve f()), time

module 'Acceptance: Session',
  beforeEach: ->
    @application = startApp()
    ###
    Don't return anything, because QUnit looks for a .then
    that is present on Ember.Application, but is deprecated.
    ###
    @currentUser = @application.__container__.lookup("service:user-session")
    return

  afterEach: ->
    Ember.run @application, 'destroy'

test 'visiting /session', (assert) ->
  visit '/session'
  dogs = []
  andThen =>
    assert.equal currentURL(), '/session'
    @currentUser.logout()
    .then ->
      pause 100, ->
        dogs.pushObject "rover"

  andThen =>
    assert.deepEqual dogs, ["rover"], "andThen should wait for the previous promise to fulfil"
    assert.notOk @currentUser.get("isLoggedIn"), "we should start not logged in"

    fillIn "input[name=email]", userParams.email
    fillIn "input[name=password]", "wrong password"
    click "button[type=submit]"
    wait()

  andThen =>
    assert.equal currentPath(), "session", "login should fail with the wrong password"
    redTexts = []
    find("small.red-text").map -> redTexts.pushObject Ember.$(@).text().trim()
    expected = ["", "wrong password"]
    assert.deepEqual redTexts, expected, "incorrect login should be met with a helpful message"

    fillIn "input[name=password]", userParams.password
    click "button[type=submit]"

  andThen =>
    assert.equal currentPath(), "dashboard.accounts.index", "we should be successfully logged in"
    redTexts = []
    find("small.red-text").map -> redTexts.pushObject Ember.$(@).text().trim()
    expected = []
    assert.deepEqual redTexts, expected, "these should be the correct credentials"
    assert.ok @currentUser.get("isLoggedIn"), "we should be logged in given the correct credentials"
    assert.equal currentPath(), "dashboard.accounts.index", "after login, we should be redirected to our dashboard"

    visit "/dashboard/preferences"
  
  andThen ->
    click "button[name=logout]"