//= require jquery
//= require prism
//= require_self

// This is needed for prism to work with turbolinks
// reference: https://stackoverflow.com/questions/21278357/prism-js-not-working-with-rails-4-turbolinks
console.log('0');
//document.addEventListener("page:load", function() {
$(document).on('ready page:load', function() {
  console.log('1');
  Prism.highlightAll();
  console.log('2');
});
