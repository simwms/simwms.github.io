`import Ember from 'ember'`
`import { module, test } from 'qunit'`
`import startApp from 'forw/tests/helpers/start-app'`

userParams =
  email: "test@test.test"
  password: "password"

module 'Acceptance: AccountCreation',
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

test 'visiting account creation', (assert) ->
  visit '/session'

  andThen ->
    assert.equal currentURL(), '/session'
    fillIn "input[name=email]", userParams.email
    fillIn "input[name=password]", userParams.password
    click "button[type=submit]"
    wait()

  andThen ->
    assert.equal currentPath(), "dashboard.accounts.index"
    visit "dashboard.accounts.new"

  andThen ->
    assert.equal currentURL(), "/dashboard/accounts/new"
    fillIn "input[name=companyName]", "acceptance-test-acct"
    click "button[type=submit]"
    wait()