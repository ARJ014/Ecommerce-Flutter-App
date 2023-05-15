import 'package:amazon_clone/constants/golabal_variables.dart';
import 'package:amazon_clone/features/home/screens/category_screens.dart';
import 'package:flutter/material.dart';

class TopSlider extends StatelessWidget {
  const TopSlider({super.key});

  void categoryPage(BuildContext context, String category) {
    Navigator.pushNamed(context, CategoryScreen.name, arguments: category);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      color: Colors.white,
      child: ListView.builder(
        itemExtent: 88,
        scrollDirection: Axis.horizontal,
        itemCount: GlobalVariables.categoryImages.length,
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
            onTap: (() => categoryPage(
                context, GlobalVariables.categoryImages[index]['title']!)),
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(50),
                    child: Image.asset(
                      GlobalVariables.categoryImages[index]["image"]!,
                      fit: BoxFit.cover,
                      height: 40,
                      width: 40,
                    ),
                  ),
                ),
                Text(
                  GlobalVariables.categoryImages[index]['title']!,
                  style: const TextStyle(
                      fontSize: 12, fontWeight: FontWeight.w400),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
