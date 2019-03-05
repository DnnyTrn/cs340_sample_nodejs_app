
// this function manages the tooltips for the add and delete buttons 
$(function () {
    $('[data-toggle="tooltip"]').on('click', function () {
        $(this).tooltip('hide')
    })
    $('[data-toggle="tooltip"]').tooltip()
});

//ajax post request when user adds a new table row
function add() {    

    //the only post form on the page
    const add_form = $("[method='post']");
  
    // check if name is whitespace or blank
    if (!add_form[0][0].value.trim().length || add_form[0][0].validity.valueMissing)
    {
        // event.preventDefault();  
        event.stopPropagation();  //display user required message
    }else{
        $(document).ready(
            $.ajax({
                url: window.location.pathname,
                // url: '/character',
                type: 'POST',
                data: add_form.serialize(),   
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
    }
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

// search for all people with names like %
// ajax get request to 'pagename/search/:name
$('#search-button').on("click", function(){
    this.disabled=true; //disables search button's appearance so it cannot be spam clicked

        const search_form_id = $('#search-name');
        const search_array = $('#search-name').serializeArray();
        console.log(search_array);
        console.log(search_array[0].value);
        if (!search_array[0].value.trim().length)
        {
            console.log('Failed validation - value has length of zero')
            // event.preventDefault();  
            event.stopPropagation();  //display user required message
        }
        else{
            $(document).ready(
                $.ajax({
                    url: window.location.pathname + '/search/' + encodeURI(search_array[0].value),
                    type: 'GET',
                    success: (result, success, xhr) => {
                        console.log(success);
                        console.log(result);
                        let rawTemplate = $("script[type='text/x-handlebars-template']").html();
                        var compiledTemplate = Handlebars.compile(rawTemplate);
                        var generatedHTML = compiledTemplate(result);

                        $('tbody').remove();
                        $('table').append(generatedHTML);
                    }
                })
            )   
        }

        // enabled search button after 1 second
    setTimeout(function () {
        document.getElementById('search-button').disabled = false;
    }, 1000);
})

// allows user to press enter and click to submit search
    // search_form_id.unbind('submit').submit(function(event){
                // insert code to prevent spamming requests 
                //     event.preventDefault(); //prevents the form button from reloading the page

                //     $.ajax({
                //         url: window.location.pathname + '/search/' + search_form_id[0][0].value,
                //         type: 'GET',
                //         success: (result, success, xhr) =>{
                //             console.log(success);
                //             console.log(result);
                //             let rawTemplate = $("script[type='text/x-handlebars-template']").html();
                //             var compiledTemplate = Handlebars.compile(rawTemplate);
                //             var generatedHTML = compiledTemplate(result);

                //             $('tbody').remove();
                //             $('table').append(generatedHTML);

                //         }
                //     })
                // })    
                // };