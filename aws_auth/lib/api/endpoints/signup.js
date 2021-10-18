app.post('/signup', express.urlencoded(), function(req, res) {
    // in a production environment you would ideally add salt and store that in the database as well
    // or even use bcrypt instead of sha256. No need for external libs with sha256 though
    var password = crypto.createHash('sha256').update(req.body.password).digest('hex');
    db.get("SELECT FROM users WHERE username = ?", [req.body.username], function(err, row) {
      if(row != undefined ) {
        console.error("can't create user " + req.body.username);
        res.status(409);
        res.send("An user with that username already exists");
      } else {
        console.log("Can create user " + req.body.username);
        db.run('INSERT INTO users(username, password) VALUES (?, ?)', [req.body.username, password]);
        res.status(201);
        res.send("Success");
      }
    });
  });