`import Ember from 'ember'`
`import config from './config/environment'`

Router = Ember.Router.extend
  location: config.locationType

Router.map ->
  @route "sample"
  @route "pricing"
  @route "about"
  @route "session"
  @route "login"
  @route "register"
  @resource "guides", path: "/guides", ->
    @resource "guides.guide", path: "/:id", ->
  @resource "dashboard", path: "/dashboard", ->
    @resource "dashboard.preferences", path: "/preferences", ->
    @resource "dashboard.account", path: "/account/:id", ->
      @route "edit"
    @resource "dashboard.accounts", path: "/accounts", ->
      @route "new"


`export default Router`
