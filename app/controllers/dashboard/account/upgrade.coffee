`import Ember from 'ember'`
`import CPM from 'ember-cpm'`

notOneOf = (objKey, arrKey) ->
  Ember.computed objKey, arrKey, ->
    not @getWithDefault(arrKey, []).contains @get objKey

a = Ember.computed.alias
gt = Ember.computed.gt
eq = Ember.computed.equal
same = (k1, k2) ->
  Ember.computed k1, k2, ->
    @get(k1)? and @get(k1) is @get(k2)

DashboardAccountUpgradeController = Ember.Controller.extend
  plans: a "model.plans"
  chosenPlan: a "model.chosenPlan"
  originalPlan: a "model.originalPlan"
  paymentSubscription: a "model.paymentSubscription"
  account: a "model.account"
  phase: a "model.phase"
  usingDeprecatedPlan: notOneOf "chosenPlan", "plans"
  isSelectionStage: eq "phase", "selection"
  isConfirmationStage: eq "phase", "confirmation"
  chosenPlanRequiresPayment: gt "chosenPlan.monthlyPrice", 0
  chosenEqOriginalPlan: same "chosenPlan.id", "originalPlan.id"
  actions:
    processStripeToken: (token) ->
      ps = @get "paymentSubscription"
      ps.set "source", token.id
      ps.set "servicePlan", @get("chosenPlan")
      @set "isBusy", true
      ps.save()
      .then =>
        presentation = @get("chosenPlan.presentation")
        @notify.success "It worked! Service plan switched to: #{presentation}"
        @transitionToRoute "o.dashboard.account.index", @get("account.id")
        @get("account").reload()
      .catch (error) =>
        @notify.alert "Uh-oh! The server was unable to complete your request"
        console.log error
      .finally =>
        @set "isBusy", false

    confirm: ->
      ps = @get "paymentSubscription"
      @set "isBusy", true
      ps.destroyRecord()
      .then =>
        presentation = @get("chosenPlan.presentation")
        @notify.success "It worked! Service plan switched to: #{presentation}"
        @transitionToRoute "o.dashboard.account.index", @get("account.id")
      .catch (error) =>
        @notify.alert "Uh-oh! The server was unable to complete your request"
        console.log error
      .finally =>
        @set "isBusy", false

    next: ->
      @set "phase", "confirmation"

`export default DashboardAccountUpgradeController`