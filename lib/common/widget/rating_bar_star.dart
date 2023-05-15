// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:amazon_clone/constants/golabal_variables.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class RatingBar extends StatelessWidget {
  final double rating;
  const RatingBar({
    Key? key,
    required this.rating,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RatingBarIndicator(
        direction: Axis.horizontal,
        itemCount: 5,
        itemSize: 15,
        rating: rating,
        itemBuilder: ((context, index) => const Icon(
              Icons.star,
              color: GlobalVariables.secondaryColor,
            )));
  }
}
