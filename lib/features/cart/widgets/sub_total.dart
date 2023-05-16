import 'package:amazon_clone/constants/golabal_variables.dart';
import 'package:amazon_clone/provider/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TotalCost extends StatelessWidget {
  const TotalCost({super.key});

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context).user;
    int sum = 0;
    user.cart
        .map((e) => sum += e['quantity'] * e['product']['price'] as int)
        .toList();
    return Container(
      margin: const EdgeInsets.all(10),
      child: Row(children: [
        const Text(
          "SubTotal: ",
          style: TextStyle(fontSize: 20, color: Colors.black87),
        ),
        Text(
          "$Rs$sum",
          style: const TextStyle(
              fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),
        )
      ]),
    );
  }
}
