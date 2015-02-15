meanApp.directive "starRating", ->
  return {
    restrict : "A"
    template : """
      <ul class='rating'>
        <li ng-repeat='star in stars' ng-class='star' ng-click='toggle($index)'>
          <i class='icon ion-star'></i>
        </li>
      </ul>
      """
    scope :
      ratingValue : "="
      max : "="
      onRatingSelected : "&"

    link : (scope, elem, attrs) ->
      updateStars = () ->
        scope.stars = []
        for star in [0 .. scope.max - 1]
          scope.stars.push(filled : star < scope.ratingValue)

      scope.toggle = (index) ->
        scope.ratingValue = index + 1
        scope.onRatingSelected(rating : index + 1)

      scope.$watch "ratingValue", (oldVal, newVal) ->
        updateStars() if(newVal)
  }
