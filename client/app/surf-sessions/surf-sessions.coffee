meanApp.config ($stateProvider) ->
  $stateProvider
    .state 'tab.surfSessions',
      url:         '/surf-sessions'
      views:
        'tab-surf-sessions':
          templateUrl: 'surf-sessions/surf-sessions.tpl.html'
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


