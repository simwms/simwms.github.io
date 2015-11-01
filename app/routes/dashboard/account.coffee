`import Ember from 'ember'`

{RSVP} = Ember

DashboardAccountRoute = Ember.Route.extend
  model: ({id}) ->
    @store.findRecord("account", id)
    .then (account) ->
      RSVP.hash
        plan: account.get("servicePlan")
        account: RSVP.resolve(account)


`export default DashboardAccountRoute`