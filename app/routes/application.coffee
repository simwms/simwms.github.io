`import Ember from 'ember'`

AppRoute = Ember.Route.extend
  queryParams:
    modal:
      refreshModel: true

  model: ->
    @currentUser.cookieLogin()

  actions:
    closeModal: ->
      @set "modal", null

`export default AppRoute`