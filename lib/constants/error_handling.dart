import 'dart:convert';

import 'package:amazon_clone/constants/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

void httpErrorHandler({
  required http.Response res,
  required BuildContext context,
  required VoidCallback onsuccess,
}) {
  switch (res.statusCode) {
    case 200:
      onsuccess();
      break;

    case 400:
      showSnackBar(context, jsonDecode(res.body)['msg']);
      break;

    case 500:
      showSnackBar(context, jsonDecode(res.body)['error']);
      break;

    default:
      showSnackBar(context, jsonDecode(res.body));
  }
}
