angular.module('calendarApp')

.controller 'AppointmentsCtrl', ['$scope', 'Appointments', 'AppointmentTypes', ($scope, Appointments, AppointmentTypes)->
  $scope.types = AppointmentTypes.$search()

  $scope.appointments = Appointments.$search()

  $scope.uiConfig =
    calendar:
      height: 1000
      editable: false
      header:
        left: 'month agendaWeek agendaDay'
        center: 'title'
        right: 'today prev,next'
      hiddenDays: [0,6]
      eventClick: $scope.alertOnEventClick
      eventDrop: $scope.alertOnDrop
      eventResize: $scope.alertOnResize
      minTime: "05:00:00"
      maxTime: "22:00:00"

]
