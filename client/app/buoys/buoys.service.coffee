meanApp.factory 'Buoy', ($resource) ->
  return $resource('bouys/', {}, {
    query: {method: 'GET', params:{}, isArray: true}
  })
  
meanApp.service 'Buoys', ($rootScope, $q, $http) ->

  Buoys = {}

  return Buoys
