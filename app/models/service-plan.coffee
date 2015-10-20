`import Ember from 'ember'`
`import DS from 'ember-data'`

c = Ember.computed

ServicePlan = DS.Model.extend
  stripePlanId: DS.attr "string"
  simwmsName: DS.attr "string"
  presentation: DS.attr "string"
  description: DS.attr "string"
  monthlyPrice: DS.attr "number", defaultValue: 0
  docks: DS.attr "number", defaultValue: Infinity
  warehouses: DS.attr "number", defaultValue: Infinity
  employees: DS.attr "number", defaultValue: Infinity
  scales: DS.attr "number", defaultValue: Infinity

  pricePresentation: c "monthlyPrice", ->
    $p = @get("monthlyPrice") / 100
    if $p > 0 then "$#{$p} / month" else "free"

  
`export default ServicePlan`