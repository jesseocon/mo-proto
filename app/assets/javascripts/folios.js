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
    
    $('#register-keyword').on('click', function(e){
        var availability_url = $(this).data('url');
        var keyword = $('#hashtag').val();


        $.ajax({
            type: 'GET',
            datatype: 'json',
            url: availability_url + '.json',
            data: { keyword: keyword },
            success: function(response){
                console.log(response.response.status)
                if ( response.response.status == 'success' ) {
                    $('#purchase-message').html('The keyword has been purchased')
                    .removeClass('error')
                    .addClass('ok');
                } else {
                    $('#purchase-message').html('The keyword could not be purchased')
                    .removeClass('ok')
                    .addClass('error');
                }
            }
        });

    });
    
    $('#deregister-keyword').on('click', function(e){
        var availability_url = $(this).data('url');
        var keyword = $('#hashtag').val();


        $.ajax({
            type: 'GET',
            datatype: 'json',
            url: availability_url + '.json',
            data: {keyword: keyword},
            success: function(response){
                console.log(response.response.status)
                if ( response.response.status == 'success' ) {
                    $('#delete-message').html('The keyword has been deleted')
                    .removeClass('error')
                    .addClass('ok');
                } else {
                    $('#delete-message').html('The keyword could not be deleted')
                    .removeClass('ok')
                    .addClass('error');
                }
            }
        });

    });
});




























