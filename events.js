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
    });

    router.post('/', (req,res)=>{
        let reqBody = req.body;
        console.log(reqBody);
        let sql = 'INSERT into got_events (name, location, season, episode, summary) VALUES (?, ?, ?, ?, ?)';
        let inserts = [reqBody.name, reqBody.location, reqBody.season, reqBody.episode, reqBody.summary];
        req.app.get('mysql').pool.query(sql, inserts, (err,results,fields)=>{
            if(err){
                console.log(err)
                res.write(JSON.stringify(err));
                res.end();
            }
            else{
                res.redirect('/events')
            }
        })
    })

    function getEvents(res, mysql, context, complete){
        let queryString = 'select e.id, e.name, l.name as location, season, episode, summary from got_events e'
        + ' left join got_locations l on l.id = e.location';
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


    return router;
}();