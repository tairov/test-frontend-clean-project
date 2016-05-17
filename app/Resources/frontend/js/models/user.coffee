Backbone = require 'backbone'

class User extends Backbone.Model
  urlRoot: '/users'
  idAttribute: 'idToken'
  validation:
    userName:
      required: true
    userEmail:
      required: true
    password:
      required: true
    userGender:
      required: true
      oneOf: ['male', 'female']
  defaults:
    id: null
    idToken: null
    siteUrl: null
    userPhone: null
    userSkill: null
    userName: null
    userAbout: null
    password: null
    userEmail: null
    userGender: 'male'
    userBirthday: null

module.exports = User