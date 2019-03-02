function deleteCharacter(id) {
    $.ajax({
        url: '/characters/' + id,
        type: 'DELETE',
        success: function (result) {
            // $('#' + id).remove();
            $('#'+ id).fadeOut(500, function(){
                $(this).remove();
            });
        }
    })
};