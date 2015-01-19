'use strict'

meanApp = angular.module 'meanApp', ['ionic']

meanApp.run ($ionicPlatform) ->
  $ionicPlatform.ready ->
    window.cordova?.plugins.Keyboard?.hideKeyboardAccessoryBar(true)
    window.StatusBar?.styleDefault()
