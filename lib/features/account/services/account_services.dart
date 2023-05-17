import 'dart:convert';

import 'package:amazon_clone/constants/error_handling.dart';
import 'package:amazon_clone/constants/golabal_variables.dart';
import 'package:amazon_clone/models/order.dart';
import 'package:provider/provider.dart';
import '../../../constants/utils.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import '../../../provider/user_provider.dart';

class AccountServices {
  Future<List<Order>> fetchOrders({required BuildContext context}) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false).user;
    List<Order> orders = [];
    try {
      http.Response res = await http.get(
        Uri.parse("$uri/api/fetch-all-orders"),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': userProvider.token
        },
      );
      httpErrorHandler(
        res: res,
        context: context,
        onsuccess: () {
          for (int i = 0; i < jsonDecode(res.body).length; i++) {
            orders.add(
              Order.fromJson(
                jsonEncode(
                  jsonDecode(res.body)[i],
                ),
              ),
            );
          }
        },
      );
    } catch (e) {
      showSnackBar(context, e.toString());
    }
    return orders;
  }
}
