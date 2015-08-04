`import Ember from 'ember'`

IndexRoute = Ember.Route.extend
  afterModel: -> @transitionTo "o.index"

`export default IndexRoute`