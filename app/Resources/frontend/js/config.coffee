he = require 'he'

userData = JSON.parse he.decode initData.user

module.exports =
  userData: userData
  appContainer: '#app-hook'
  appTemplate: '#user-show'
  userEditContainer: '#app-user-edit'
  userEditTemplate: '#user-edit'
  postUserUrl: '/process-form'

  