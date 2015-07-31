`import Ember from 'ember'`

SessionRoute = Ember.Route.extend
  model: -> 
    @currentUser

`export default SessionRoute`