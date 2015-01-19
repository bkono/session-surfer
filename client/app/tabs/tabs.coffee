meanApp.config ($stateProvider, $urlRouterProvider) ->
  $stateProvider
    .state 'tab',
      url: '/tab',
      abstract: true,
      templateUrl: 'tabs/tabs.tpl.html'

  $urlRouterProvider.otherwise('/tab/dash')
