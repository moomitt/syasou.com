/*global $*/
/*global Swiper*/

//スライダー１：トップイメージ
$(function(){
  var mySwiper1 = new Swiper ('.slider1', {
    effect: 'fade',
    autoplay: {
      delay: 3000,
      disableOnInteraction: false,
    },
    speed: 2000,
		slidesPerView: 1,
		spaceBetween: 30,
		loop: true,
	});
});

//スライダー２：人気の投稿
$(function(){
	var mySwiper2 = new Swiper ('.slider2', {
	  effect: 'slide',
	  spaceBetween: 54,
		slidesPerView: 1,
		slidesPerGroup: 1,
		loop: true,
		pagination: {
		 el: '.swiper-pagination',
		 type: 'bullets',
		 clickable: true,
		},
		navigation: {
		 nextEl: '.swiper-button-next',
		 prevEl: '.swiper-button-prev',
		},
		breakpoints: {
      680: {
        slidesPerView: 2,
        slidesPerGroup: 2,
      },
      1080: {
        slidesPerView: 3,
        slidesPerGroup: 3,
      }
    }
	});
});

//スライダー３：新着投稿
$(function(){
	var mySwiper3 = new Swiper ('.slider3', {
	  effect: 'slide',
	  spaceBetween: 54,
		slidesPerView: 1,
		slidesPerGroup: 1,
		loop: true,
		pagination: {
		 el: '.swiper-pagination',
		 type: 'bullets',
		 clickable: true,
		},
		navigation: {
		 nextEl: '.swiper-button-next',
		 prevEl: '.swiper-button-prev',
		},
		breakpoints: {
      690: {
        slidesPerView: 2,
        slidesPerGroup: 2,
      },
      1080: {
        slidesPerView: 3,
        slidesPerGroup: 3,
      }
    }
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
