
initialize = (application) ->
  store = application.container.lookup "service:store"
  session = application.container.lookup "session:user"
  session.setup store

SetupSessionInitializer =
  name: "setup-session"
  initialize: initialize

`export {initialize}`
`export default SetupSessionInitializer`