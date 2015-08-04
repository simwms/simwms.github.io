`import Ember from 'ember'`
`import DS from 'ember-data'`

alias = Ember.computed.alias

Account = DS.Model.extend
  companyName: DS.attr "string"
  accessKeyId: DS.attr "string"
  secretAccessKey: DS.attr "string"
  timezone: DS.attr "string"
  namespace: DS.attr "string"
  host: DS.attr "string"
  uiuxHost: DS.attr "string"
  configHost: DS.attr "string"
  servicePlan: DS.attr "string", defaultValue: "free-trial"
  user: DS.belongsTo "user", async: true
  insertedAt: DS.attr "date"

  region: alias "timezone"

`export default Account`