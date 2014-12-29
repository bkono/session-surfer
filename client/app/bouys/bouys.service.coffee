meanApp.factory 'Bouy', ($resource) ->
  return $resource('bouys/', {}, {
    query: {method: 'GET', params:{}, isArray: true}
  })
  
meanApp.service 'Bouys', ($rootScope, $q, $http) ->

  Bouys = {}

  return Bouys
