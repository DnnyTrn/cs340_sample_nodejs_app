// this function manages the tooltips for the add and delete buttons 
$(function () {
    $('[data-toggle="tooltip"]').on('click', function () {
        $(this).tooltip('hide')
    })
    $('[data-toggle="tooltip"]').tooltip()
});

//ajax post request when user adds a new table row
function add() {    
    $(document).ready(
        $.ajax({
            url: window.location.pathname,
            // url: '/character',
            type: 'POST',
            data: $('form').serialize(),
            success: function (result, success, xhr) {
                // window.location.replace("." + this.url); 

                // create a new tbody with the new row using Handlebars script
                console.log(result);
                let rawTemplate = $("script[type='text/x-handlebars-template']").html();
                var compiledTemplate = Handlebars.compile(rawTemplate);
                var generatedHTML = compiledTemplate(result);

                $('tbody').remove();
                $('table').append(generatedHTML);
                $('form').trigger("reset");
            }
        })
        
    )
};

// ajax function that accesses the delete request. 
//parameter id is the id from the <tr> row
function deleteRow(id) {
    $(document).ready(
        $.ajax({
            url: window.location.pathname,
            type: 'DELETE',
            data: {id},
            success: (result, success, xhr)=>{
                console.log('delete row with id: ' + id);
                $('#' + id).fadeOut(500, function(){
                    $(this).remove();
                })
            }
        })
    )
};