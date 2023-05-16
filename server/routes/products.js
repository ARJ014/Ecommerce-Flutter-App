const express = require("express");
const productRouter = express.Router();
const { Products } = require("../models/product");
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

productRouter.post("/api/rateProduct", auth, async (req, res) => {
  try {
    const { id, ratings } = req.body;

    let product = await Products.findById(id);
    if (product.ratings.length > 0) {
      for (let i = 0; i < product.ratings.length; i++) {
        if (product.ratings[i].userId == req.user) {
          product.ratings.splice(i, 1);
          break;
        }
      }
    }
    const ratingSchema = { userId: req.user, ratings };
    product.ratings.push(ratingSchema);
    product = await product.save();
    res.json(product);
  } catch (e) {
    res.status(500).json({ error: e.message });
  }
});

productRouter.get("/api/deal-of-the-day", auth, async (req, res) => {
  try {
    let product = await Products.find({});
    product = product.sort((a, b) => {
      let aSum = 0;
      let bSum = 0;
      for (let i = 0; i < a.ratings.length; i++) {
        aSum += a.ratings[i].ratings;
      }
      for (let i = 0; i < b.ratings.length; i++) {
        bSum += b.ratings[i].ratings;
      }
      return aSum < bSum ? 1 : -1;
    });
    res.json(product[0]);
  } catch (e) {
    res.status(500).json({ error: e.message });
  }
});

module.exports = productRouter;
