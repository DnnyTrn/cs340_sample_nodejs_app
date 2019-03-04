var mysql = require('mysql');
var pool = mysql.createPool({
  connectionLimit : 10,
  host            : 'classmysql.engr.oregonstate.edu',
  user            : 'cs340_wolford',
  password        : '9999',
  database        : 'cs340_wolford'
});
module.exports.pool = pool;
