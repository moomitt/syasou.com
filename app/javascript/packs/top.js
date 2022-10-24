$(function(){
  var mySwiper = new Swiper ('.swiper-container', {
    speed: 500,
    autoplay: {
      delay: 4000,
      disableOnInteraction: false,
    },
		slidesPerView: 1,      //画像を何枚表示するか
		spaceBetween: 30,      //何ピクセル画像の間隔をあけるか
		loop: true,            //最後の画像までいったらループする
	});
});