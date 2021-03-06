module.exports = function() {
    var express = require('express');
    var router = express.Router();

    //populates the event_characters table for /event_characters
    function getEventCharacters(res, mysql, context, complete) {
        let queryString = 'SELECT ec.id as combined_id, e.name as event_name, c.fname, c.lname FROM got_events_characters ec '
            + ' left join got_characters c on c.id = ec.character_id '
            + ' left join got_events e on e.id = ec.event_id';
        mysql.pool.query(queryString, function (error, results, fields) {

            if (error) {
                res.write(JSON.stringify(error));
                res.end();
            }
            context.event_characters = results;
            complete();
        });
    }

    function getCharacters(res, mysql, context, complete) {
        let queryString = 'SELECT id, fname, lname FROM got_characters';
        mysql.pool.query(queryString, (err, results, fields) => {
            if (err) {
                res.write(JSON.stringify(err));
                res.end();
            }
            context.characters = results;
            complete();
        })
    }

    function getEvents(res, mysql, context, complete) {
        let queryString = 'SELECT id as fromEvent_id, name FROM got_events';
        mysql.pool.query(queryString, (err, results, fields) => {
            if (err) {
                res.write(JSON.stringify(err));
                res.end();
            }
            context.events = results;
            complete();
        })
    }

    /*Display all events and their characters.*/

    router.get('/', function (req, res) {
        var callbackCount = 0;
        var context = {};
        var mysql = req.app.get('mysql');

        getEventCharacters(res, mysql, context, complete);
        getEvents(res, mysql, context, complete);
        getCharacters(res, mysql, context, complete);

        function complete() {
            callbackCount++;
            if (callbackCount >= 3) {
                res.render('event_characters', context);
            }

        }
    });

    router.post('/', function (req, res) {
        var mysql = req.app.get('mysql');
        var sql = 'INSERT INTO got_events_characters (event_id, character_id) VALUES (?,?)';
        var inserts = [req.body.event_id, req.body.character_id];

        convertEmptyStringToNull(inserts);

        sql = mysql.pool.query(sql, inserts, function (error, results, field) {
            if (error) {
                res.send(JSON.stringify(error));
                res.end();
            }
            else {
                let context = {};
                let callbackCount = 0;
                getEventCharacters(res, mysql, context, complete);

                function complete() {
                    callbackCount++;
                    if(callbackCount >= 1){
                        res.send(context);
                    }   
                }
            }
        })
    });

    function getAnEventCharacter(res, mysql, context, id, complete) {
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
        var sql = "UPDATE got_events_characters SET event_id = ?, character_id = ? WHERE id = ?";
        var inserts = [
            req.body.event_id,
            req.body.character_id,
            req.params.id
        ];

        convertEmptyStringToNull(inserts);
        sql = mysql.pool.query(sql, inserts, function (error, results, fields) {
            if (error) {
                res.send(JSON.stringify(error));
                res.end();
            } else {
                res.status(200);
                res.end();
            }
        });
    });

    router.get("/search/:name", function (req, res) {
        var callbackCount = 0;
        var context = {};
        var mysql = req.app.get("mysql");

        getEventsCharactersNameLike(req, res, mysql, context, complete);

        function complete() {
            callbackCount++;
            if (callbackCount >= 1) {
                res.send(context);
            }
        }
    });

    function getEventsCharactersNameLike(req, res, mysql, context, complete) {
        const sql =
            'SELECT ec.id as combined_id, e.name as event_name, c.fname, c.lname FROM got_events_characters ec '
            + ' left join got_characters c on c.id = ec.character_id '
            + ' left join got_events e on e.id = ec.event_id where e.name like ' +
            mysql.pool.escape(req.params.name + "%") +
            " order by ec.id DESC";
        mysql.pool.query(sql, function (err, results, fields) {
            if (err) {
                res.write(JSON.stringify(err));
            }
            context.event_characters = results;
            complete();
        });
    }

    /* Route to delete a person, simply returns a 202 upon success. Ajax will handle this. */
    router.delete("/", function (req, res) {
        var mysql = req.app.get("mysql");
        var sql = "DELETE FROM got_events_characters WHERE id = ?";
        var inserts = [req.body.id];
        sql = mysql.pool.query(sql, inserts, function (error, results, fields) {
            if (error) {
                res.write(JSON.stringify(error));
                res.status(400);
                res.end();
            } else {
                res.status(202).end();
            }
        });
    });

    return router;
}();

// returns true if string length is 0
String.prototype.isEmpty = function () {
    return this.length === 0 || !this.trim();
};

// changes empty strings to value of null
function convertEmptyStringToNull(inserts) {
    inserts.forEach((element, index) => {
        if (element.isEmpty()) {
            inserts[index] = null;
        }

        // if user puts in a bunch of white spaces for the name set fname so app doesn't crash
        if (inserts[0] === null) {
            inserts[0] = "missing required field";
        }
    });
}
