const app = {};

// initalize click listeners
app.init = function(){
    this.addRow();
    this.deleteRow();
    // this.searchButton();

}
// adding a new row
app.addRow = function() {
    $(document).ready(
        // click listener to add button submit button
        $('#add').on('click', function add_click(event){

            //the only post form on the page
            const add_form = $("[method='post']");

            if (validateForm(add_form)) {

                event.stopPropagation();    //Please fill out this field message will popup
                return;
            }
            else{
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
            }
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

app.deleteRow = function() {
    $(document).ready(function(){
        // apply click listeners to delete buttons
        $('table').on('click', '.delete-btn', function(){
            const id = Number($(this).closest('tr').prop('id'));

            $.ajax({
                url: window.location.pathname,
                type: 'DELETE',
                data: {id},
                success: (results, success, xhr) => {
                    console.log('deleted row with id: ' + id);
                    $(this).closest('tr').fadeOut(500, function(){
                        $(this).remove();
                    })
                }
            })
        })
    })
}

// this function manages the tooltips for the add and delete buttons 
$(function () {
    $('[data-toggle="tooltip"]').on('click', function () {
        $(this).tooltip('hide')
    })
    $('[data-toggle="tooltip"]').tooltip()
});

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

// intialize event listeners
app.init();