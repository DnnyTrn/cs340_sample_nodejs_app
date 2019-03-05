module.exports = function () {
    let express = require('express');
    let router = express.Router();

    router.get('/', (req,res)=>{
        console.log('locations get');
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
        console.log('locations post');
        console.log(req.body);
        let mysql = req.app.get('mysql');
        let sql = 'INSERT into got_locations (name, region, continent_id) VALUES (?,?,?)';
        let inserts = [req.body.name, req.body.region, req.body.continent_id];
        convertEmptyStringToNull(inserts);
        sql = mysql.pool.query(sql, inserts, (err,results,fields)=>{
            if(err){
                console.log(err);
                res.write(err);
                res.end();
            }
            else{
                // res.redirect('/locations');
                var callbackCount = 0;
                var context = {};
                getLocations(res, mysql, context, complete);

                function complete() {
                    callbackCount++;
                    if (callbackCount >= 1) {  //adding more get functions increase this number!!
                        res.send(context);
                    }
                }
            }
        })
    })
    // populate locations form in the Edit button
    function getLocations(res, mysql, context, complete) {
        let queryString = 'select l.id, l.name as name, region, c.name as continent from got_locations l' 
            + ' left join got_continents c on c.id = l.continent_id ORDER BY ID DESC';

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
    // * * * * UPDATE function * * * *
    function getALocation(res, mysql, context, id, complete){
        var sql = 'SELECT id, name, region, continent_id FROM got_locations WHERE id =?';
        var inserts = [id];
        mysql.pool.query(sql, inserts, function(err, results, fields){
            if (err){
                res.write(JSON.stringify(err));
                res.end();
            }
            context.location = results[0];
            complete();
        })
    }
    // /* Display one location for the specific purpose of updating people */
    router.get('/:id', function(req, res){
        console.log('router.get :id');
        callbackCount = 0;
        var context = {};
        context.jsscripts = ['selectcontinent.js', 'updatelocation.js'];
        var mysql = req.app.get('mysql');

        getALocation(res, mysql, context, req.params.id, complete);
        getContinents(res, mysql, context, complete);

        function complete(){
            callbackCount++;
            if (callbackCount >= 2) {
                res.render('update-location', context);
            }
        }
    });

    router.put('/:id', function (req, res) {
        var mysql = req.app.get('mysql'); 
        console.log('put/:id');
        console.log(req.body)
        console.log(req.params.id)
        var sql = "UPDATE got_locations SET name = ?, region = ?, continent_id = ? WHERE id = ?";
        var inserts = [
            req.body.name,
            req.body.region,
            req.body.continent_id,
            req.params.id
        ];
        
        convertEmptyStringToNull(inserts);
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

/* Route to delete a person, simply returns a 202 upon success. Ajax will handle this. */

    router.delete('/', (req,res)=>{
        console.log('delete id ');
        console.log(req.body);
        let sql = 'DELETE FROM got_locations where id = ?';
        let inserts = [req.body.id];
        req.app.get('mysql').pool.query(sql,inserts,(err,results,fields)=> {
            if(err){
                res.write(JSON.stringify(err));
                res.status(400);
                res.end();
            }else{
                res.status(202).end();
            }
        })
    })

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

    router.get('/search/:name', (req,res)=>{
        console.log('location req.params.name: ' + req.params.name);
        var callbackCount = 0;
        var context = {};
        var mysql = req.app.get('mysql');

        getLocationsLike(req, res, mysql, context, complete);

        function complete(){
            callbackCount++;
            if(callbackCount >= 1){
                res.send(context);
            }
        }
    })

    function getLocationsLike(req, res, mysql, context, complete){
        let sql = 'select l.id, l.name, region, c.name as continent from got_locations l'
        +' left join got_continents c on c.id = l.continent_id'
        +' where l.name like ' + mysql.pool.escape(req.params.name + '%')
        +' order by l.id DESC';

        mysql.pool.query(sql, (err, results, fields)=>{
            if(err){
                console.log(err);
                res.write(JSON.stringify(err));
                res.end();
            }

            context.locations = results;
            complete();
        })
    }
    return router;
}();


