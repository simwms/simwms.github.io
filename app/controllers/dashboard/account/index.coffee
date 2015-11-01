`import Ember from 'ember'`

{alias} = Ember.computed

DashboardAccountIndexController = Ember.Controller.extend
  account: alias "model.account"
  plan: alias "model.plan"
  actions:
    destroy: ->
      @get "account"
      .destroyRecord()
      .then =>
        @transitionToRoute "dashboard"
        @notify.info "Your account has been marked for deletion"

`export default DashboardAccountIndexController`