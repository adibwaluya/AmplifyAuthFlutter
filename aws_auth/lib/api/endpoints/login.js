app.post('/login', express.urlencoded(), function(req, res) {
    console.log(req.body.username + " attempted login");
    var password = crypto.createHash('sha256').update(req.body.password).digest('hex');
    db.get("SELECT * FROM users WHERE (username, password) = (?, ?)", [req.body.username, password], function(err, row) {
      if(row != undefined ) {
        var payload = {
          username: req.body.username,
        };
  
        var token = jwt.sign(payload, KEY, {algorithm: 'HS256', expiresIn: "15d"});
        console.log("Success");
        res.send(token);
      } else {
        console.error("Failure");
        res.status(401)
        res.send("There's no user matching that");
      }
    });
  });