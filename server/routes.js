const express = require("express");
const userModel = require("./model");
const app = express();
app.use(express.json());

app.post("/api/add_user", async (request, response) => {
    console.log(request.body);
    const name=await userModel.findOne({name:request.body["name"]})
    if(name){
        return  response.status(400).send({"message":"Already user exits with same name"});
    }
    const user = new userModel(request.body);
    console.log(response.body)
    try {
      await user.save();
      response.send(user);
    } catch (error) {
      response.status(500).send(error);
    }
});

app.get("/api/get_all_users", async (request, response) => {
    const users = await userModel.aggregate([
        {
            "$project":{name:1,age:1}
        }
    ]);
  
    try {
      response.send({
          "all_users":users
      });
    } catch (error) {
      response.status(500).send(error);
    }
  });


  app.post("/api/change_name", async (request, response) => {

    const data=request.body;

    const users = await userModel.updateOne({_id:data['_id']},
    {
        name:data["name"]
    }
    ).then(()=>{
        response.status(200).send({"message":"success"});
    });

  });

  app.post("/api/delete_user", async (request, response) => {

    const data=request.body;

    const users = await userModel.deleteOne({_id:data['_id']},).then(()=>{
        response.status(200).send({"message":"Deleted successfully"});
    });

  });

  module.exports = app;

 