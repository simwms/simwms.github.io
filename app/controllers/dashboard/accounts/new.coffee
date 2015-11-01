`import Ember from 'ember'`
`import {hashifyErrors} from 'forw/utils/session-tools'`

DashboardAccountsNewController = Ember.Controller.extend
  isBusy: false
  
  hashifyErrors: (errors) ->
    hashifyErrors @get("errors"), errors

  actions:
    submit: ->
      @set "errors", Ember.Object.create()
      @set "isBusy", true
      @get "model"
      .save()
      .then (account) =>
        @notify.success "account creation successful"
        @transitionToRoute "dashboard.account.index", account.get("id")
      .catch ({errors}) =>
        @notify.alert "account creation has errors"
        @hashifyErrors errors
      .finally =>
        @set "isBusy", false
`export default DashboardAccountsNewController`