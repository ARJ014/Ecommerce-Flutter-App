// From other files
const express = require("express");
const mongoose = require("mongoose");

const authRouter = require("./routes/auth");
const adminRouter = require("./routes/admin");
const productRouter = require("./routes/products");
//INIT
const app = express();

const PORT = 3000;
const DB =
  "mongodb+srv://arjungoel:Arjun014@cluster0.wknx3a1.mongodb.net/?retryWrites=true&w=majority";

//middleware
app.use(express.json());
app.use(authRouter);
app.use(adminRouter);
app.use(productRouter);

//connections
mongoose
  .connect(DB)
  .then(() => {
    console.log("Done");
  })
  .catch((e) => {
    console.log(e);
  });

app.listen(PORT, () => {
  console.log(`Listeing on port ${PORT} right now`);
});
