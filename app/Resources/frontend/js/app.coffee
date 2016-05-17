require 'jquery'
require 'lodash'
require 'bootstrap-sass/assets/javascripts/bootstrap'

config     = require './config'
Backbone   = require 'backbone'
Marionette = require 'backbone.marionette'
Router     = require './routers/router'
User       = require './models/user'

window.App = new Marionette.Application

App.navigate = (route, options) ->
  options || (options = {})
  Backbone.history.navigate route, options

App.getCurrentRoute = ->
  Backbone.history.fragment

App.on 'before:start', (options) ->
  Backbone.emulateHTTP = true
  @user = new User(options.userData)
  options.user = @user

App.on 'start', (options) ->
  console.log 'App.start'
  @router = new Router(options)
  Backbone.history.start()
  @userShow() if ! this.getCurrentRoute()

App.userShow = ->
  App.navigate 'show'
  @router.controller.showUser()

App.userEdit = ->
  App.navigate 'edit'
  @router.controller.editUser()

App.start(config)