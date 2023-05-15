import 'package:flutter/material.dart';

class Deal extends StatefulWidget {
  const Deal({super.key});

  @override
  State<Deal> createState() => _DealState();
}

class _DealState extends State<Deal> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          alignment: Alignment.topLeft,
          padding: const EdgeInsets.only(top: 15, left: 10),
          child: const Text(
            "Deal of the Day",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
          ),
        ),
        Image.network(
          'https://images.unsplash.com/photo-1682685794761-c8e7b2347702?ixlib=rb-4.0.3&ixid=MnwxMjA3fDF8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1170&q=80',
          fit: BoxFit.fitHeight,
          height: 235,
        ),
        Container(
          alignment: Alignment.topLeft,
          padding: const EdgeInsets.only(left: 15),
          child: const Text(
            "₹ 100",
            style: TextStyle(fontSize: 18),
          ),
        ),
        Container(
          alignment: Alignment.topLeft,
          padding: const EdgeInsets.only(left: 15, top: 5, right: 30),
          child: const Text(
            "Product Decsription ",
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: const [],
          ),
        ),
        Container(
          alignment: Alignment.topLeft,
          padding: const EdgeInsets.only(top: 15, left: 10),
          child: Text(
            "See all deals",
            style: TextStyle(color: Colors.cyan[800]),
          ),
        )
      ],
    );
  }
}
