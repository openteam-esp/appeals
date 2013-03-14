/* This is a manifest file that'll be compiled into including all the files listed below.
 * Add new JavaScript/Coffee code in separate files in this directory and they'll automatically
 * be included in the compiled file accessible from http://example.com/assets/application.js
 * It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
 * the compiled file.
 *
 *= require jquery
 *= require jquery-ui
 *= require jquery.ui.datepicker-ru
 *= require jquery.iframe.transport
 *= require jquery.fileupload
 *= require jquery_ujs
 *= require rails.validations
 */

function init_datepicker() {

  if ($.fn.datepicker) {
    $("input.datepicker").datepicker({
      changeMonth: true,
      changeYear: true,
      showOn: "button",
      buttonText: '',
      buttonImage: "/assets/ui/calendar.png",
      buttonImageOnly: true
    });
  };

};

function uploads_manage() {
  $('.upload_link').click(function() {
    var params = $(this).attr('params');
    var target = '.'+$(this).attr('id');
    $(this).slideUp();
    $(target).html(
      $('<iframe/>',{ src: '/el_finder?'+params, width:'700', height:'400', scrolling:'no', id:'el_finder_iframe'}).load(function(){
        $(".content_wrapper").animate({ scrollTop: $(document).height()+$(target).height()}, "slow");
      })
    ).slideDown();

    return false;
  });
};

$(function() {
  init_datepicker();

  uploads_manage();

  $(".focus_first:first").focus();

  $('.disable').live('click', function(){
    return false;
  });

  $('.actions a').not('.trash, .print_version, .clear_search, .cancel').click(function(){
    var target = $('.formtastic.'+$(this).attr('id'));
    $('.formtastic.note, .formtastic.redirect, .formtastic.review').not(target).slideUp('slow');
    target.slideToggle('slow');
    return false;
  });

  $('.reply_wrapper')
    .bind('ajax:success', function(evt, data, status, xhr){
      $('.reply_wrapper').html(xhr.responseText);
      $('.close').addClass('disable');
      init_datepicker();
      uploads_manage();
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

function preload_images(images) {
  $("<div />")
    .addClass("images_preload")
    .appendTo("body")
    .css({
      "position": "absolute",
      "bottom": 0,
      "left": 0,
      "visibility": "hidden",
      "z-index": -9999
    });
  $.each(images, function(index, value) {
    $("<img src='" + value + "' />").appendTo($(".images_preload"));
  });
};

preload_images([
  "/assets/ajax_loading.gif",
  "/assets/ui/calendar.png"
]);
