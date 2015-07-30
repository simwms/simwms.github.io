`import DS from 'ember-data'`

Session = DS.Model.extend
  email: DS.attr "string"
  password: DS.attr "string"
  rememberToken: DS.attr "string"
  rememberMe: DS.attr "boolean"
  user: DS.belongsTo "user", async: false


`export default Session`