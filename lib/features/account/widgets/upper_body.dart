import 'package:amazon_clone/features/account/widgets/accounts_button.dart';
import 'package:flutter/material.dart';

class UpperBody extends StatefulWidget {
  const UpperBody({super.key});

  @override
  State<UpperBody> createState() => _UpperBodyState();
}

class _UpperBodyState extends State<UpperBody> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            AccountButton(text: "Your Orders", onTap: () {}),
            AccountButton(text: "Turn Seller", onTap: () {}),
          ],
        ),
        const SizedBox(
          height: 10,
        ),
        Row(
          children: [
            AccountButton(text: "Log Out", onTap: () {}),
            AccountButton(text: "Your Wishlist", onTap: () {}),
          ],
        ),
      ],
    );
  }
}
