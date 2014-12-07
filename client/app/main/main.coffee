meanApp.config ($stateProvider) ->
  $stateProvider
    .state 'root',
      url: ''
      templateUrl: 'main/main.tpl.html'
      controller:  'MainCtrl'

    .state 'main',
      url: '^/?'
      templateUrl: 'main/main.tpl.html'
      controller:  'MainCtrl'

meanApp.controller 'MainCtrl', ($scope, Global) ->
  $scope.global = Global
