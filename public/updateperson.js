function updatePerson(id){
    $.ajax({
        url: '/people/' + id,
        type: 'PUT',
        data: $('form').serialize(),
        success: function(result){
            window.location.replace("./");
        }
    })
};
