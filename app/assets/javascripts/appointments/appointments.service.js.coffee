angular.module('calendarApp')

.service 'Appointments', ['restmod', (restmod)->
  restmod.model('/appointments.json')
]
  	# // var date = new Date();
    # // var d = date.getDate();
    # // var m = date.getMonth();
    # // var y = date.getFullYear();
    # // var startTime = 9;
    # // var endTime = 17;
  	# // var appointments;
    # //
  	# // function fillInOpenings() {
    # //   // for(var i =1; i < 6; i++) {
    # //   //   var clonedDate = angular.copy(currentWeek);
    # //   //   clonedDate.setDate(clonedDate.getDate() - (weekDay - i));
    # //   //   var sameDayAppointments = _.where(appointments.response, function(block) {
    # //   //     return block.start.getDate() === clonedDate.getDate();
    # //   //   });
    # //
    # //   //   clonedDate.setHours(startTime);
    # //   //   clonedDate.setMinutes(0);
    # //   //   if(sameDayAppointments.length === 0) {
    # //   //     appointments.list.push({start: new Date(clonedDate.setHours(startTime)), end: new Date(clonedDate.setHours(endTime)), title: "Open",allDay: false, color: 'blue'});
    # //   //   }
    # //   //   else {
    # //   //     angular.forEach(sameDayAppointments, function(appointment) {
    # //   //       var gap = {start: new Date(clonedDate.setHours(startTime)), title: "Open",allDay: false, color: 'blue'};
    # //   //       while(appointment.start > clonedDate) {
    # //   //         clonedDate.setMinutes ( clonedDate.getMinutes() + 10 );
    # //   //       }
    # //   //       gap.end = angular.copy(clonedDate);
    # //   //       appointments.list.push(gap);
    # //   //       clonedDate = angular.copy(appointment.end);
    # //   //     });
    # //   //     appointments.list.push({start: angular.copy(clonedDate), end: new Date(clonedDate.setHours(endTime)), title: "Open",allDay: false, color: 'blue'});
    # //   //   }
    # //   // }
    # //   angular.forEach(appointments.blocks, function(block) {
    # //     var sameDayAppointments = _.where(appointments.response, function(appointment) {
    # //       return appointment.start.getDate() === block.start.getDate();
    # //     });
    # //     angular.forEach(sameDayAppointments, function(appointment) {
    # //       var gap = {start: angular.copy(block.start), title: "Open",allDay: false, color: 'blue'};
    # //       while(appointment.start > block.start) {
    # //         block.start.setMinutes ( block.start.getMinutes() + 10 );
    # //       }
    # //       gap.end = angular.copy(block.start);
    # //       appointments.list.push(gap);
    # //       block.start = angular.copy(appointment.end);
    # //     });
    # //     appointments.list.push({start: block.start, end: block.end, title: "Open",allDay: false, color: 'blue'});
    # //   });
    # //   var z = 15;
  	# // };
    # //
  	# // appointments = {
  	# // 	create: function() {
  	# //
  	# // 	},
  	# // 	update: function() {
    # //
  	# // 	},
  	# // 	delete: function() {
    # //
  	# // 	},
  	# // 	query: function() {
    # //     // var currentWeek = appointments.calendar.fullCalendar( 'getDate' );
    # //     // var weekDay = currentWeek.setDate(clonedDate.getDate());
  	# // 		appointments.response = [{title: 'Occupied',start: new Date(y, m, 30, 10, 30),end: new Date(y, m, 30, 13, 30),allDay: false, color: 'red'},{title: 'Occupied',start: new Date(y, m, 30, 14, 0),end: new Date(y, m, 30, 15, 30),allDay: false, color: 'red'}];
  	# // 		angular.forEach(appointments.response, function(element) {
  	# // 			appointments.list.push(element);
  	# // 		});
    # //     appointments.blocks = [{start: new Date(y,8,29,9,0), end: new Date(y,8,29,17,0)},{start: new Date(y,8,30,8,0), end: new Date(y,8,30,16,0)},{start: new Date(y,9,1,9,0), end: new Date(y,9,1,17,0)},{start: new Date(y,9,2,7,0), end: new Date(y,9,2,15,0)},{start: new Date(y,9,3,9,0), end: new Date(y,9,3,17,0)}];
		# //     fillInOpenings();
  	# // 	},
  	# // 	list: [],
  	# // 	week: {
  	# // 		start: new Date(),
  	# // 		end: new Date()
  	# // 	},
  	# // 	calendar: {}
  	# // };
    # //
  	# // return appointments;
  # });
