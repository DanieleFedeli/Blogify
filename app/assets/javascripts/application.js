//= require jquery
//= require rails-ujs
//= require bootstrap
//= require activestorage
//= require turbolinks
//= require_tree .
//= require cloudinary

function getRightUrl(){
  var protocol = window.location.protocol;
  var hostname = window.location.hostname;
  var port     = window.location.port;
  return protocol+'//'+hostname+':'+port;
}