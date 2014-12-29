meanApp.config ($stateProvider, uiGmapGoogleMapApiProvider) ->
  $stateProvider
    .state 'bouys',
      url:         '/bouys'
      templateUrl: 'bouys/bouys.tpl.html'
      controller:  'BouysCtrl'
  uiGmapGoogleMapApiProvider.configure({
    key: 'AIzaSyB9ZYr4T-F_t2_PiXSjDMRjTYksI8JetxE',
    v: '3.17',
    libraries: 'weather,geometry,visualization'})

meanApp.controller 'BouysCtrl', ($scope, Bouy, Global, uiGmapGoogleMapApi) ->
  $scope.global = Global
  $scope.bouys = Bouy.query()
  console.log $scope.bouys
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
