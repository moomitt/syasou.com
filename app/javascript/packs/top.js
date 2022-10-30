$(function(){
  var mySwiper1 = new Swiper ('.slider1', {
    effect: 'fade',
    autoplay: {
      delay: 3000,
      disableOnInteraction: false,
    },
    speed: 2000,
		slidesPerView: 1,       //画像を何枚表示するか
		spaceBetween: 30,       //何ピクセル画像の間隔をあけるか
		loop: true,             //最後の画像までいったらループする
	});
});

$(function(){
	var mySwiper2 = new Swiper ('.slider2', {
	  effect: 'slide',
	  spaceBetween: 30,
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
      768: {
        slidesPerView: 2,
        slidesPerGroup: 2,
      	centeredSlides : false,
      },
      1080: {
        slidesPerView: 3,
        slidesPerGroup: 3,
        centeredSlides : false,
      }
    }
	});
});

$(function(){
	var mySwiper3 = new Swiper ('.slider3', {
	  effect: 'slide',
	  spaceBetween: 30,
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
      768: {
        slidesPerView: 2,
        slidesPerGroup: 2,
      	centeredSlides : false,
      },
      1080: {
        slidesPerView: 3,
        slidesPerGroup: 3,
        centeredSlides : false,
      }
    }
	});

	// #modal-openがクリックされたらモーダルウィンドウを表示
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
});
