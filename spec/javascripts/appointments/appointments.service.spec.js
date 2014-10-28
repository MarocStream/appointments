'use strict';

describe('Service: Appointments', function () {

  // load the service's module
  beforeEach(module('calendarApp'));

  // instantiate service
  var Appointments;
  beforeEach(inject(function (_Appointments_) {
    Appointments = _Appointments_;
  }));

  it('should do something', function () {
    expect(!!Appointments).toBe(true);
  });

});
