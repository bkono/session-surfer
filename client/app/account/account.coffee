meanApp
  .config ($stateProvider) ->
    $stateProvider
      .state 'tab.account',
        url: '/account',
        views:
          'tab-account':
            templateUrl: 'account/tab-account.tpl.html',
            controller: 'AccountCtrl'

  .controller 'AccountCtrl', ($scope) ->
    $scope.settings =
      enableFriends: true
