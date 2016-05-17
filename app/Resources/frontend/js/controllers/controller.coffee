Backbone   = require 'backbone'
Marionette = require 'backbone.marionette'
Layout     = require '../views/layout'
EditLayout = require '../views/edit'

class Controller extends Marionette.Object
  indexAction: ->
    console.log 'index action'
  showUser: ->
    console.log 'showUser action'
    if not @layout
      @layout = new Layout(@options)

    $ =>
      @layout.render()

  editUser: ->
    console.log 'editUser action'
    if not @editLayout
      @editLayout = new EditLayout(@options)
    $ =>
      @editLayout.render()

module.exports = Controller