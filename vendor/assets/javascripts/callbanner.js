
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
    
