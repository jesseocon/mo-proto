$(document).ready(function(){
    $("tile a").colorbox();
    $("#final-tg").finalTilesGallery({
        minTileWidth: 180,
        margin: 30,
        gridCellSize: 20,
		autoLoadURL: '/albums/1/get_html_pics',
		autoLoadOffset: 100,
		onUpdate: function () {
			
			//Example: update ColorBox
			//$(".tile a").colorbox();
			
			$(".tile a").colorbox();
		}
    });
});
