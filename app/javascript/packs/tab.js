$('#tab-contents .tab[id != "tab1"]').hide();

$('#tab-menu a').on('click', function(event){
  $('#tab-contents .tab').hide();
  $('#tab-menu .active').removeClass("active");
  $(this).addClass("active");
  $($(this).attr('href')).show();
  event.preventDefault();
})

$(".modal-open").on('click',function(){
  $("#modal-overlay").fadeIn("fast");
});
// 閉じるボタンかオーバーレイ部をクリックでモーダルウィンドウ削除
$("#modal-close,#modal-overlay").on('click',function(){
  $("#modal-overlay").fadeOut("fast");
});
// ログイン・新規登録ボタンを押すと非表示のlink_toをクリックする
$("#modal-login").on('click',function(){
  document.getElementById("logInBtn").click();
});
$("#modal-signup").on('click',function(){
  document.getElementById("signUpBtn").click();
});