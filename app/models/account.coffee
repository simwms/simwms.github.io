`import Ember from 'ember'`
`import DS from 'ember-data'`
`import ServicePlan from '../shekels/service-plan'`
`import ENV from 'forw/config/environment'`

alias = Ember.computed.alias

Account = DS.Model.extend
  companyName: DS.attr "string"
  accessKeyId: DS.attr "string"
  secretAccessKey: DS.attr "string"
  timezone: DS.attr "string"
  namespace: DS.attr "string"
  host: DS.attr "string"
  uiuxHost: DS.attr "string", defaultValue: ENV.uiuxHost
  configHost: DS.attr "string", defaultValue: ENV.configHost
  user: DS.belongsTo "user", async: true
  insertedAt: DS.attr "date"
  status: DS.attr "string", defaultValue: "ok"
  region: alias "timezone"
  servicePlan: DS.belongsTo "servicePlan", async: true
  paymentSubscription: DS.belongsTo "paymentSubscription", async: true
  isProperlySetup: DS.attr "boolean"
  simwmsAccountKey: DS.attr "string"
`export default Account`