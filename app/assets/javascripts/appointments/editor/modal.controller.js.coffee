angular.module('calendarApp')

.controller 'AppointmentModalController',
['$scope', 'appointment', 'appointmentErrors', '$modalInstance', 'Appointments', 'Users', '$rootScope', '$timeout', '$filter'
( $scope,   appointment,   appointmentErrors,   $modalInstance,  Appointments,   Users,   $rootScope,   $timeout,   $filter)->

  $timeout ->
    $('.input-group.date input').datetimepicker({format: 'MM/DD/YYYY'})
  , 100

  $scope.setDate = (obj, name)->
    $timeout ->
      if $scope[name] || $scope[obj][name]
        if $scope[name]
          date = moment($scope[name], 'MM/DD/YYYY')
        else
          date = moment($scope[obj][name])
      else
        date = moment()

      if $scope[obj][name]
        start = moment($scope[obj][name])
        date.hours(start.hours())
        date.minutes(start.minutes())
      date.subtract(date.minutes() % 10, 'minutes')
      date.seconds(0)
      $scope[obj][name] = new Date(date.valueOf())
      $scope[name] = $filter('date')($scope[obj][name], 'MM/dd/yyyy')
      $scope.$apply()


  $scope.allDayClosing = ->
    if $scope.closing.all_day
      $scope.closing.duration = 24
      $scope.closing.date = moment($scope.closing.date).startOf('day')

  $scope.ok = ()->
    time = moment($scope.appointment?.start || $scope.closing.date)
    console.log time
    date = moment($scope.start || $scope.date)
    console.log date
    date.hours(time.hours())
    date.minutes(time.minutes())
    date = new Date(date.utc().valueOf())
    if $scope.appointment
      $scope.appointment.start = date
    else
      $scope.closing.date = date
    console.log "Closing appointment/closing with start date of #{$scope.appointment?.start || $scope.closing.date}"
    $modalInstance.close($scope.appointment || $scope.closing)

  $scope.cancel = ()->
    $modalInstance.dismiss()

  $scope.editable = () ->
    date = $scope.appointment?.start || $scope.closing?.date
    moment(date).isAfter(moment())

  $scope.remove = ()->
    $scope.appointment?.$destroy()
    $scope.closing?.$destroy()
    $modalInstance.dismiss()

  $scope.type_for = (id)->
    _.findWhere $scope.appointment_types, id: id

  $scope.add_member = ->
    $scope.appointment.groupMembersAttributes.push({})
    $timeout ->
      $('.input-group.date input').datetimepicker({format: 'MM/DD/YYYY'})
    , 100

  $scope.appointmentErrors = appointmentErrors
  if appointment?.date
    $scope.closing = appointment
    $scope.allDay = $scope.closing.all_day
    $scope.setDate('closing', 'date')
  else
    $scope.appointment = appointment || Appointments.$build()
    $scope.setDate('appointment', 'start')
    $scope.appointment.appointmentTypeId ||= $scope.appointment_types[0].id
    $scope.appointment.groupMembersAttributes ||= []

    if $rootScope.user?.isPatient()
      $scope.appointment.userId ||= $rootScope.user?.id

]
