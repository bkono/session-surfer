meanApp.config ($stateProvider, uiGmapGoogleMapApiProvider) ->
  $stateProvider
    .state 'tab.buoys',
      url: '/buoys'
      views:
        'tab-buoys':
          templateUrl: 'buoys/buoys.tpl.html'
          controller:  'BuoysCtrl'

  uiGmapGoogleMapApiProvider.configure({
    key: 'AIzaSyB9ZYr4T-F_t2_PiXSjDMRjTYksI8JetxE',
    v: '3.17',
    libraries: 'weather,geometry,visualization'})

meanApp.controller 'BuoysCtrl', ($scope, Buoy, uiGmapGoogleMapApi) ->
  $scope.buoys = Buoy.query()
  $scope.map =
    center:
      latitude: 34, longitude: -118
    zoom: 8
    rectangle: {}
  uiGmapGoogleMapApi.then (maps) ->
    $scope.googleVersion = maps.version
    maps.visualRefresh = true
    $scope.map.rectangle.bounds = new maps.LatLngBounds(
      new maps.LatLng(25,-120),
      new maps.LatLng(49,-78)
    )
