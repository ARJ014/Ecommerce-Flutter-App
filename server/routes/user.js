const express = require("express");
const userRouter = express.Router();
const auth = require("../middleware/auth");
const { Products } = require("../models/product");
const User = require("../models/user");
const Order = require("../models/order");

userRouter.post("/api/add-to-cart", auth, async (req, res) => {
  5;
  try {
    const { id } = req.body;
    const product = await Products.findById(id);
    let user = await User.findById(req.user);
    if (user.cart.length == 0) {
      user.cart.push({ product, quantity: 1 });
    } else {
      let productFound = false;
      for (let i = 0; i < user.cart.length; i++) {
        if (user.cart[i].product._id.equals(product._id)) {
          productFound = true;
          break;
        }
      }
      if (productFound) {
        let productCart = user.cart.find((productt) =>
          productt.product._id.equals(product._id)
        );
        productCart.quantity += 1;
      } else {
        user.cart.push({ product, quantity: 1 });
      }
    }
    user = await user.save();
    res.json(user);
  } catch (e) {
    res.status(500).json({ error: e.message });
  }
});

userRouter.delete("/api/remove-from-cart/:id", auth, async (req, res) => {
  try {
    const id = req.params.id;
    const product = await Products.findById(id);
    let user = await User.findById(req.user);
    for (let i = 0; i < user.cart.length; i++) {
      if (user.cart[i].product._id.equals(product._id)) {
        if (user.cart[i].quantity == 1) {
          user.cart.splice(i, 1);
        } else {
          user.cart[i].quantity -= 1;
        }
      }
    }
    user = await user.save();
    res.json(user);
  } catch (e) {
    res.status(500).json({ error: e.message });
  }
});

userRouter.post("/api/add-address", auth, async (req, res) => {
  try {
    const { address } = req.body;
    let user = await User.findById(req.user);

    user.address = address;
    user = await user.save();
    res.json(user);
  } catch (e) {
    res.status(500).json({ error: e.message });
  }
});

userRouter.post("/api/order", auth, async (req, res) => {
  try {
    const { cart, totalPrice, address } = req.body;
    let products = [];
    console.log(cart);
    for (let i = 0; i < cart.length; i++) {
      let product = await Products.findById(cart[i].product._id);
      if (product.quantity >= cart[i].quantity) {
        product.quantity -= cart[i].quantity;
        products.push({ product, quantity: cart[i].quantity });
        await product.save;
      } else {
        return res.status(400).json({ msg: `${product.name} is out of stock` });
      }
    }

    let user = await User.findById(req.user);
    user.cart = [];
    user = await user.save();

    let order = new Order({
      products,
      totalPrice,
      address,
      userId: req.user,
      orderedAt: new Date().getTime(),
    });
    order = await order.save();
    res.json(order);
  } catch (e) {
    res.status(500).json({ error: e.message });
  }
});

userRouter.get("/api/fetch-all-orders", auth, async (req, res) => {
  try {
    const order = await Order.find({ userId: req.user });

    res.json(order);
  } catch (e) {
    res.status(500).json({ error: e.message });
  }
});
module.exports = userRouter;
