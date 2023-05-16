// ignore_for_file: use_build_context_synchronously

import 'dart:convert';

import 'package:amazon_clone/common/widget/bottom_bar.dart';
import 'package:amazon_clone/constants/error_handling.dart';
import 'package:amazon_clone/constants/golabal_variables.dart';
import 'package:amazon_clone/constants/utils.dart';
import 'package:amazon_clone/models/user.dart';
import 'package:amazon_clone/provider/user_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class authService {
  void signUpUser(
      {required String name,
      required String email,
      required String password,
      required BuildContext context}) async {
    try {
      User user = User(
          name: name,
          id: '',
          email: email,
          password: password,
          token: '',
          type: '',
          address: '',
          cart: []);

      // print(user.toJson());
      http.Response res = await http.post(Uri.parse("$uri/api/signup"),
          body: user.toJson(),
          headers: <String, String>{
            'Content-Type': 'application/json;charset=UTF-8',
          });
      httpErrorHandler(
          res: res,
          context: context,
          onsuccess: (() => showSnackBar(
              context, "Account created\n Login with same credentials")));
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  void signInUser(
      {required String email,
      required String password,
      required BuildContext context}) async {
    try {
      // print(user.toJson());
      http.Response res = await http.post(Uri.parse("$uri/api/signin"),
          body: jsonEncode({
            "email": email,
            "password": password,
          }),
          headers: <String, String>{
            'Content-Type': 'application/json;charset=UTF-8',
          });
      httpErrorHandler(
          res: res,
          context: context,
          onsuccess: () async {
            SharedPreferences pref = await SharedPreferences.getInstance();
            Provider.of<UserProvider>(context, listen: false).setUser(res.body);
            await pref.setString('x-auth-token', jsonDecode(res.body)['token']);
            Navigator.pushNamedAndRemoveUntil(
                context, BottomBar.name, (route) => false);
          });
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  void getUserData(BuildContext context) async {
    try {
      SharedPreferences pref = await SharedPreferences.getInstance();
      String? token = pref.getString('x-auth-token');

      if (token == null) {
        pref.setString('x-auth-token', "");
      }
      var res = await http.post(Uri.parse("$uri/tokenIsValid"),
          headers: <String, String>{
            'Content-Type': 'application/json;charset=UTF-8',
            'x-auth-token': token!
          });

      var response = jsonDecode(res.body);
      if (response) {
        var userRes =
            await http.get(Uri.parse("$uri/"), headers: <String, String>{
          'Content-Type': 'application/json;charset=UTF-8',
          'x-auth-token': token,
        });

        var userProvider = Provider.of<UserProvider>(context, listen: false);
        userProvider.setUser(userRes.body);
      }
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }
}
