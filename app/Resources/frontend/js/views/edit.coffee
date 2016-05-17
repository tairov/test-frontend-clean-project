Backbone   = require 'backbone'
Marionette = require 'backbone.marionette'
moment     = require 'moment'

class Layout extends Marionette.LayoutView
  constructor: (options) ->
    @el = options.userEditContainer
    @model = options.user
    @template = options.userEditTemplate
    super(options)

  onRender: ->
    $('.js-my-edit-modal').on 'hidden.bs.modal', (e) ->
      console.log 'edit modal form closed'
      App.navigate 'show'

    $('.js-my-edit-modal').on 'shown.bs.modal', (e) ->
      console.log 'edit modal form shown'

    $('.js-my-edit-modal').modal()

  modelEvents:
    change: 'render'

  ui:
    'input': 'input'
    'save': '.main__save-button'
    'cancel': '.main__cancel-button'
    '_csrf_token': '[name="_csrf_token"]'

    siteUrl: '[name="siteUrl"]'
    userPhone: '[name="userPhone"]'
    userSkill: '[name="userSkill"]'
    userName: '[name="userName"]'
    userAbout: '[name="userAbout"]'
    password: '[name="password"]'
    userEmail: '[name="userEmail"]'
    userGender: '[name="userGender"]'
    userBirthday: '[name="userBirthday"]'

  templateHelpers:
    '_': _
    'birthDate': (dt) ->
      moment(dt).format "YYYY-MM-DD"
      #moment(dt).format "DD MMMM YYYY"
    'checkGender': (userGender, gender) ->
      return if userGender == gender then 'checked="checked"' else ''
    

  events:
    'focusin @ui.input': 'labelState'
    'focusout @ui.input': 'labelState'
    'click @ui.save': 'processForm'
    'keyup @ui.input': 'validationState'
    'blur @ui.input':  'validationState'
    'click @ui.cancel': 'closeModal'

#    'change [data-validation]': @validateField
#    'blur [data-validation]':   @validateField

  closeModal: (event) ->
    event.preventDefault()
    $('.js-my-edit-modal').modal 'hide'

  processForm: (event) ->
    event.preventDefault()
    console.log 'save user'
    data =
      user:
        siteUrl: @ui.siteUrl.val()
        userPhone: @ui.userPhone.val()
        userSkill: @ui.userSkill.val()
        userName: @ui.userName.val()
        userAbout: @ui.userAbout.val()
        password: @ui.password.val()
        userEmail: @ui.userEmail.val()
        userGender: @ui.userGender.val()
        userBirthday: @birthdayCompound @ui.userBirthday.val()

    console.log @options.postUserUrl

    @model.fetch(
      data: data
      method: 'POST'
      url: @options.postUserUrl
      success: ->
        $('.js-my-edit-modal').modal 'hide'
        App.userShow()
      error: @errorsHandler
    )

  errorsHandler: (model, xhr, options) =>
    fields = xhr.responseJSON.errors.children

    console.log 'error on updating model', fields
    for fieldName, obj of fields
      if obj.errors? and obj.errors[0]
        @invalid fieldName, obj.errors[0]

  validationState: (e) =>
    validation = $(e.target).attr('name')
    @valid validation

  labelState: (e) =>
    $(e.target).parent('.form-group').toggleClass 'active'
    $(e.target).parent('.form-group').removeClass 'invalid'

  valid: (fieldName, msg) =>
    $("[name=#{fieldName}]")
    .parent('.form-group')
    .removeClass('invalid')
    .addClass('valid')

  invalid: (fieldName, error) =>
    $("[name=#{fieldName}]")
    .parent('.form-group')
    .removeClass('valid')
    .addClass('invalid')

  birthdayCompound: (bd) ->
    bd = moment(bd);

    return {
      year: bd.year(),
      month: bd.month() + 1,
      day: bd.date()
    }

module.exports = Layout