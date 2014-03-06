@ClockJock = angular.module('ClockJock', [])
#@ refers to window if not inside object

ClockJock.controller 'ClockCtrl', ($scope) ->
  #$scope variable is what is passed to the angular template

  $scope.ints = [0, 0, 0, 0] #hours, minutes, seconds, milliseconds
  $scope.running = false

  parseTime = =>
    time = $scope.ints.map(String)
    console.log time
    time = time.map((t)->"0"+t if t.length is 1)
    (time[3] = "0"+time[3]) if time[3].length is 2
    $scope.time = time

  parseTime.call()

  $scope.startStop = ->
    if $scope.running is false
      if ($scope.ints.reduce((a, b)-> a + b)) is 0 #implicitly assume first val is 0
        base_time = Date.now()
        $scope.interval = setInterval((->updateTimer(base_time)), 1) #set start time for duration
        $scope.running = true
      else
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
    $scope.ints = [hours(d), minutes(d), seconds(d), milliseconds(d)]
    parseTime()
    $scope.$apply()

