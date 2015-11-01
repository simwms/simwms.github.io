# Takes two parameters: container and application
initialize = (container, application) ->
  application.inject "controller", "notify", "service:notify"
  application.inject "route", "notify", "service:notify"

NotifyInitializer =
  name: 'notify'
  initialize: initialize

`export {initialize}`
`export default NotifyInitializer`
