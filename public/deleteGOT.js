function deleteCharacter(id) {
    $.ajax({
        url: '/characters/' + id,
        type: 'DELETE',
        success: function (result) {
            $('#'+ id).fadeOut(500, function(){
                $(this).remove();
            });
        }
    })
};