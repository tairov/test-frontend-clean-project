Backbone   = require 'backbone'
Marionette = require 'backbone.marionette'
moment     = require 'moment'

class Layout extends Marionette.LayoutView
  constructor: (options) ->
    @el = options.appContainer
    @model = options.user
    @template = options.appTemplate
    super(options)

  ui:
    edit: '.main__edit-button'

  modelEvents:
    change: 'render'

  templateHelpers:
    '_': _
    'birthDate': (dt) ->
      moment(dt).format("DD MMMM YYYY")

  events:
    'click @ui.edit': 'onUserEdit'

  onUserEdit: ->
    App.userEdit()


module.exports = Layout