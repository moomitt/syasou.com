/*global $*/

//タブ表示機能
$(function(){
  //初期表示
  $('#tab-contents .tab[id != "tab1"]').hide();
  //クリック時のイベント
  $('#tab-menu a').on('click', function(event){
    $('#tab-contents .tab').hide();
    $('#tab-menu .active').removeClass("active");
    $(this).addClass("active");
    $($(this).attr('href')).show();
    event.preventDefault();
  });
});

//モーダルウィンドウ（ゲストログイン用）
$(function(){
  //表示・非表示
  $(".modal-open").on('click',function(){
    $("#modal-overlay").fadeIn("fast");
  });
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
});