var rosen;
function init() {
  rosen = new Rosen("map", {            // "map"は<div>のidと一致させる
    apiKey: process.env.ROSEN_JS_API_KEY, // アクセスキー
    apiSetting: "https",                // HTTPS版のAPIサーバを指定
    tileSetting: "https"                // HTTPS版のタイルサーバを指定
  });
}
window.addEventListener('load', init);