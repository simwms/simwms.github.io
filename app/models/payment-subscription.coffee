`import DS from 'ember-data'`

PaymentSubscription = DS.Model.extend
  source: DS.attr "string"

  user: DS.belongsTo "user", async: true
  account: DS.belongsTo "account", async: true
  servicePlan: DS.belongsTo "servicePlan", async: true

`export default PaymentSubscription`