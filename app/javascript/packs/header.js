/*global $*/
$(function() {
  //menuボタンクリック時のイベント
  $('.menu-trigger').on('click', function(event) {
    $(this).toggleClass('active');
    $('#hm-logo').toggleClass('active');
    $('#sp-menu').fadeToggle();
    event.preventDefault();
  });
});