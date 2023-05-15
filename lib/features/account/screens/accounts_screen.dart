import 'package:amazon_clone/constants/golabal_variables.dart';
import 'package:amazon_clone/features/account/widgets/orders.dart';
import 'package:amazon_clone/features/account/widgets/sub_heading.dart';
import 'package:amazon_clone/features/account/widgets/upper_body.dart';
import 'package:flutter/material.dart';

class AccountsScreen extends StatelessWidget {
  const AccountsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
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
              Container(
                padding: const EdgeInsets.only(left: 15, right: 15),
                child: Row(
                  children: const [
                    Padding(
                      padding: EdgeInsets.only(right: 15),
                      child: Icon(Icons.notifications_outlined),
                    ),
                    Icon(Icons.search_outlined)
                  ],
                ),
              )
            ],
          ),
        ),
      ),
      body: Column(
        children: const [
          SubHeading(),
          SizedBox(height: 10),
          UpperBody(),
          SizedBox(height: 20),
          Orders()
        ],
      ),
    );
  }
}
