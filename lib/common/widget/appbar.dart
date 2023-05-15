import 'package:flutter/material.dart';

import '../../constants/golabal_variables.dart';

class AppBarConst extends StatelessWidget {
  const AppBarConst({super.key});

  @override
  Widget build(BuildContext context) {
    return PreferredSize(
      preferredSize: const Size.fromHeight(50),
      child: AppBar(
        elevation: 0,
        flexibleSpace: Container(
          decoration:
              const BoxDecoration(gradient: GlobalVariables.appBarGradient),
        ),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              padding: const EdgeInsets.only(top: 8),
              alignment: Alignment.topLeft,
              height: 45,
              width: 120,
              child: Image.asset("assets/images/amazon_in.png"),
            ),
            const Text(
              "Admin",
              style:
                  TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
