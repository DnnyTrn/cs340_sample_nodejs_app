
module.exports = function () {
	var express = require('express');
    var router = express.Router();



    // code goes here 
	    //populates the house table for /houses
    function getHouses(res, mysql, context, complete){
        let queryString = 'SELECT h.id as house_id, name as house_name, sigil, c.fname, c.lname , hs.status as status_id FROM got_house h'
        + ' left join got_characters c on c.id = h.head'
        + ' left join got_house_status hs on hs.id = h.status_id';
        mysql.pool.query("queryString", function(error, results, fields){

            if(error){
                res.write(JSON.stringify(error));
                res.end();
            }
            context.house  = results;
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


    function getHouseStatus(res, mysql, context, complete){
        let queryString = 'SELECT id as status_id, status from got_house_status';
        mysql.pool.query(queryString, (err, results, fields)=>{
            if(err){
                res.write(JSON.stringify(err));
                res.end();
            }
            context.locations = results;
            complete();
        })
    }




    /*Display all houses. Requires web based javascript to delete users with AJAX*/

    router.get('/', function(req, res){
        console.log('get/')
        var callbackCount = 0;
        var context = {};
        context.jsscripts = ["deleteGOT.js"];
        var mysql = req.app.get('mysql');

        getHouses(res, mysql, context, complete);
        getCharacters(res, mysql, context, complete);
        getHouseStatus(res, mysql, context, complete);

        function complete(){
            callbackCount++;
            if(callbackCount >= 3){
                res.render('houses', context);
            }

        }
    });

    router.post('/', function (req, res) {
        console.log('/post')
        console.log(req.body)
        var mysql = req.app.get('mysql');
        var sql = 'INSERT INTO got_house (name, sigil, head, status_id) VALUES (?,?,?,?)';
        var inserts = [req.body.name, req.body.sigil, req.body.head, req.body.status_id];

        convertEmptyStringToNull(inserts);

        sql = mysql.pool.query(sql, inserts, function(error, results, field){
            if (error) {
                console.log(error)
                res.write(JSON.stringify(error));
                res.end();
            }
            else{
                res.redirect('/houses');
            }
        })
    });

    // returns true if string length is 0
    String.prototype.isEmpty = function () {
        return (this.length === 0 || !this.trim());
    };

    // changes empty strings to value of null
    function convertEmptyStringToNull(inserts){
        inserts.forEach((element, index)=>{
            if(element.isEmpty()){
                inserts[index] = null;
            }

            // if user puts in a bunch of white spaces for the name set fname so app doesn't crash
            if (inserts[0] === null) {
                inserts[0] = 'missing required field';
            }
        });

    return router;
}();
