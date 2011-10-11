/* This is a manifest file that'll be compiled into including all the files listed below.
 * Add new JavaScript/Coffee code in separate files in this directory and they'll automatically
 * be included in the compiled file accessible from http://example.com/assets/application.js
 * It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
 * the compiled file.
 *
 *= require jquery
 *= require jquery_ujs
 *= require_tree .
 */

$(function(){
  $(".focus_first:first").focus();
  $('.disable').click(function(){
    return false;
  });

  $('.reply_wrapper')
    .bind('ajax:success', function(evt, data, status, xhr){
      $('.reply_wrapper').html(xhr.responseText);
      $('.close').addClass('disable');
    })
    .bind('ajax:complete', function(evt, xhr, status){
      $('.reply_wrapper').html(xhr.responseText);
      if ($('.reply_wrapper .reply_info:first').attr('can_close') == 'true') {
        $('.close').removeClass('disable') ;
      } else {
        $('.close').addClass('disable');
      };
    });
});
