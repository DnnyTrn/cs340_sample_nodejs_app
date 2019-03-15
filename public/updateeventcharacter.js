function updateEventCharacter(id) {
    $.ajax({
        url: '/event_characters/' + id,
        type: 'PUT',
        data: $('#update-eventCharacter').serialize(),
        success: function (result) {
            window.location.replace("./");
        }
    })
};
