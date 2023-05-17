import 'package:amazon_clone/common/widget/bottom_bar.dart';
import 'package:amazon_clone/features/address/address_screen.dart';
import 'package:amazon_clone/features/admin/screens/add_products.dart';
import 'package:amazon_clone/features/auth/screens/auth_screen.dart';
import 'package:amazon_clone/features/cart/screens/cart.dart';
import 'package:amazon_clone/features/home/home_screen.dart';
import 'package:amazon_clone/features/home/screens/category_screens.dart';
import 'package:amazon_clone/features/order_detail/screens/order_detail_screen.dart';
import 'package:amazon_clone/features/product_details/screens/product_detail_screen.dart';
import 'package:amazon_clone/features/search/screen/search_screen.dart';
import 'package:amazon_clone/models/order.dart';
import 'package:amazon_clone/models/proudct.dart';
import 'package:flutter/material.dart';

Route<dynamic> generateRoute(RouteSettings routesettings) {
  switch (routesettings.name) {
    case AuthScreen.name:
      return MaterialPageRoute(
          settings: routesettings, builder: ((context) => const AuthScreen()));

    case HomeScreem.routeName:
      return MaterialPageRoute(
          settings: routesettings, builder: ((context) => const HomeScreem()));

    case BottomBar.name:
      return MaterialPageRoute(
          settings: routesettings, builder: ((context) => const BottomBar()));

    case AddProductsScreen.name:
      return MaterialPageRoute(
          settings: routesettings,
          builder: ((context) => const AddProductsScreen()));

    case CategoryScreen.name:
      var category = routesettings.arguments as String;
      return MaterialPageRoute(
          settings: routesettings,
          builder: ((context) => CategoryScreen(category: category)));

    case SearchScreen.name:
      var productName = routesettings.arguments as String;
      return MaterialPageRoute(
          settings: routesettings,
          builder: ((context) => SearchScreen(searchQuery: productName)));

    case ProudctDetailsScreen.name:
      var product = routesettings.arguments as Product;
      return MaterialPageRoute(
          settings: routesettings,
          builder: ((context) => ProudctDetailsScreen(product: product)));

    case CartScreen.name:
      return MaterialPageRoute(builder: ((context) => const CartScreen()));

    case AddressScreen.name:
      var totalAmount = routesettings.arguments as String;
      return MaterialPageRoute(
          builder: ((context) => AddressScreen(totalAmount: totalAmount)));

    case OrderDetailScreen.name:
      var order = routesettings.arguments as Order;
      return MaterialPageRoute(
          builder: ((context) => OrderDetailScreen(order: order)));

    default:
      return MaterialPageRoute(
          builder: ((context) => const Scaffold(
                body: Center(
                  child: Text("This the error page"),
                ),
              )));
  }
}
