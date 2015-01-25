meanApp.config ($stateProvider) ->
  $stateProvider
    .state 'tab.surfSessions',
      abstract: true
      url: '/surf-sessions'
      views:
        'tab-surf-sessions':
          template: '<ion-nav-view></ion-nav-view>'

  $stateProvider
    .state 'tab.surfSessions.active',
      url: ''
      templateUrl: 'surf-sessions/surf-sessions.tpl.html'
      controller:  'SurfSessionsCtrl'

  $stateProvider
    .state 'tab.surfSessions.ratings',
      url: '/ratings'
      # views:
      #   'tab-surf-session-ratings':
      templateUrl: 'surf-sessions/ratings.tpl.html'
      controller:  'SurfSessionsCtrl'

meanApp.controller 'SurfSessionsCtrl', ($scope, SurfSessions) ->
  $scope.model = {}
  $scope.hasActiveSession = SurfSessions.hasActiveSession
  $scope.newSession = ->
    SurfSessions.start().then (session) ->
      $scope.model = session
      console.log "hours #{$scope.hours}"
      $scope.elapsed = elapsed = (new Date().getTime() - session.startTime.getTime())
      $scope.$broadcast('timer-set-start', session.startTime.getTime())
      $scope.$broadcast("timer-start")

  $scope.waveRating = 3
  $scope.windRating = 3
  $scope.crowdRating = 3
  $scope.overallRating = 3
  $scope.max = 5
  $scope.isReadonly = false
  $scope.rateFunction = (rating) ->

  $scope.hoveringOver = (value) ->
    $scope.overStar = value
    $scope.percent = 100 * (value / $scope.max)

