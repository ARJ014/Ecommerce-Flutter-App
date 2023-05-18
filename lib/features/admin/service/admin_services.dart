import 'dart:convert';
import 'dart:io';

import 'package:amazon_clone/constants/error_handling.dart';
import 'package:amazon_clone/constants/golabal_variables.dart';
import 'package:amazon_clone/constants/utils.dart';
import 'package:amazon_clone/features/admin/models/sales.dart';
import 'package:amazon_clone/models/order.dart';
import 'package:amazon_clone/models/proudct.dart';
import 'package:amazon_clone/provider/user_provider.dart';
import 'package:cloudinary_public/cloudinary_public.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class AdminServices {
  void sellProduct({
    required BuildContext context,
    required String name,
    required String description,
    required int price,
    required int quantity,
    required String category,
    required List<File> images,
  }) async {
    final user = Provider.of<UserProvider>(context, listen: false).user;
    try {
      final cloud = CloudinaryPublic('dbnaauk9a', 'fvpbdkwg');

      List<String> imageURL = [];

      for (int i = 0; i < images.length; i++) {
        CloudinaryResponse res = await cloud
            .uploadFile(CloudinaryFile.fromFile(images[i].path, folder: name));
        imageURL.add(res.secureUrl);
      }

      Product product = Product(
        name: name,
        description: description,
        price: price,
        quantity: quantity,
        category: category,
        images: imageURL,
      );

      http.Response res = await http.post(Uri.parse("$uri/admin/addProduct"),
          headers: {
            'Content-Type': 'application/json; charset=UTF-8',
            'x-auth-token': user.token
          },
          body: product.toJson());
      httpErrorHandler(
          res: res,
          context: context,
          onsuccess: () {
            showSnackBar(context, "Product Added succesfully!");
            Navigator.pop(context);
          });
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  Future<List<Product>> fetchAllProducts(BuildContext context) async {
    final user = Provider.of<UserProvider>(context, listen: false).user;
    List<Product> productsList = [];
    try {
      http.Response res = await http.get(
        Uri.parse("$uri/admin/getProducts"),
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
              productsList.add(
                Product.fromJson(
                  jsonEncode(jsonDecode(res.body)[i]),
                ),
              );
            }
          });
    } catch (e) {
      showSnackBar(context, e.toString());
    }
    return productsList;
  }

  void deleteProduct(
      {required BuildContext context,
      required Product product,
      required VoidCallback onSuccess}) async {
    final user = Provider.of<UserProvider>(context, listen: false).user;

    try {
      http.Response res = await http.post(Uri.parse("$uri/admin/deleteProudct"),
          headers: {
            'Content-Type': 'application/json; charset=UTF-8',
            'x-auth-token': user.token
          },
          body: jsonEncode({'id': product.id}));
      httpErrorHandler(
          res: res,
          context: context,
          onsuccess: () {
            onSuccess();
          });
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  Future<List<Order>> fetchAllOrders(BuildContext context) async {
    final user = Provider.of<UserProvider>(context, listen: false).user;
    List<Order> orderList = [];
    try {
      http.Response res = await http.get(
        Uri.parse("$uri/admin/getOrders"),
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
              orderList.add(
                Order.fromJson(
                  jsonEncode(jsonDecode(res.body)[i]),
                ),
              );
            }
          });
    } catch (e) {
      showSnackBar(context, e.toString());
    }
    return orderList;
  }

  void changeOrderStatus(
      {required BuildContext context,
      required int status,
      required Order order,
      required VoidCallback onSuccess}) async {
    final user = Provider.of<UserProvider>(context, listen: false).user;
    try {
      http.Response res = await http.post(Uri.parse("$uri/admin/change-status"),
          headers: {
            'Content-Type': 'application/json; charset=UTF-8',
            'x-auth-token': user.token
          },
          body: jsonEncode({'id': order.id, 'status': status}));

      httpErrorHandler(res: res, context: context, onsuccess: onSuccess);
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  Future<Map<String, dynamic>> showAnalystics(
      {required BuildContext context}) async {
    final user = Provider.of<UserProvider>(context, listen: false).user;
    List<Sales> sales = [];
    int earnings = 0;
    try {
      http.Response res = await http.get(
        Uri.parse("$uri/admin/analytics"),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': user.token
        },
      );
      httpErrorHandler(
          res: res,
          context: context,
          onsuccess: () {
            var response = jsonDecode(res.body);
            earnings = response['totalSum'];
            sales = [
              Sales('Mobiles', response['mobileEarnings']),
              Sales('Essentials', response['essentialEarnings']),
              Sales('Books', response['booksEarnings']),
              Sales('Appliances', response['applianceEarnings']),
              Sales('Fashion', response['fashionEarnings']),
            ];
            print(sales);
          });
    } catch (e) {
      showSnackBar(context, e.toString());
    }
    return {
      'sales': sales,
      'totalEarnings': earnings,
    };
  }
}
