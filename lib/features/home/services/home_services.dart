import 'dart:convert';

import 'package:amazon_clone/constants/error_handling.dart';
import 'package:amazon_clone/constants/golabal_variables.dart';
import 'package:amazon_clone/constants/utils.dart';
import 'package:amazon_clone/models/proudct.dart';
import 'package:amazon_clone/provider/user_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

class HomeServices {
  Future<List<Product>> fetchProductsCategory({
    required BuildContext context,
    required String category,
  }) async {
    List<Product> products = [];
    final user = Provider.of<UserProvider>(context, listen: false).user;
    try {
      http.Response res = await http.get(
        Uri.parse("$uri/api/products?category=$category"),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': user.token
        },
      );
      httpErrorHandler(
        res: res,
        context: context,
        onsuccess: () {
          for (int i = 0; i < jsonDecode(res.body).length; i++) {
            products.add(
              Product.fromJson(
                jsonEncode(jsonDecode(res.body)[i]),
              ),
            );
          }
        },
      );
    } catch (e) {
      showSnackBar(context, e.toString());
    }
    return products;
  }
}
