'use strict';

angular.module('calendarApp')
.controller 'MainCtrl', ['$scope', '$timeout', '$modal', ($scope, $timeout, $modal)->

  $scope.alertOnEventClick = ( event, allDay, jsEvent, view )->
    $modal.open
      resolve:
        event: ()->
          event
      templateUrl: 'modal/appointment.html'
      controller: 'AppointmentmodalCtrl'
    if $scope.currentEvent
      $scope.currentEvent.className = ""

    if $scope.currentEvent == event
      $scope.currentEvent = undefined
    else
      $scope.currentEvent = event
      event.className = "appointment-hover"

  $scope.alertOnDrop = (event, dayDelta, minuteDelta, allDay, revertFunc, jsEvent, ui, view)->
     $scope.alertMessage = "Event Droped to make dayDelta #{dayDelta}"

  $scope.alertOnResize = (event, dayDelta, minuteDelta, revertFunc, jsEvent, ui, view )->
     $scope.alertMessage = "Event Resized to make dayDelta #{minuteData}"

  $timeout ()->
    # Appointments.calendar = $scope.appointmentCalendar
    # $scope.appointmentCalendar.fullCalendar('changeView', 'agendaWeek')
    $scope.calendarLoaded = true
    []
    # Appointments.query()

  $scope.events = []#Appointments.list
  $scope.eventSources =[$scope.events]
  # // $scope.changeLang = function() {
  # //   if($scope.changeTo === 'Hungarian'){
  # //     $scope.uiConfig.calendar.dayNames = ["Vasárnap", "Hétfő", "Kedd", "Szerda", "Csütörtök", "Péntek", "Szombat"];
  # //     $scope.uiConfig.calendar.dayNamesShort = ["Vas", "Hét", "Kedd", "Sze", "Csüt", "Pén", "Szo"];
  # //     $scope.changeTo= 'English';
  # //   } else {
  # //     $scope.uiConfig.calendar.dayNames = ["Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday"];
  # //     $scope.uiConfig.calendar.dayNamesShort = ["Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"];
  # //     $scope.changeTo = 'Hungarian';
  # //   }
  # // };
  # /* event sources array*/
  # // $scope.eventSources = Appointments.list;
  # // $scope.awesomeThings = [];
  #
  # // $http.get('/api/things').success(function(awesomeThings) {
  # //   $scope.awesomeThings = awesomeThings;
  # //   socket.syncUpdates('thing', $scope.awesomeThings);
  # // });
  #
  # // $scope.addThing = function() {
  # //   if($scope.newThing === '') {
  # //     return;
  # //   }
  # //   $http.post('/api/things', { name: $scope.newThing });
  # //   $scope.newThing = '';
  # // };
  #
  # // $scope.deleteThing = function(thing) {
  # //   $http.delete('/api/things/' + thing._id);
  # // };
  #
  # // $scope.$on('$destroy', function () {
  # //   socket.unsyncUpdates('thing');
  # // });
]
