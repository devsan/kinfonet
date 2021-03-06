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
//= require jquery_ujs
//= require bootstrap
//= require bootstrap-datepicker
//= require turbolinks
//= require app
//=# require_tree .
//= require_tree ./lib
//= require_tree ./controllers

//This can be set up right inside the application manifest file because code added here is executed <em>after</em> all other compiled code.

  App.ready = function() {
    var $body = $("body");
    var controller = $body.data("controller").replace(/\//g, "_") + 'Controller';
    var action = $body.data("action");

    var activeController = App[controller];

    if (activeController !== undefined) {
      if ($.isFunction(activeController.init)) {
        activeController.init();
      }

      if ($.isFunction(activeController[action])) {
        console.log("in edit action?", action)
        activeController[action]();
      }
    }
  };

$(function() { App.ready() });
$(document).on('page:load', App.ready);

