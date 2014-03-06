@ClockJock = angular.module('ClockJock', [])
#@ refers to window if not inside object

ClockJock.controller 'ClockCtrl', ($scope) ->
  #$scope variable is what is passed to the angular template

  $scope.ints = [0, 0, 0, 0] #hours, minutes, seconds, milliseconds
  $scope.running = false

  $scope.startStop = ->
    sum = $scope.ints.reduce((a, b)-> a + b) #implicitly assume first val is 0
    if $scope.running is false
      if sum is 0
        $scope.interval = setInterval((->updateTimer(Date.now())), 1) #set start time for duration
        $scope.running = true
      else if sum > 0
        $scope.ints = [0, 0, 0, 0]
    else
      clearInterval($scope.interval)
      $scope.running = false

  hours = (t)->
    Math.floor(t/1000/60/60)

  minutes = (t)->
    Math.floor(t/1000/60) % 60

  seconds = (t)->
    Math.floor(t/1000) % 60

  milliseconds = (t)->
    t % 1000

  updateTimer = (t)->
    d = Date.now() - t #time difference every ms from start time
    $scope.$apply =>
      $scope.ints = [hours(d), minutes(d), seconds(d), milliseconds(d)]

  $scope.time = $scope.ints.map(String).map((t)->"0"+t if t.length is 1).map((t,i)->if (i is 2 and t.length is 2) then "0"+t else t)
