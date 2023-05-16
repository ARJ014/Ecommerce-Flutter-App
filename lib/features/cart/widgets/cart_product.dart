// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:amazon_clone/features/cart/services/cart_servicrs.dart';
import 'package:amazon_clone/features/product_details/services/product_detail_services.dart';
import 'package:amazon_clone/models/proudct.dart';
import 'package:amazon_clone/provider/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../constants/golabal_variables.dart';

class CartProduct extends StatefulWidget {
  final int index;
  const CartProduct({
    Key? key,
    required this.index,
  }) : super(key: key);

  @override
  State<CartProduct> createState() => _CartProductState();
}

class _CartProductState extends State<CartProduct> {
  final ProductDetailServices productDetailServices = ProductDetailServices();
  final CartServices cartServices = CartServices();

  void increaseProductQuantity(Product product) {
    productDetailServices.addToCart(context: context, product: product);
  }

  void decreaseProductQuantity(Product product) {
    cartServices.removeFromCart(context: context, product: product);
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size.width;
    final productFromCart =
        Provider.of<UserProvider>(context).user.cart[widget.index];
    final product = Product.fromMap(productFromCart["product"]);
    final quantity = productFromCart["quantity"];

    return Column(
      children: [
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 10),
          child: Row(children: [
            Image.network(
              product.images[0],
              fit: BoxFit.contain,
              height: size / 3,
              width: size / 3,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 15),
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    width: 1.5 * size / 3,
                    child: Text(
                      product.name,
                      maxLines: 2,
                      style: const TextStyle(fontSize: 16),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.only(left: 10, top: 5),
                    width: 1.5 * size / 3,
                    child: Text(
                      "$Rs${product.price}",
                      style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.red),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.only(left: 10, top: 5),
                    width: 1.5 * size / 3,
                    child: const Text(
                      "Eligible for Free shipping",
                      maxLines: 2,
                      style: TextStyle(),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.only(left: 10, top: 5),
                    width: 1.5 * size / 3,
                    child: const Text(
                      "In Stock",
                      maxLines: 2,
                      style: TextStyle(color: Colors.teal),
                    ),
                  ),
                ],
              ),
            )
          ]),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Row(
            children: [
              Container(
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.black12, width: 1.5),
                    borderRadius: BorderRadius.circular(5),
                    color: Colors.black12),
                child: Row(
                  children: [
                    InkWell(
                      onTap: () => decreaseProductQuantity(product),
                      child: Container(
                        height: 32,
                        width: 35,
                        alignment: Alignment.center,
                        child: const Icon(
                          Icons.remove,
                          size: 18,
                        ),
                      ),
                    ),
                    DecoratedBox(
                      decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.black12,
                            width: 1.5,
                          ),
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(0)),
                      child: Container(
                          height: 32,
                          width: 35,
                          alignment: Alignment.center,
                          child: Text(quantity.toString())),
                    ),
                    InkWell(
                      onTap: () => increaseProductQuantity(product),
                      child: Container(
                        height: 32,
                        width: 35,
                        alignment: Alignment.center,
                        child: const Icon(
                          Icons.add,
                          size: 18,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}
