meanApp.service 'SurfSessions', ($rootScope, $q, $http, Config) ->
  activeSession = {}

  SurfSessions = {
    hasActiveSession: ->
      if activeSession.startTime
        return true
      else
        return false

    currentSession: ->
      q = $q.defer()
      console.log "current session called, active session is: "
      console.log activeSession
      if activeSession.startTime
        console.log "resolving with an activesession"
        q.resolve(activeSession)
      else
        console.log "resolving with a start call"
        q.resolve(this.start())
      return q.promise

    start: ->
      console.log "in start, active session is: #{activeSession}"
      console.log "Got a config serverUrl of #{Config.serverUrl}"
      q = $q.defer()
      startTime = new Date()
      activeSession = { startTime: startTime }
      console.log "set activeSession to #{activeSession}"
      q.resolve(activeSession)
      $http.post "#{Config.serverUrl}/sessions", activeSession
        .success (session) ->
          console.log session
          activeSession = session
        .error (err) ->
          console.log "error: [ #{err} ]"
      return q.promise

    stop: (ratings = {}) ->
      activeSession.ratings = ratings
      console.log "stopping session:"
      console.log activeSession
      q = $q.defer()
      q.resolve(activeSession)
      $http.put "#{Config.serverUrl}/sessions", activeSession
        .success (session) ->
          console.log session
        .error (err) ->
          console.log "error: [ #{err} ]"
      return q.promise

  }

  return SurfSessions

