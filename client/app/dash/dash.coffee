meanApp
  .config ($stateProvider) ->
    $stateProvider
      .state 'tab.dash',
        url: '/dash',
        views:
          'tab-dash':
            templateUrl: 'dash/tab-dash.tpl.html',
            controller: 'DashCtrl'

  .controller 'DashCtrl', ($scope) -> return
