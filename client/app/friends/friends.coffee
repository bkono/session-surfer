meanApp
  .config ($stateProvider) ->
    $stateProvider
      .state 'tab.friends', 
        url: '/friends',
        views:
          'tab-friends':
            templateUrl: 'friends/tab-friends.tpl.html',
            controller: 'FriendsCtrl'

      .state 'tab.friend-detail',
        url: '/friend/:friendId',
        views:
          'tab-friends':
            templateUrl: 'friends/friend-detail.tpl.html',
            controller: 'FriendDetailCtrl'

  .controller 'FriendsCtrl', ($scope, Friends) ->
    $scope.friends = Friends.all()

  .controller 'FriendDetailCtrl', ($scope, $stateParams, Friends) ->
    $scope.friend = Friends.get($stateParams.friendId)
