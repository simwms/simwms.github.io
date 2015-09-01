`import Ember from 'ember'`

TestPlan =
  name: "test"
  description: "test plan, should not be visible for selection"
  monthlyPrice: 0
  docks: Infinity
  scales: Infinity
  warehouses: Infinity
  employees: Infinity
  availability: 24
  appointments: Infinity

FreeTrialPlan =
  name: "free-trial"
  description: "Trial plan lets you try out the software on a small pretend warehouse."
  monthlyPrice: 0
  docks: 1
  scales: 1
  warehouses: 4
  employees: 5
  availability: 18
  appointments: 10

BasicPlan =
  name: "basic"
  description: "Basic plan is ideal for small warehouses with low traffic."
  monthlyPrice: 50
  docks: 5
  scales: 2
  warehouses: 36
  employees: 10
  availability: 24
  appointments: 25

StandardPlan =
  name: "standard"
  description: "Standard plan for medium sized warehouses with high traffic."
  monthlyPrice: 100
  docks: 10
  scales: Infinity
  warehouses: Infinity
  employees: 25
  availability: 24
  appointments: 75

EnterprisePlan =
  name: "enterprise"
  description: "Enterprise plan for large enterprise warehouses, no hard limits on anything."
  monthlyPrice: 200
  docks: Infinity
  scales: Infinity
  warehouses: Infinity
  employees: Infinity
  availability: 24
  appointments: Infinity

Plans = [
  FreeTrialPlan,
  BasicPlan,
  StandardPlan,
  EnterprisePlan
]
class ServicePlan
  @plans = Plans
  @fromName = (planName) -> new ServicePlan planName
  constructor: (@name) ->

  limitations: ->
    switch @name
      when "test" then TestPlan
      when "free-trial" then  FreeTrialPlan
      when "basic" then BasicPlan
      when "standard" then StandardPlan
      when "enterprise" then EnterprisePlan
      else {}

`export {Plans}`
`export default ServicePlan`