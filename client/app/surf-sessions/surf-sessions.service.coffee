meanApp.service 'SurfSessions', ($rootScope, $q, $http, Config, $cordovaGeolocation) ->
  activeSession = {}

  SurfSessions = {
    hasActiveSession: ->
      if activeSession.startTime
        return true
      else
        return false

    currentSession: ->
      q = $q.defer()
      if activeSession.startTime
        q.resolve(activeSession)
      else
        q.resolve(this.start())
      return q.promise

    start: ->
      q = $q.defer()
      startTime = new Date()
      activeSession = { startTime: startTime }
      q.resolve(activeSession)
      @currentLocation()
        .then (location) ->
          activeSession.location = location
          $http.post "#{Config.serverUrl}/sessions", activeSession
            .success (session) ->
              activeSession = session
            .error (err) ->
      return q.promise

    stop: (ratings = {}) ->
      activeSession.ratings = ratings
      q = $q.defer()
      q.resolve(activeSession)
      $http.put "#{Config.serverUrl}/sessions", activeSession
      return q.promise

    currentLocation: (session) ->
      q = $q.defer()
      posOptions = {timeout: 10000, enableHighAccuracy: false}
      $cordovaGeolocation.getCurrentPosition(posOptions)
        .then (position) ->
          location = {}
          location.type = 'Point'
          location.coordinates = [
            position.coords.longitude,
            position.coords.latitude
          ]
          q.resolve(location)
      return q.promise
  }

  return SurfSessions

