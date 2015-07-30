`import Ember from 'ember'`

DashboardAccountsNewController = Ember.Controller.extend
  isBusy: false
  actions:
    submit: ->
      @set "isBusy", true
      @get "model"
      .save()
      .then (account) =>
        @set "isBusy", false
        @transitionToRoute "dashboard.account.index", account.get("id")
      .catch (errors) =>
`export default DashboardAccountsNewController`