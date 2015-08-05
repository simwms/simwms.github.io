`import Ember from 'ember'`

EmberIframeComponent = Ember.Component.extend
  classNames: ["ember-iframe-container"]
  iframeClassNames: "ember-iframe"
  iframeId: "ember-iframe"

  window$: ->
    @$ @$("iframe")[0].contentWindow

  document$: ->
    @$ @$("iframe")[0].contentDocument

  didInsertElement: ->
    @window$().on "hashchange", ({newUrl}) =>
      @sendAction "action", newUrl

    @document$().ready =>
      @sendAction "action", @get("src")
      @$(".ember-iframe-loading").hide()

    @document$().load =>
      @sendAction "action", @get("src")
      @$(".ember-iframe-loading").hide()

  willDestroyElement: ->
    @window$().off "hashchange"

`export default EmberIframeComponent`
