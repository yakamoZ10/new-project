const express = require('express');
const app = express();

app.get('/', (req, res) => {
  res.send('Hello from the Nana DevOps App running on ECS!');
});

app.listen(3000, () => console.log('App running on port 3000'));
