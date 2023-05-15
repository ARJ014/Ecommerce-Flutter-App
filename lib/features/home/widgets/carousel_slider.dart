import 'package:amazon_clone/constants/golabal_variables.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class CrouselSlider extends StatelessWidget {
  const CrouselSlider({super.key});

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      items: GlobalVariables.carouselImages.map((e) {
        return Builder(
            builder: ((context) => Image.network(
                  e,
                  fit: BoxFit.cover,
                  height: 200,
                )));
      }).toList(),
      options: CarouselOptions(height: 200, viewportFraction: 1),
    );
  }
}
