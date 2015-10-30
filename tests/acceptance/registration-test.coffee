`import Ember from 'ember'`
`import { module, test } from 'qunit'`
`import startApp from 'forw/tests/helpers/start-app'`

userParams =
  email: "forw-test-no-#{Math.random()}@testmail.co"
  password: "password123"
  username: "forw-test-user-no-#{Math.random()}"

module 'Acceptance: Registration',
  beforeEach: ->
    @application = startApp()
    ###
    Don't return anything, because QUnit looks for a .then
    that is present on Ember.Application, but is deprecated.
    ###
    @currentUser = @application.__container__.lookup("service:user-session")
    return

  afterEach: ->
    @currentUser.logout()
    Ember.run @application, 'destroy'

test 'visiting /register', (assert) ->
  visit "/"

  andThen =>
    @currentUser.logout()
    .then =>
      visit '/register'

      andThen =>
        assert.notOk @currentUser.get("isLoggedIn"), "we should start not logged in"
        assert.equal currentPath(), "register"
        values = []
        find("input").map -> values.pushObject $(@).val()
        expected = ["", "", "", ""]
        assert.deepEqual values, expected
        click "button[type=submit]"

      andThen ->
        assert.equal currentPath(), "register", "having failed validation, we should still be on validation"
        errorTexts = []
        find("small.red-text").map -> errorTexts.pushObject $(@).text().trim()
        expected = [
          "can't be blank"
          "can't be blank"
          "can't be blank"
          ""
        ]
        assert.deepEqual errorTexts, expected, "server side validation should work"

      andThen ->
        fillIn "input[name=username]", userParams.username
        fillIn "input[name=email]", userParams.email
        fillIn "input[name=password]", userParams.password
        fillIn "input[name=passwordConfirmation]", userParams.password

        click "button[type=submit]"

      andThen =>
        assert.equal currentPath(), "dashboard.accounts.index", "after registration, we should be logged in and redirected to the dashboard"
        assert.ok Cookies.get("simwmsUserSession"), "logging should store a cookie on our machine"
        assert.ok @currentUser.get("isLoggedIn"), "the user should be logged in"
        visit "/dashboard/preferences"

      andThen ->
        click "button[name=logout]"

      andThen =>
        assert.equal currentPath(), "index"
        assert.notOk @currentUser.get("isLoggedIn"), "we should no longer be logged in after logging out"