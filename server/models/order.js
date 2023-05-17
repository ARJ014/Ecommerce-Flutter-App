const mongoose = require("mongoose");
const { productSchmea } = require("./product");

const orderSchema = mongoose.Schema({
  totalPrice: {
    type: Number,
    required: true,
  },
  address: {
    type: String,
    required: true,
  },
  userId: {
    type: String,
    required: true,
  },
  orderedAt: {
    type: Number,
    required: true,
  },
  products: [
    {
      product: productSchmea,
      quantity: {
        type: Number,
        required: true,
      },
    },
  ],
  status: {
    type: Number,
    default: 0,
  },
});

const Order = mongoose.model("Order", orderSchema);
module.exports = Order;
