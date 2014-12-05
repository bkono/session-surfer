meanApp.config ($routeProvider) ->
  $routeProvider
    .when '/sessions',
      templateUrl: 'sessions/sessions.tpl.html'
      controller: 'SessionsCtrl'
    .when '/sessions/new',
      templateUrl: 'sessions/sessions.new.tpl.html'
      controller: 'NewSessionCtrl'

meanApp.controller 'NewSessionCtrl', ($scope, Sessions) ->
  $scope.model = {}
  Sessions.currentSession().then (session) ->
    console.log session
    $scope.model = session
    $scope.elapsed = elapsed = (new Date().getTime() - session.startTime.getTime())
    console.log "evaluated elapsed as: #{elapsed}"
    $scope.$broadcast('timer-set-start', session.startTime.getTime())
    $scope.$broadcast("timer-start")
    Sessions.currentSession()

meanApp.controller 'SessionsCtrl', ($scope, Sessions, Global) ->

  $scope.global = Global


