var mysql = require('mysql');
var pool = mysql.createPool({
  connectionLimit : 10,
  host            : 'classmysql.engr.oregonstate.edu',
  user            : 'cs340_trandan',
  password        : '2023',
  database        : 'cs340_trandan'
});
module.exports.pool = pool;
