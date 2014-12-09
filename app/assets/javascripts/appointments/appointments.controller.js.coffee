angular.module('calendarApp')

.controller 'AppointmentsCtrl', ['$modal', '$scope', 'Appointments', 'AppointmentTypes', ($modal, $scope, Appointments, AppointmentTypes)->

  $scope.appointments = []

  AppointmentTypes.$search().$then (types)->
    $scope.types = types

    Appointments.$search().$then (appointments)->
      apps = []
      _.each appointments, (a)->
        type = _.findWhere types, id: a.appointmentTypeId
        start = new Date(a.start)
        end = new Date(a.start)
        end.setMinutes(start.getMinutes() + type.duration)
        apps.push
          title: type.name
          color: type.colorClass
          textColor: type.textColor
          start: start
          end: end
          allDay: false

      $scope.appointments.push(apps)

  $scope.addAppointment = ()->
    $modal.open
      templateUrl: 'appointments/editor/modal.html'
      controller: 'AppointmentModalController'

  $scope.uiConfig =
    calendar:
      height: 1000
      editable: true
      header:
        left: 'agendaWeek agendaDay'
        center: 'title'
        right: 'today prev,next'
      hiddenDays: []
      # eventClick: $scope.alertOnEventClick
      # eventDrop: $scope.alertOnDrop
      # eventResize: $scope.alertOnResize
      minTime: "05:00:00"
      maxTime: "22:00:00"

]
