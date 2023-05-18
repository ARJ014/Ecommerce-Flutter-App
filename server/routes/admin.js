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
    res.json(order);
  } catch (e) {
    res.status(500).json({ error: e.message });
  }
});

adminRouter.post("/admin/change-status", admin, async (req, res) => {
  try {
    const { id, status } = req.body;
    let order = await Order.findById(id);
    order.status = status;

    order = await order.save();
    res.json(order);
  } catch (e) {
    res.status(500).json({ error: e.message });
  }
});

adminRouter.get("/admin/analytics", admin, async (req, res) => {
  try {
    let orders = await Order.find({});
    let totalSum = 0;
    let totalSum1 = 0;
    for (let i = 0; i < orders.length; i++) {
      for (let j = 0; j < orders[i].products.length; j++) {
        totalSum +=
          orders[i].products[j].quantity * orders[i].products[j].product.price;
        totalSum1 += orders[i].totalPrice;
      }
    }

    // CATEGORY WISE ORDER FETCHING
    let mobileEarnings = await fetchCategoryWiseProduct("Mobiles");
    let essentialEarnings = await fetchCategoryWiseProduct("Essentials");
    let applianceEarnings = await fetchCategoryWiseProduct("Appliances");
    let booksEarnings = await fetchCategoryWiseProduct("Books");
    let fashionEarnings = await fetchCategoryWiseProduct("Fashion");

    let total = {
      totalSum,
      mobileEarnings,
      essentialEarnings,
      applianceEarnings,
      booksEarnings,
      fashionEarnings,
    };
    console.log(total);

    res.json(total);
  } catch (e) {
    res.status(500).json({ error: e.message });
  }
});

async function fetchCategoryWiseProduct(category) {
  let earnings = 0;
  let order = await Order.find({ "products.product.category": category });

  for (let i = 0; i < order.length; i++) {
    for (let j = 0; j < order[i].products.length; j++) {
      earnings +=
        order[i].products[j].quantity * order[i].products[j].product.price;
    }
  }
  return earnings;
}

module.exports = adminRouter;
