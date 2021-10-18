app.get('/data', function(req, res) {
    var str = req.get('Authorization');
    try {
      jwt.verify(str, KEY, {algorithm: 'HS256'});
      res.send("Very Secret Data");
    } catch {
      res.status(401);
      res.send("Bad Token");
    }
  
  });