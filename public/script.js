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
                var rawTemplate = document.getElementById('characterTemplate').innerHTML;
                var compiledTemplate = Handlebars.compile(rawTemplate);
                var generatedHTML = compiledTemplate(result);

                $('tbody').remove();
                $('table').append(generatedHTML);
                $('form').trigger("reset");
            }
        })
        
    )
};

