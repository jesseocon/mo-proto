$(document).ready(function(){
    $("#final-tg").finalTilesGallery({
        minTileWidth: 180,
        margin: 30,
        gridCellSize: 20,
		autoLoadURL: 'ajax-content.html',
		autoLoadOffset: 100,
		onUpdate: function () {
			
			//Example: update ColorBox
			//$(".tile a").colorbox();
		}
    });
});
