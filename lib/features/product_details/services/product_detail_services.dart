import 'dart:convert';

import 'package:amazon_clone/constants/golabal_variables.dart';
import 'package:amazon_clone/models/proudct.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import '../../../constants/error_handling.dart';
import '../../../constants/utils.dart';
import '../../../provider/user_provider.dart';

class ProductDetailServices {
  void rateProduct({
    required BuildContext context,
    required Product product,
    required double rating,
  }) async {
    final user = Provider.of<UserProvider>(context, listen: false).user;
    try {
      http.Response res = await http.post(Uri.parse("$uri/api/rateProduct"),
          headers: {
            'Content-Type': 'application/json; charset=UTF-8',
            'x-auth-token': user.token
          },
          body: jsonEncode({'id': product.id, 'ratings': rating}));
      httpErrorHandler(res: res, context: context, onsuccess: () {});
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }
}
