// Action Cable provides the framework to deal with WebSockets in Rails.
// You can generate new channels where WebSocket features live using the `rails generate channel` command.
//
//= require action_cable
//= require_self
//= require_tree ./channels

(function() {
  this.App || (this.App = {});

  App.cable = ActionCable.createConsumer();

}).call(this);


// document.querySelector("[data-item-id='<%= item.id %>']")


// function up(max) {
//     document.querySelector(itemId).value = parseInt(document.querySelector(itemId).value) + 1;
//     if (document.querySelector(itemId).value >= parseInt(max)) {
//         document.querySelector(itemId).value = max;
//     }
// }

// function down(min) {
//     document.querySelector(itemId).value = parseInt(document.querySelector(itemId).value) - 1;
//     if (document.querySelector(itemId).value <= parseInt(min)) {
//         document.querySelector(itemId).value = min;
//     }
// }
