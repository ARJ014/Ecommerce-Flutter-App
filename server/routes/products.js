const express = require("express");
const productRouter = express.Router();
const Products = require("../models/product");
const auth = require("../middleware/auth");

productRouter.get("/api/products", auth, async (req, res) => {
  try {
    const products = await Products.find({ category: req.query.category });
    res.json(products);
  } catch (e) {
    res.status(500).json({ error: e.message });
  }
});

productRouter.get("/api/products/search/:name", auth, async (req, res) => {
  try {
    const products = await Products.find({
      name: { $regex: req.params.name, $options: "i" },
    });
    res.json(products);
  } catch (e) {
    res.status(500).json({ error: e.message });
  }
});

module.exports = productRouter;
