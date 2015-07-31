`import Ember from 'ember'`
`import DS from 'ember-data'`
initialize = (registry, application) ->
  deferred = Ember.RSVP.defer()
  promise = DS.PromiseObject.create promise: deferred.promise
  application.register "defer-session:user", deferred, instantiate: false
  application.register "session:user", promise, instantiate: false
  application.inject "controller", "currentUser", "session:user"
  application.inject "route", "currentUser", "session:user"
  application.inject "adapter", "currentUser", "session:user"

SessionInitializer =
  name: "session"
  initialize: initialize

`export {initialize}`
`export default SessionInitializer`