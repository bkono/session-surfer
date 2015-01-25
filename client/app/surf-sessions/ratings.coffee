# meanApp.config ($stateProvider) ->
#   $stateProvider
#     .state 'tab.surfSessionRatings',
#       url: '/surf-session-ratings'
#       views:
#         'surf-session-ratings':
#           templateUrl: 'surf-session-ratings/surf-session-ratings.tpl.html'
#           controller:  'SurfSessionRatingsCtrl'
#
# meanApp.controller 'SurfSessionRatingsCtrl', ($scope) ->
#   $scope.waveRating = 3
#   $scope.windRating = 3
#   $scope.crowdRating = 3
#   $scope.overallRating = 3
#   $scope.max = 5
#   $scope.isReadonly = false
#   $scope.rateFunction = (rating) ->
#
#   $scope.hoveringOver = (value) ->
#     $scope.overStar = value
#     $scope.percent = 100 * (value / $scope.max)
#
#
