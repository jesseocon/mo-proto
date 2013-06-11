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
			
			$('.tile').on('mouseenter', function(){
                $(this).children().children('div.new-thing').addClass('display-some');
            });

            $('.tile').on('mouseleave', function(){
                $(this).children().children('div.new-thing').removeClass('display-some');
            });
            
            $('div.new-thing').overlayify();
            
            $('div.new-thing').click(function(){
                var userId             = $(this).data('uid'),
                    incomingMessageId = $(this).data('imid'),
                    path                = $(this).data('star-url'),
                    id                  = '#'+ $(this).attr('id');

                $.ajax({
                    type: 'POST',
                    url: path,
                    data: {
                      star: { 
                        user_id: userId,
                        incoming_message_id: incomingMessageId
                      }  
                    },
                    dataType: 'json',
                    success: function(data){
                        $(id+' img').attr('src', /assets/StarWhite.png);
                        console.log('it worked');
                    },
                    error: function(data) {
                        console.log("it didn't work");
                    }
                });
            });
			
			
		}
    });
    
    $('.tile').on('mouseenter', function(){
        $(this).children().children('div.new-thing').addClass('display-some');
    });

    $('.tile').on('mouseleave', function(){
        $(this).children().children('div.new-thing').removeClass('display-some');
    });
    
    $('div.new-thing').overlayify();
    
    $('div.new-thing').click(function(){
        var userId             = $(this).data('uid'),
            incomingMessageId = $(this).data('imid'),
            path                = $(this).data('star-url'),
            id                  = '#'+ $(this).attr('id');

        $.ajax({
            type: 'POST',
            url: path,
            data: {
              star: { 
                user_id: userId,
                incoming_message_id: incomingMessageId
              }  
            },
            dataType: 'json',
            success: function(data){
                $(id+' img').attr('src', /assets/StarWhite.png);
                console.log('it worked');
            },
            error: function(data) {
                console.log("it didn't work");
            }
        });
    });
});

(function ( $ ) {
    $.fn.overlayify = function(options){
        return this.each(function() {
            
            
            $(this).on('click', function(e){
                e.stopPropagation();
                e.preventDefault();
                //$(this).parent().removeClass('cboxElement');
                $(this).removeClass('cboxElement');
            });
        });
    }

})(jQuery);
