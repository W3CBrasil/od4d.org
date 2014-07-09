//= require turbolinks
//= require prism
//= require_self

// This is needed for prism to work with turbolinks
$(document).on('ready page:load', function() {
    Prism.highlightAll();
});
