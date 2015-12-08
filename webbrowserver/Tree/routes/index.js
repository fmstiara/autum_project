var express = require('express');
var router = express.Router();

/*
id
message
date
brunchNumber
*/


/* GET home page. */
router.get('/', function(req, res, next) {
  res.render('index', {
    title: 'プロトタイプ',
  });
});

module.exports = router;
