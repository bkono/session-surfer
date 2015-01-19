meanApp
  .config ($stateProvider) ->
    $stateProvider
      .state 'tab.chats',
        url: '/chats',
        views:
          'tab-chats':
            templateUrl: 'chat/tab-chats.tpl.html',
            controller: 'ChatsCtrl'

      .state 'tab.chat-detail',
        url: '/chats/:chatId',
        views:
          'tab-chats':
            templateUrl: 'chat/chat-detail.tpl.html',
            controller: 'ChatDetailCtrl'

  .controller 'ChatsCtrl', ($scope, Chats) ->
    $scope.chats = Chats.all()
    $scope.remove = (chat) ->
      Chats.remote(chat)

  .controller 'ChatDetailCtrl', ($scope, $stateParams, Chats) ->
    $scope.chat = Chats.get($stateParams.chatId)
