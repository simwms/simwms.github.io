`import Ember from 'ember'`
`import config from './config/environment'`

Router = Ember.Router.extend
  location: config.locationType

Router.map ->
  @resource "x", path: "/x", ->
    @resource "x.warehouse", path: "/warehouse/:id", ->
      @route "config"
  
  @resource "o", path: "/o", ->
    @route "pricing"
    @route "about"
    @resource "o.guides", path: "/guides", ->
      @resource "o.guides.guide", path: "/:id", ->
    @route "sample"
    @route "session"
    @resource "o.dashboard", path: "/dashboard", ->
      @resource "o.dashboard.preferences", path: "/preferences", ->
      @resource "o.dashboard.payment", path: "payment", ->
      @resource "o.dashboard.account", path: "/account/:id", ->
        @route "upgrade"
        @route "config"
        @route "edit"
      @resource "o.dashboard.accounts", path: "/accounts", ->
        @route "new"

`export default Router`
