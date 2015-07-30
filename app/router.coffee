`import Ember from 'ember'`
`import config from './config/environment'`

Router = Ember.Router.extend
  location: config.locationType

Router.map ->
  @route "about"
  @resource "guides", path: "/guides", ->
    @resource "guides.guide", path: "/:id", ->
  @route "sample"
  @route "session"
  @resource "warehouse", path: "/warehouse/:id", ->
    @route "config"
  @resource "dashboard", path: "/dashboard", ->
    @resource "dashboard.preferences", path: "/preferences", ->
    @resource "dashboard.payment", path: "payment", ->
    @resource "dashboard.account", path: "/account/:id", ->
      @route "config"
      @route "edit"
    @resource "dashboard.accounts", path: "/accounts", ->
      @route "new"

`export default Router`
