angular.module('starter.controllers', [])

  .controller 'DashCtrl', ($scope) -> return

  .controller 'ChatsCtrl', ($scope, Chats) ->
    $scope.chats = Chats.all()
    $scope.remove = (chat) ->
      Chats.remote(chat)

  .controller 'ChatDetailCtrl', ($scope, $stateParams, Chats) ->
    $scope.chat = Chats.get($stateParams.chatId)

  .controller 'FriendsCtrl', ($scope, Friends) ->
    $scope.friends = Friends.all()

  .controller 'FriendDetailCtrl', ($scope, $stateParams, Friends) ->
    $scope.friend = Friends.get($stateParams.friendId)

  .controller 'AccountCtrl', ($scope) ->
    $scope.settings =
      enableFriends: true
