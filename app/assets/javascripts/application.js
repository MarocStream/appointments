// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery.turbolinks
//= require jquery_ujs
//= require jquery-ui
//= require turbolinks
//= require phoenix
//= require angular
//= require angular-rails-templates
//= require_tree ../templates
//= require angular-cookies
//= require angular-resource
//= require angular-sanitize
//= require angular-route
//= require angular-restmod/dist/angular-restmod-bundle
//= require angular-restmod/dist/styles/ams
//= require angular-restmod/dist/plugins/dirty
//= require angular-ui-bootstrap-bower/ui-bootstrap.js
//= require angular-ui-bootstrap-bower/ui-bootstrap-tpls
//= require bootstrap
//= require lodash
//= require moment
//= require fullcalendar
//= require calendar
//= require main/main
//= require main/main.controller
//= require users.service
//= require appointments/appointment_sync.service
//= require appointments/appointments.service
//= require appointments/appointments.controller
//= require appointments/types.service
//= require appointments/editor/modal.controller
//= require bootstrap-datetimepicker
//= require bootstrap-tags
//= require user_profile
//= require announcements


// Stupid opt in bullshit
$(function () {
  $("body").tooltip({ selector: '[data-toggle="tooltip"]' });
})

function add_fields(link, association, content, wrap) {
  var new_id = new Date().getTime();
  var regexp = new RegExp("new_" + association, "g");
  new_content = content.replace(regexp, new_id)
  if(wrap != null){
    new_content = $(wrap).append(new_content);
  }
  $(link).after(new_content);
}

function destroy_fields(link) {
  $(link).hide().find('[id$=destroy]').val('true')
}
