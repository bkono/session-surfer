meanApp.config ($routeProvider) ->
  $routeProvider
    .when '/surf-sessions',
      templateUrl: 'surf-sessions/surf-sessions.tpl.html'
      controller: 'SurfSessionsCtrl'
    .when '/surf-sessions/new',
      templateUrl: 'surf-sessions/surf-sessions.new.tpl.html'
      controller: 'NewSurfSessionCtrl'

meanApp.controller 'NewSurfSessionCtrl', ($scope, SurfSessions) ->
  $scope.model = {}
  SurfSessions.currentSession().then (session) ->
    $scope.model = session
    $scope.elapsed = elapsed = (new Date().getTime() - session.startTime.getTime())
    $scope.$broadcast('timer-set-start', session.startTime.getTime())
    $scope.$broadcast("timer-start")

meanApp.controller 'SurfSessionsCtrl', ($scope, SurfSessions, Global) ->
  $scope.global = Global


