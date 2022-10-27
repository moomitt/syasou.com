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

	var mySwiper2 = new Swiper ('.slider2', {
	  effect: 'slide',
	  autoWidth: false,
		slidesPerView: 3,       //画像を何枚表示するか
		slidesPerGroup: 3,
		spaceBetween: 10,       //何ピクセル画像の間隔をあけるか
		centeredSlides : false,  //見切らせたい場合メイン画像をセンターにもってくるか,
		loop: true,             //最後の画像までいったらループする
		pagination: {
		 el: '.swiper-pagination',
		 type: 'bullets',
		 clickable: true,
		},
		navigation: {
		 nextEl: '.swiper-button-next',
		 prevEl: '.swiper-button-prev',
		}
	});
});