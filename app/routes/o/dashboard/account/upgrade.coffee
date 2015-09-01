`import Ember from 'ember'`

promise = (x) -> new Ember.RSVP.Promise (resolve) -> resolve x

R = Ember.Route.extend
  model: ->
    @store.findAll("servicePlan")
    .then =>
      Ember.RSVP.hash
        plans: @store.filter "servicePlan", (plan) -> plan.get("isAvailable")
        chosenPlan: @modelFor("o.dashboard.account").get("servicePlan")
        originalPlan: @modelFor("o.dashboard.account").get("servicePlan")
        paymentSubscription: @modelFor("o.dashboard.account").get("paymentSubscription")
        account: promise @modelFor("o.dashboard.account")
        phase: promise "selection"

`export default R`