meanApp.service 'Config', () ->
  Config = {
    serverUrl: '/* @echo SERVER_URL */' || 'http://localhost:3000'
  }

  return Config
