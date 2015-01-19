String.prototype.lpad = (paddChar, count) ->
  str = this
  str = (paddChar + str) while str.length < count
  str
