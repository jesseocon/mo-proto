$(document).ready(function(){
    $(".tile a").colorbox({rel:'tile', transition:"fade", width:"75%", height:"75%"});
    $("#final-tg").finalTilesGallery({
        minTileWidth: 180,
        margin: 30,
        gridCellSize: 20,
		autoLoadURL: '/albums/1/get_html_pics',
		autoLoadOffset: 100,
		onUpdate: function () {
			
			//Example: update ColorBox
			//$(".tile a").colorbox();
			
			$(".tile a").colorbox({
			    rel:'tile', 
			    transition:"fade", 
			    width:"75%", 
			    height:"75%", 
			    scalePhotos: true
			});
		}
    });
});
