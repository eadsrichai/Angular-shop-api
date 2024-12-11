const express = require('express');
const app = express();
const bodyParser = require("body-parser");
const cors = require("cors");

const userController = require("./controllers/UserController");
const foodTypeController = require("./controllers/FoodTypeController");
const foodSizeController = require("./controllers/FoodSizeController");



app.use(cors());
app.use(bodyParser.json());
app.use(bodyParser.urlencoded({ extended: false }));

app.post("/api/user/signin", (req, res) => userController.signin(req, res));

// 
// FoodType
// 
app.post("/api/foodType/create", (req, res) => foodTypeController.create(req, res));
app.get("/api/foodType/list", (req, res) => foodTypeController.list(req, res));
app.delete("/api/foodType/remove/:id", (req, res) => foodTypeController.remove(req, res));
app.put("/api/foodType/update", (req, res) => foodTypeController.update(req, res));

//
// food size
//
app.get("/api/foodSize/filter/:foodTypeId", (req, res) => foodSizeController.filter(req, res));
app.put("/api/foodSize/update", (req, res) => foodSizeController.update(req, res));
app.delete("/api/foodSize/remove/:id", (req, res) => foodSizeController.remove(req, res));
app.get("/api/foodSize/list", (req, res) => foodSizeController.list(req, res));
app.post("/api/foodSize/create", (req, res) => foodSizeController.create(req, res));



app.listen(3000, () => {
    console.log("API Server Running.....");
});