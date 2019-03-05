module.exports = function(){
    let express = require('express');
    let router = express.Router();

    router.get('/', (req,res)=>{
        var callbackCount = 0;
        var context = {};
        var mysql = req.app.get('mysql');

        // get functions
        getEvents(res, mysql, context, complete);
        getLocations(res, mysql, context, complete);
        function complete() {
            callbackCount++;
            if (callbackCount >= 2) {  //adding more get functions increase this number!!
                res.render('events', context);
            }
        }
    })

    router.post('/', (req,res)=>{
        let reqBody = req.body;
        console.log(reqBody);
        let sql = 'INSERT into got_events (name, location, season, episode, summary) VALUES (?, ?, ?, ?, ?)';
        let inserts = [reqBody.name, reqBody.location, reqBody.season, reqBody.episode, reqBody.summary];
        convertEmptyStringToNull(inserts);
        sql = req.app.get('mysql').pool.query(sql, inserts, (err,results,fields)=>{
            if(err){
                console.log(err)
                res.write(JSON.stringify(err));
                res.end();
            }
            else{
                // res.redirect('/events') 
                var callbackCount = 0;
                var context = {};
                var mysql = req.app.get('mysql');

                // get functions
                getEvents(res, mysql, context, complete);

                function complete() {
                    callbackCount++;
                    if (callbackCount >= 1) {  //adding more get functions increase this number!!
                        res.send(context);
                    }
                }
            }
        })
    })

    function getEvents(res, mysql, context, complete){
        let queryString = 'select e.id, e.name, l.name as location, season, episode, summary from got_events e'
        + ' left join got_locations l on l.id = e.location ORDER by e.id DESC';
        mysql.pool.query(queryString, (err, results, fields)=>{

            if(err){
                res.write(err)
                res.end();
            }

            context.events = results;
            complete();
        })
    }

    function getLocations(res, mysql, context, complete){
        let queryString = 'select id, name, region, continent_id from got_locations';
        mysql.pool.query(queryString, (err, results, fields)=>{
            if(err)
            {
                res.write(JSON.stringify(err));
                console.log(err);
                res.end();
            }
            context.locations = results;
            complete();
        })
    }

    function getAEvent(res, mysql, context, id, complete){
        var sql = 'select id, name, location, season, episode, summary from got_events where id = ?';
        var inserts = [id];
        mysql.pool.query(sql, inserts, (err,results,fields)=>{
            if(err){
                res.write(JSON.stringify(err));
                res.end();
            }
            context.event = results[0];
            complete();
        })
    }
    // /* Display one event for the specific purpose of updating an event */
    router.get('/:id', (req,res)=>{
        callbackCount = 0;
        var context = {};
        context.jsscripts = ['selectedlocation.js', 'updateevent.js'];
        var mysql = req.app.get('mysql');

        getAEvent(res, mysql, context, req.params.id, complete);
        getLocations(res, mysql, context, complete);

        function complete() {
            callbackCount++
            if (callbackCount >= 2){
                res.render('update-event', context);
            }
        }
    });

    router.put('/:id', (req,res)=>{
        console.log('put/:id')
        console.log(req.body)
        console.log(req.params.id)
        
        var sql = 'UPDATE got_events SET name = ?, location = ?, season = ?, episode = ?, summary = ? WHERE id = ?';

        var inserts = [
            req.body.name,
            req.body.location,
            req.body.season,
            req.body.episode,
            req.body.summary,
            req.params.id
        ];

        convertEmptyStringToNull(inserts);
        sql = req.app.get('mysql').pool.query(sql, inserts, (err,results, fields)=>{
            if(err){
                console.log(err);
                res.write(JSON.stringify(err));
                res.end();
            }
            else{
                res.status(200);
                res.end();
            }
        })
    });

    // returns true if string length is 0
    String.prototype.isEmpty = function () {
        return (this.length === 0 || !this.trim());
    };

    // changes empty strings to value of null
    function convertEmptyStringToNull(inserts) {
        inserts.forEach((element, index) => {
            if (element.isEmpty()) {
                inserts[index] = null;
            }

            // if user puts in a bunch of white spaces for required field change it to string instead of null
            if (inserts[0] === null) {
                inserts[0] = 'missing required field';
            }
        });
    }


    router.delete('/', (req,res)=>{
        console.log('delete id = ' + req.body.id);

        let sql = 'DELETE FROM got_events where id = ?';
        let inserts = [req.body.id];

        req.app.get('mysql').pool.query(sql, inserts, (err,results,fields)=>{
            if(err){
                console.log(err);
                res.write(JSON.stringify(err));
                res.status(400);
                res.end();
            }   else {
                res.status(202).end();
            }
        });
    })

    router.get('/search/:name', (req,res)=>{
        console.log('searching for req.params.name: ' + req.params.name);
        var context = {};
        var callbackCount = 0;
        var mysql = req.app.get('mysql');

        getEventsLike(req, res, mysql, context, complete);

        function complete(){
            callbackCount++;
            if(callbackCount >= 1){
                res.send(context);
            }
        }
    })

    function getEventsLike(req, res, mysql, context, complete){

        let sql = "SELECT e.id, e.name, l.name as location, season, episode, summary from got_events e"
            + " left join got_locations l on l.id = e.location where e.name like " + mysql.pool.escape(req.params.name + '%');
        
        mysql.pool.query(sql, function(error, results, fields){
            if(error){
                res.write(JSON.stringify(error));
                res.end();
            }
            context.events = results;
            complete();
        })
    }

    return router;
}();