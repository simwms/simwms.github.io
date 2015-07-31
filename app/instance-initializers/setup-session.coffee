`import session from '../singletons/user-session'`

initialize = (application) ->
  store = application.container.lookup "service:store"
  deferred = application.container.lookup "defer-session:user"
  session.setup store
  .then -> deferred.resolve session

SetupSessionInitializer =
  name: "setup-session"
  initialize: initialize

`export {initialize}`
`export default SetupSessionInitializer`