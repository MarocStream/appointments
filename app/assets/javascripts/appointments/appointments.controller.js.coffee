angular.module('calendarApp')

.controller 'AppointmentsCtrl', ['$modal', '$scope', 'Appointments', 'AppointmentTypes', ($modal, $scope, Appointments, AppointmentTypes)->

  $scope.appointments = []

  reformAppointment = (appt)->
    type = _.findWhere $scope.types, id: appt.appointmentTypeId
    start = new Date(appt.start)
    end = new Date(appt.start)
    end.setMinutes(start.getMinutes() + type.duration)
    {
      title: type.name
      color: type.colorClass
      textColor: type.textColor
      start: start
      end: end
      allDay: false
    }

  AppointmentTypes.$search().$then (types)->
    $scope.types = types

    Appointments.$search().$then (appointments)->
      apps = []
      _.each appointments, (a)->
        apps.push reformAppointment(a)

      $scope.appointments.push(apps)

  $scope.addAppointment = ()->
    modalInstance = $modal.open
      templateUrl: 'appointments/editor/modal.html'
      controller: 'AppointmentModalController'

    modalInstance.result.then (appt)->
      appt.$save().$then (a)->
        $scope.appointments[0].push reformAppointment(a)
        $scope.$apply()
    , ()->

  $scope.uiConfig =
    calendar:
      height: 1000
      editable: true
      header:
        left: 'month agendaWeek agendaDay'
        center: 'title'
        right: 'today prev,next'
      hiddenDays: []
      # eventClick: $scope.alertOnEventClick
      # eventDrop: $scope.alertOnDrop
      # eventResize: $scope.alertOnResize
      minTime: "05:00:00"
      maxTime: "22:00:00"

]
