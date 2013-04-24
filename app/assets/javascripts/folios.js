$(document).ready(function(){
    
    $('#check-availability').on('click', function(){

        var availability_url = $(this).data('url'),
            keyword          = $('#hashtag').val();
            
        $.ajax({
            type: 'GET',
            datatype: 'json',
            url: availability_url + '.json',
            data: { keyword: keyword },
            success: function(data){
               
               if ( data == true ) {
                    
                    $('#keyword-message').html('The keyword is available').
                    removeClass('error').
                    addClass('ok');
               } else {
                   
                    $('#keyword-message').html('The keyword is not available').
                    removeClass('ok').
                    addClass('error')
                    
               } 
            }
        });

    });
});
