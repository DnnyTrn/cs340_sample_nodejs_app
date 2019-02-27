module.exports = function () {
    let express = require('express');
    let router = express.Router();

    router.get('/', (req,res)=>{
        var callbackCount = 0;
        var context = {};
        var mysql = req.app.get('mysql');

        // get functions
        getLocations(res, mysql, context, complete);
        getContinents(res, mysql, context, complete);

        function complete() {
            callbackCount++;
            if (callbackCount >= 2) {  //adding more get functions increase this number!!
                res.render('locations', context);
            }
        }
    });

    router.post('/', (req,res)=>{
        console.log(req.body);
        let mysql = req.app.get('mysql');
        let sql = 'INSERT into got_locations (name, region, continent_id) VALUES (?,?,?)';
        let inserts = [req.body.name, req.body.region, req.body.continent_id];
        sql = mysql.pool.query(sql, inserts, (err,results,fields)=>{
            if(err){
                console.log(err);
                res.write(err);
                res.end();
            }
            else{
                res.redirect('/locations');
            }
        })
    })
    // populate locations form in the Edit button
    function getLocations(res, mysql, context, complete) {
        let queryString = 'select l.id, l.name as name, region, c.name as continent from got_locations l' 
            + ' left join got_continents c on c.id = l.continent_id';

        mysql.pool.query(queryString, (err, results, fields) => {
            if (err) {
                res.write(JSON.stringify(err));
                res.end();
            }
            context.locations = results;
            complete();
        })
    }

    // get continent id, names from got_continents for the forms
    function getContinents(res, mysql, context, complete){
        let queryString = 'select id, name from got_continents';

        mysql.pool.query(queryString, function(err, results, fields){
            if (err){
                res.write(JSON.stringify(err));
                res.end();
            }

            context.continents = results;
            complete();
        })

    }

    return router;
}();


