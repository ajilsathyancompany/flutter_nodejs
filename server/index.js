const express=require('express');
const mongoose = require("mongoose");
const Router = require("./routes")

const app = express()

app.use(express())
app.use(Router);

const port = 8080



app.get('/', (req, res) => {
  res.send("<h1>Hello World!</h1>")
})

app.get('/api/admin', (req, res) => {
  res.json({"name":"Ajil Sathyan"})   
}) 

app.listen(port, () => {
  console.log(`Example app listening on port ${port}`)
})

const mongodbUrl="mongodb+srv://ajilsathyan:ajilsathyan%4012345678@cluster0.1ork4.mongodb.net/MY_DB?retryWrites=true&w=majority";

mongoose.connect(mongodbUrl,);

const db = mongoose.connection;
db.once("open", function () {
  console.log("Connected successfully");
});