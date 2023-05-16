import 'package:amazon_clone/constants/golabal_variables.dart';
import 'package:amazon_clone/features/account/screens/accounts_screen.dart';
import 'package:amazon_clone/features/cart/screens/cart.dart';
import 'package:amazon_clone/features/home/home_screen.dart';
import 'package:amazon_clone/provider/user_provider.dart';
import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BottomBar extends StatefulWidget {
  static const String name = "/real-home";
  const BottomBar({super.key});

  @override
  State<BottomBar> createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  int _page = 0;
  double botttomBarWidth = 42;
  double bottomBorderWidth = 5;

  List<Widget> pages = [
    const HomeScreem(),
    const AccountsScreen(),
    const CartScreen(),
  ];

  void updatePage(int page) {
    setState(() {
      _page = page;
    });
  }

  @override
  Widget build(BuildContext context) {
    final userCartLen = Provider.of<UserProvider>(context).user.cart.length;
    return Scaffold(
      body: pages[_page],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _page,
        backgroundColor: GlobalVariables.backgroundColor,
        selectedItemColor: GlobalVariables.selectedNavBarColor,
        unselectedItemColor: GlobalVariables.unselectedNavBarColor,
        iconSize: 28,
        onTap: updatePage,
        items: [
          BottomNavigationBarItem(
            label: "",
            icon: Container(
              width: botttomBarWidth,
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(
                      width: bottomBorderWidth,
                      color: _page == 0
                          ? GlobalVariables.selectedNavBarColor
                          : GlobalVariables.backgroundColor),
                ),
              ),
              child: const Icon(Icons.home_outlined),
            ),
          ),
          BottomNavigationBarItem(
            label: "",
            icon: Container(
              width: botttomBarWidth,
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(
                      width: bottomBorderWidth,
                      color: _page == 1
                          ? GlobalVariables.selectedNavBarColor
                          : GlobalVariables.backgroundColor),
                ),
              ),
              child: const Icon(Icons.person_outline_outlined),
            ),
          ),
          BottomNavigationBarItem(
            label: "",
            icon: Container(
              width: botttomBarWidth,
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(
                      width: bottomBorderWidth,
                      color: _page == 2
                          ? GlobalVariables.selectedNavBarColor
                          : GlobalVariables.backgroundColor),
                ),
              ),
              child: Badge(
                  position: BadgePosition.topEnd(top: -10, end: -2),
                  showBadge: true,
                  ignorePointer: false,
                  badgeContent: Text("$userCartLen"),
                  badgeStyle:
                      const BadgeStyle(elevation: 0, badgeColor: Colors.white),
                  child: const Icon(Icons.shopping_cart_outlined)),
            ),
          )
        ],
      ),
    );
  }
}
