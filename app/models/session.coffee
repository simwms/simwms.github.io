`import Ember from 'ember'`
`import DS from 'ember-data'`

alias = Ember.computed.alias

Session = DS.Model.extend
  email: DS.attr "string"
  password: DS.attr "string"
  rememberToken: DS.attr "string"
  rememberMe: DS.attr "boolean"
  user: DS.belongsTo "user", async: false

  accounts: alias("user.accounts")

`export default Session`