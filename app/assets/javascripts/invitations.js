$(document).ready(function(){
    // **************INVITATION LOGIC TO ADD AND REMOVE ADDRESSES TO THE LIST *************//

    var send_array = []

    $('.invite-email-checkbox').on('click', function(){

        var $this               = $(this),
            address             = $(this).data('email'),
            userId              = $(this).data('userid'),
            albumId             = $(this).data('albumid'),
            id                  = $(this).attr('id'),
            base_li             = '<li id="list'+id+'" data-match-id='+id+'>'+address+'</li>'


        if ($this.is(':checked')) {

            $('#invite-list').append(base_li);
            var invitee = { user_email: address, album_id: albumId  }
            send_array.push(invitee);

        } else {
            $('#list'+id).remove();

            var id = 'list' + id;
            for (var i=0; i<send_array.length; i++){
                object = send_array[i];
                if ( object.user_email == address ) {
                    send_array.splice(i, 1);
                    console.log(send_array);
                    return;
                }
            }
        }
    });

    // *****************END OF INVITATION LOGIC *****************************///


    // ***************SEND INVITATION LOGIC ********************************///
    $('#post-invites').on('click', function(){
        $.ajax({
            type: 'POST',
            url: '/invitations',
            data: { users: JSON.stringify(send_array)  },
            dataType: 'json',
            success: function(data){
                $.each(data, function(index,object){
                    $('input[data-email="'+object.user_email+'"]').attr('disabled', 'disabled');
                    $('input[data-email="'+object.user_email+'"]').parent().parent().css('color', 'gray');
                });
            },
            error: function(){
                
            }
        });
    });

    // ***************END SEND INVITATION LOGIC ***************************///

    $('#checkall').on('click', function(){
        $(':checkbox').prop('checked', this.checked); 
    });  
});

