// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:amazon_clone/common/widget/rating_bar_star.dart';
import 'package:amazon_clone/constants/golabal_variables.dart';
import 'package:flutter/material.dart';

import 'package:amazon_clone/models/proudct.dart';

class SearchedProduct extends StatelessWidget {
  final Product product;
  const SearchedProduct({
    Key? key,
    required this.product,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size.width;

    double totalRating = 0;
    for (int i = 0; i < product.ratings!.length; i++) {
      totalRating += product.ratings![i].ratings;
    }
    double avgRating = 0;
    if (totalRating != 0) {
      avgRating = totalRating / product.ratings!.length;
    }

    return Container(
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
                  child: RatingBar(rating: avgRating)),
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
    );
  }
}
