const express = require("express");
const adminRouter = express.Router();
const admin = require("../middleware/admin");
const { Products } = require("../models/product");
const Order = require("../models/order");

adminRouter.post("/admin/addProduct", admin, async (req, res) => {
  try {
    const { images, name, price, quantity, description, category } = req.body;
    let product = new Products({
      images,
      name,
      price,
      description,
      images,
      category,
      quantity,
    });
    product = await product.save();
    res.json(product);
  } catch (e) {
    res.status(500).json({ error: e.message });
  }
});

adminRouter.get("/admin/getProducts", admin, async (req, res) => {
  try {
    const product = await Products.find({});
    res.json(product);
  } catch (e) {
    res.status(500).json({ error: e.message });
  }
});

adminRouter.post("/admin/deleteProudct", admin, async (req, res) => {
  try {
    const { id } = req.body;
    const product = await Products.findByIdAndDelete(id);
    res.json(product);
  } catch (e) {
    res.status(500).json({ error: e.message });
  }
});

adminRouter.get("/admin/getOrders", admin, async (req, res) => {
  try {
    const order = await Order.find({});
  } catch (e) {
    res.status(500).json({ error: e.message });
  }
});

module.exports = adminRouter;
