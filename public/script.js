const app = {};

// initalize click listeners
app.init = function(){
    this.add();
    // this.delete();
    // this.search();

}
// adding a new row
app.add = function() {
    //the only post form on the page
    const add_form = $("[method='post']");
    
    $(document).ready(
        // click listener to add button submit button
        $('#add').on('click', function(){

            if (validateForm(add_form)) {
                event.stopPropagation();    //Please fill out this field message will popup
                return;
            }

            $.ajax({
                url: window.location.pathname,
                // url: '/character',
                type: 'POST',
                data: add_form.serialize(),
                success: function (result, success, xhr) {
                    // window.location.replace("." + this.url); 
                    console.log(result);
                    app.displayNewTable(result);
                }
            })
        })
    );
}

// helper function for add and search buttons
app.displayNewTable = function (result) {
    const rawTemplate = $("script[type='text/x-handlebars-template']").html();
    const compiledTemplate = Handlebars.compile(rawTemplate);
    const generatedHTML = compiledTemplate(result);

    $('tbody').remove();
    $('table').append(generatedHTML);
    $('form').trigger("reset"); //reset form back to default
}

// client-side validation 
function validateForm(jqForm) {
    
    const form_array = jqForm.serializeArray();
    // since the first column names in the db cannot be null, we're just validating for the form's first value
    if(form_array[0].value.trim().length === 0){
        console.log('empty string detected - form not sent')
        return true;
    }

    return false;
}
// this function manages the tooltips for the add and delete buttons 
$(function () {
    $('[data-toggle="tooltip"]').on('click', function () {
        $(this).tooltip('hide')
    })
    $('[data-toggle="tooltip"]').tooltip()
});

//ajax post request when user adds a new table row
// function add() {    

//     //the only post form on the page
//     const add_form = $("[method='post']");
  
//     // check if name is whitespace or blank
//     if (!add_form[0][0].value.trim().length || add_form[0][0].validity.valueMissing)
//     {
//         // event.preventDefault();  
//         event.stopPropagation();  //display user required message
//     }else{
//         $(document).ready(
//             $.ajax({
//                 url: window.location.pathname,
//                 // url: '/character',
//                 type: 'POST',
//                 data: add_form.serialize(),   
//                 success: function (result, success, xhr) {
//                     // window.location.replace("." + this.url); 

//                     // create a new tbody with the new row using Handlebars script
//                     console.log(result);
//                     let rawTemplate = $("script[type='text/x-handlebars-template']").html();
//                     var compiledTemplate = Handlebars.compile(rawTemplate);
//                     var generatedHTML = compiledTemplate(result);

//                     $('tbody').remove();
//                     $('table').append(generatedHTML);
//                     $('form').trigger("reset");
//                 }
//             })
//         )
//     }
// };

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
    this.disabled=true; //disable search button's apperance so it cannot be spam clicked

        const search_form_id = $('#search-name');
        const search_array = $('#search-name').serializeArray();
        console.log(search_array);
        console.log(search_array[0].value);
        if (!search_array[0].value.trim().length)
        {
            console.log('Failed validation - input length is 0')
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
                        $('form').trigger("reset");

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

                app.init();