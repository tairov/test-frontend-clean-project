Backbone   = require 'backbone'
Marionette = require 'backbone.marionette'
Controller = require '../controllers/controller'

class Router extends Marionette.AppRouter
  appRoutes:
    '': 'indexAction'
    'show': 'showUser'
    'edit': 'editUser'
  initialize: ->
    @controller = new Controller @options

module.exports = Router