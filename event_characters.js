module.exports = function(){
    var express = require('express');
    var router = express.Router();

    //populates the event_characters table for /event_characters
    function getEventCharacters(res, mysql, context, complete){
        let queryString = 'SELECT ec.id as combined_id, e.name as event_name, c.fname, c.lname FROM got_events_characters ec '
        + ' left join got_characters c on c.id = ec.character_id '
        + ' left join got_events e on e.id = ec.event_id';
        mysql.pool.query(queryString, function(error, results, fields){

            if(error){
                res.write(JSON.stringify(error));
                res.end();
            }
            context.event_characters  = results;
            complete();
        });
    }

    function getCharacters(res, mysql, context, complete){
        let queryString = 'SELECT id, fname, lname FROM got_characters';
        mysql.pool.query(queryString, (err, results, fields)=>{
            if(err){
                res.write(JSON.stringify(err));
                res.end();
            }
            context.characters = results;
            complete();
        })
    }

    function getEvents(res, mysql, context, complete){
        let queryString = 'SELECT id as fromEvent_id, name FROM got_events';
        mysql.pool.query(queryString, (err, results, fields)=>{
            if(err){
                res.write(JSON.stringify(err));
                res.end();
            }
            context.events = results;
            complete();
        })
    }

    /*Display all events and their characters.*/

    router.get('/', function(req, res){
        console.log('get/')
        var callbackCount = 0;
        var context = {};
        var mysql = req.app.get('mysql');

        getEventCharacters(res, mysql, context, complete);
        getEvents(res, mysql, context, complete);
        getCharacters(res, mysql, context, complete);

        function complete(){
            callbackCount++;
            if(callbackCount >= 3){
                res.render('event_characters', context);
            }

        }
    });

    router.post('/', function (req, res) {
        console.log('/post')
        console.log(req.body)
        var mysql = req.app.get('mysql');
        var sql = 'INSERT INTO got_events_characters (event_id, character_id) VALUES (?,?)';
        var inserts = [req.body.event_id, req.body.character_id];


        //convertEmptyStringToNull(inserts);

        sql = mysql.pool.query(sql, inserts, function(error, results, field){
            if (error) {
                //Take this out for final
                console.log(error)
                res.write(JSON.stringify(error));
                res.end();
            }
            else{
                res.redirect('/event_characters');
            }
        })
    });

    function getAnEventCharacter(res, mysql, context, id, complete){
        var sql = 'SELECT id, event_id, character_id FROM got_events_characters WHERE id = ?';
        var inserts = [id];
        mysql.pool.query(sql, inserts, function (error, results, fields) {
            if (error) {
                res.write(JSON.stringify(error));
                res.end();
            }
            context.event_character = results[0];
            complete();
        });

    }

    //Display one event/character for the specific purpose of updating event/character  */
    router.get('/:id', function (req, res) {
        callbackCount = 0;
        var context = {};
        context.jsscripts = ['selectedCharacter.js', 'selectedEvent.js', 'updateeventcharacter.js'];
        var mysql = req.app.get('mysql');

        getAnEventCharacter(res, mysql, context, req.params.id, complete);
        getCharacters(res, mysql, context, complete);
        getEvents(res, mysql, context, complete)

        function complete() {
            callbackCount++;
            if (callbackCount >= 3) {
                res.render('update-eventCharacter', context);
            }
        }
    });

    /* The URI that update data is sent to in order to update an event/character */

    router.put('/:id', function (req, res) {
        var mysql = req.app.get('mysql');
        console.log('put/:id')
        console.log(req.body)
        console.log(req.body.event_id)
        console.log(req.body.character_id)
        console.log(req.params.id)


        var sql = "UPDATE got_events_characters SET event_id = ?, character_id = ? WHERE id = ?";
        var inserts = [
            req.body.event_id,
            req.body.character_id,
            req.params.id
        ];

        console.log(sql);
        //convertEmptyStringToNull(inserts);
        sql = mysql.pool.query(sql, inserts, function (error, results, fields) {
            if (error) {
                console.log(error)
                res.write(JSON.stringify(error));
                res.end();
            } else {
                res.status(200);
                res.end();
            }
        });
    });

    return router;
}();
