import 'package:amazon_clone/common/widget/loader.dart';
import 'package:amazon_clone/features/account/widgets/single_product.dart';
import 'package:amazon_clone/features/admin/service/admin_services.dart';
import 'package:amazon_clone/features/order_detail/screens/order_detail_screen.dart';
import 'package:flutter/material.dart';

import '../../../models/order.dart';

class AdminOrdersScreen extends StatefulWidget {
  const AdminOrdersScreen({super.key});

  @override
  State<AdminOrdersScreen> createState() => _AdminOrdersScreenState();
}

class _AdminOrdersScreenState extends State<AdminOrdersScreen> {
  List<Order>? orderList;
  final AdminServices adminServices = AdminServices();
  @override
  void initState() {
    super.initState();
    getAllOrders();
  }

  void getAllOrders() async {
    orderList = await adminServices.fetchAllOrders(context);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return orderList == null
        ? const LoaderIndicator()
        : GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
            ),
            itemCount: orderList!.length,
            itemBuilder: (BuildContext context, int index) {
              final orderData = orderList![index];
              return GestureDetector(
                onTap: () => Navigator.pushNamed(
                    context, OrderDetailScreen.name,
                    arguments: orderData),
                child: SizedBox(
                  height: 140,
                  child: SingleProduct(image: orderData.products[0].images[0]),
                ),
              );
            },
          );
  }
}
