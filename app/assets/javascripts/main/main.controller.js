'use strict';

angular.module('calendarApp')
.controller('MainCtrl', function($scope, $timeout, Appointments, $modal) {
    /* alert on eventClick */
    $scope.alertOnEventClick = function( event, allDay, jsEvent, view ){
      $modal.open({
          resolve: {
            event: function () {
              return event;
            }
          },
          templateUrl: 'modal/appointment.html',
          controller: 'AppointmentmodalCtrl'
        });
      if($scope.currentEvent) {
        $scope.currentEvent.className = "";
      }
      if($scope.currentEvent === event) {
        $scope.currentEvent = undefined;
        }
      else {
        $scope.currentEvent = event;
        event.className = "appointment-hover";
      }
    };
    /* alert on Drop */
    $scope.alertOnDrop = function(event, dayDelta, minuteDelta, allDay, revertFunc, jsEvent, ui, view){
       $scope.alertMessage = ('Event Droped to make dayDelta ' + dayDelta);
    };
    /* alert on Resize */
    $scope.alertOnResize = function(event, dayDelta, minuteDelta, revertFunc, jsEvent, ui, view ){
       $scope.alertMessage = ('Event Resized to make dayDelta ' + minuteDelta);
    };

    /* config object */
    $scope.uiConfig = {
      calendar:{
        height: 1000,
        editable: false,
        header:{
          left: 'month agendaWeek agendaDay',
          center: 'title',
          right: 'today prev,next'
        },
        hiddenDays: [0,6],
        eventClick: $scope.alertOnEventClick,
        eventDrop: $scope.alertOnDrop,
        eventResize: $scope.alertOnResize,
        minTime: "05:00:00",
        maxTime: "22:00:00",
      }
    };

    $timeout(function() {
      Appointments.calendar = $scope.appointmentCalendar;
      $scope.appointmentCalendar.fullCalendar('changeView', 'agendaWeek');
      $scope.calendarLoaded = true;
      Appointments.query();
    });
    $scope.events = Appointments.list;
    $scope.eventSources =[$scope.events];
    // $scope.changeLang = function() {
    //   if($scope.changeTo === 'Hungarian'){
    //     $scope.uiConfig.calendar.dayNames = ["Vasárnap", "Hétfő", "Kedd", "Szerda", "Csütörtök", "Péntek", "Szombat"];
    //     $scope.uiConfig.calendar.dayNamesShort = ["Vas", "Hét", "Kedd", "Sze", "Csüt", "Pén", "Szo"];
    //     $scope.changeTo= 'English';
    //   } else {
    //     $scope.uiConfig.calendar.dayNames = ["Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday"];
    //     $scope.uiConfig.calendar.dayNamesShort = ["Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"];
    //     $scope.changeTo = 'Hungarian';
    //   }
    // };
    /* event sources array*/
    // $scope.eventSources = Appointments.list;
    // $scope.awesomeThings = [];

    // $http.get('/api/things').success(function(awesomeThings) {
    //   $scope.awesomeThings = awesomeThings;
    //   socket.syncUpdates('thing', $scope.awesomeThings);
    // });

    // $scope.addThing = function() {
    //   if($scope.newThing === '') {
    //     return;
    //   }
    //   $http.post('/api/things', { name: $scope.newThing });
    //   $scope.newThing = '';
    // };

    // $scope.deleteThing = function(thing) {
    //   $http.delete('/api/things/' + thing._id);
    // };

    // $scope.$on('$destroy', function () {
    //   socket.unsyncUpdates('thing');
    // });
  });
