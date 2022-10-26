$(function(){
  var mySwiper = new Swiper ('.swiper-container', {
    effect: 'fade',
    autoplay: {
      delay: 3000,
      disableOnInteraction: false,
    },
    speed: 2000,
		slidesPerView: 1,      //画像を何枚表示するか
		spaceBetween: 30,      //何ピクセル画像の間隔をあけるか
		loop: true,            //最後の画像までいったらループする
	});
});