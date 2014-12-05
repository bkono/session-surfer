meanApp.service 'Sessions', ($rootScope, $q, $http) ->
  activeSession = {}

  Sessions = {
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
      q = $q.defer()
      startTime = new Date()
      activeSession = { startTime: startTime }
      console.log "set activeSession to #{activeSession}"
      q.resolve(activeSession)

      return q.promise
  }

  return Sessions

