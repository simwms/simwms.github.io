`import Ember from 'ember'`

DashboardAccountIndexController = Ember.Controller.extend
  actions:
    submit: ->
      @get "model"
      .save()
      .then =>
        @notify.success "It Worked!"

`export default DashboardAccountIndexController`