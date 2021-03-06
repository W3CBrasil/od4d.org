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
//= require jquery
//= require jquery_ujs
//= require_self
//= require modernizr
//= require jquery.slicknav
//= require jquery.sticky
//= require easyResponsiveTabs
//= require prism
//= require jquery.keyboard-focus
(function( $ ){
$(document).ready(function(){
  $('#menu').slicknav();

  $('#horizontalTab').easyResponsiveTabs({
      type: 'default', //Types: default, vertical, accordion           
      width: 'auto', //auto or any width like 600px
      fit: true,   // 100% fit in a container
      closed: 'accordion', // Start closed if in accordion view
      activate: function(event) { // Callback function if tab is switched
          var $tab = $(this);
          var $info = $('#tabInfo');
          var $name = $('span', $info);

          $name.text($tab.text());

          $info.show();
      }
  });

  $('#verticalTab').easyResponsiveTabs({
      type: 'vertical',
      width: 'auto',
      fit: true
  });

  //classe do background de cada opção para hover
  $('.curioso').mouseover(function() {
    $('#call-banner').addClass('bgCuriosoCallBanner');
    $('.pos-call-banner').addClass('bgCuriosoCallBanner');
  });
  $('.dev').mouseover(function() {
    $('#call-banner').addClass('bgDevCallBanner');
    $('.pos-call-banner').addClass('bgDevCallBanner');
  });
  $('.produtor').mouseover(function() {
    $('#call-banner').addClass('bgProdutorCallBanner');
    $('.pos-call-banner').addClass('bgProdutorCallBanner');
  });

  $('.curioso').mouseout(function() {
    $('#call-banner').removeClass('bgCuriosoCallBanner');
    $('.pos-call-banner').removeClass('bgCuriosoCallBanner');
  });
  $('.dev').mouseout(function() {
    $('#call-banner').removeClass('bgDevCallBanner');
    $('.pos-call-banner').removeClass('bgDevCallBanner');
  });
  $('.produtor').mouseout(function() {
    $('#call-banner').removeClass('bgProdutorCallBanner');
    $('.pos-call-banner').removeClass('bgProdutorCallBanner');
  });



  //play de vídeo ou slideshare de cada opção
  $('.curioso').click(function() {
    $('#call-banner').fadeOut( 0 );
    $('.pos-call-banner').fadeOut( 0 );
    $('.video-curioso').fadeIn( 0 );
  });

  $('.dev').click(function() {
    $('#call-banner').fadeOut( 0 );
    $('.pos-call-banner').fadeOut( 0 );
    $('.video-dev').fadeIn( 0 );
  });
  $('.produtor').click(function() {
    $('#call-banner').fadeOut( 0 );
    $('.pos-call-banner').fadeOut( 0 );
    $('.video-produtor').fadeIn( 0 );
  });

  $("nav#menu ul:not(.submenu) > li > a").focus(function() {
    $("nav#menu ul:not(.submenu) > li > a").not(":focus").siblings(".submenu").removeClass("submenu-visible");

    $(this).siblings(".submenu").addClass("submenu-visible");

    $("html").click(function(){
      $(".submenu").removeClass("submenu-visible");
    });
    $('#menu a').hover(function() {
      $(".submenu").removeClass("submenu-visible");
    });
  });

  $('.jump-menu a').focus(function() {
    $("#main-content").css("padding-top", "60px");
  });
  $('.jump-menu a').click(function() {
    $("#main-content").css("padding-top", "80px");
    $(".curioso a").focus();
  });
  $('.jump-menu a').focusout(function() {
    $("#main-content").css("padding-top", "0px");
  });
  $(".curioso a").focus(function(){
    $("#main-content").css("padding-top", "0px");
  });
});
})(jQuery);