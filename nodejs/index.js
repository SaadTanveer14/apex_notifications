const express = require('express');
const app = express();
const port = 3000;

app.get('/notifications', (req, res) => {
  const responseData = { message: 'Hello from the server!' };
  res.json(responseData);
});

app.listen(port, () => {
  console.log(`Server is listening at http://192.168.100.13:${port}`);
});