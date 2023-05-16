import 'dart:convert';

import 'package:amazon_clone/constants/golabal_variables.dart';
import 'package:amazon_clone/models/proudct.dart';
import 'package:amazon_clone/models/user.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import '../../../constants/error_handling.dart';
import '../../../constants/utils.dart';
import '../../../provider/user_provider.dart';

class CartServices {
  void removeFromCart(
      {required BuildContext context, required Product product}) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false).user;
    try {
      print(product.id);
      http.Response res = await http.delete(
        Uri.parse("$uri/api/remove-from-cart/${product.id}"),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': userProvider.token
        },
      );
      httpErrorHandler(
          res: res,
          context: context,
          onsuccess: () {
            User user =
                userProvider.copyWith(cart: jsonDecode(res.body)['cart']);
            Provider.of<UserProvider>(context, listen: false)
                .setUserFromModel(user);
          });
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }
}
