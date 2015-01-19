'use strict'

meanApp = angular.module 'meanApp', ['ionic', 'timer']

meanApp.run ($ionicPlatform) ->
  $ionicPlatform.ready ->
    window.cordova?.plugins.Keyboard?.hideKeyboardAccessoryBar(true)
    window.StatusBar?.styleDefault()
