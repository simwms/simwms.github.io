`import Ember from 'ember'`
`import ENV from 'forw/config/environment'`

{$, computed} = Ember
{alias} = computed


DashboardAccountController = Ember.Controller.extend
  account: alias "model.account"
  plan: alias "model.plan"
  appParams: computed "account.permalink", "currentUser.simwmsUserSession",
    get: ->
      account = @get("account.permalink")
      user = @currentUser.get("simwmsUserSession")
      $.param {account, user}

  launchUri: computed "appParams",
    get: ->
      ENV.launchHost + "/#/?" + @get("appParams")

  configUri: computed "appParams",
    get: ->
      ENV.configHost + "/#/?" + @get("appParams")

  upgradeUri: computed "appParams",
    get: ->
      ENV.configHost + "/#/plan?" + @get("appParams")

`export default DashboardAccountController`
