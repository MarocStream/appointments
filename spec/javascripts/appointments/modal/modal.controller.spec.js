'use strict';

describe('Controller: AppointmentmodalCtrl', function () {

  // load the controller's module
  beforeEach(module('calendarApp'));

  var AppointmentmodalCtrl, scope;

  // Initialize the controller and a mock scope
  beforeEach(inject(function ($controller, $rootScope) {
    scope = $rootScope.$new();
    AppointmentmodalCtrl = $controller('AppointmentmodalCtrl', {
      $scope: scope
    });
  }));

  it('should ...', function () {
    expect(1).toEqual(1);
  });
});
