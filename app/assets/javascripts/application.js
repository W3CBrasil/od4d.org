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

  $('.call-banner').mouseover(function(){
    //classe do background de cada opção para hover
    $('.call-banner .curioso').mouseover(function() {
      $('#call-banner').addClass('bgCuriosoCallBanner');
    });
    $('.call-banner .dev').mouseover(function() {
      $('#call-banner').addClass('bgDevCallBanner');
    });
    $('.call-banner .produtor').mouseover(function() {
      $('#call-banner').addClass('bgProdutorCallBanner');
    });

    $('.call-banner .curioso').mouseout(function() {
      $('#call-banner').removeClass('bgCuriosoCallBanner');
    });
    $('.call-banner .dev').mouseout(function() {
      $('#call-banner').removeClass('bgDevCallBanner');
    });
    $('.call-banner .produtor').mouseout(function() {
      $('#call-banner').removeClass('bgProdutorCallBanner');
    });
  });


  //play de vídeo ou slideshare de cada opção
  $('.call-banner .curioso').click(function() {
    $('#call-banner').fadeOut( 100 );
    $('.video-curioso').fadeIn( 100 );

    $('#vidcur').get(0).play();
  });

  $('.call-banner .dev').click(function() {
    $('#call-banner').fadeOut( 100 );
    $('.video-dev').fadeIn( 100 );

    $('#viddev').get(0).play()
  });
  $('.call-banner .produtor').click(function() {
    $('#call-banner').fadeOut( 100 );
    $('.video-produtor').fadeIn( 100 );

    $('#vidprod').get(0).play()
  });

  //TODO: fazer ao TÉRMINO do vídeo ou slideshare VOLTAR para as outras opções
  $('#vidcur').get(0).addEventListener('ended',function(){
    $('.video-call-banner').fadeOut( 0 );
    $('#call-banner').fadeIn( 0 );
  });
  $('#viddev').get(0).addEventListener('ended',function(){
    $('.video-call-banner').fadeOut( 0 );
    $('#call-banner').fadeIn( 0 );
  });
  $('#vidprod').get(0).addEventListener('ended',function(){
    $('.video-call-banner').fadeOut( 0 );
    $('#call-banner').fadeIn( 0 );
  });
});