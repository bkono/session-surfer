'use strict'

meanApp = angular.module 'meanApp', ['ionic', 'timer', 'uiGmapgoogle-maps', 'ngResource', 'ngCordova']

meanApp.run ($ionicPlatform) ->
  $ionicPlatform.ready ->
    window.cordova?.plugins.Keyboard?.hideKeyboardAccessoryBar(true)
    window.StatusBar?.styleDefault()
