import 'package:amazon_clone/common/widget/loader.dart';
import 'package:amazon_clone/features/home/services/home_services.dart';
import 'package:amazon_clone/features/product_details/screens/product_detail_screen.dart';
import 'package:amazon_clone/models/proudct.dart';
import 'package:flutter/material.dart';

class Deal extends StatefulWidget {
  const Deal({super.key});

  @override
  State<Deal> createState() => _DealState();
}

class _DealState extends State<Deal> {
  final HomeServices homeServices = HomeServices();
  Product? product;
  @override
  void initState() {
    super.initState();
    fetchDealOfTheDay();
  }

  fetchDealOfTheDay() async {
    product = await homeServices.dealOfTheDay(context);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return product == null
        ? const LoaderIndicator()
        : product!.name.isEmpty
            ? (const SizedBox(height: 10))
            : GestureDetector(
                onTap: () => Navigator.pushNamed(
                    context, ProudctDetailsScreen.name,
                    arguments: product),
                child: Column(
                  children: [
                    Container(
                      alignment: Alignment.topLeft,
                      padding: const EdgeInsets.only(top: 15, left: 10),
                      child: const Text(
                        "Deal of the Day",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w600),
                      ),
                    ),
                    Image.network(
                      product!.images[0],
                      fit: BoxFit.fitHeight,
                      height: 235,
                    ),
                    Container(
                      alignment: Alignment.topLeft,
                      padding: const EdgeInsets.only(left: 15),
                      child: const Text(
                        "₹100",
                        style: TextStyle(fontSize: 22, color: Colors.red),
                      ),
                    ),
                    Container(
                      alignment: Alignment.topLeft,
                      padding:
                          const EdgeInsets.only(left: 15, top: 5, right: 30),
                      child: Text(
                        product!.name,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: product!.images
                            .map((e) => Padding(
                                  padding: const EdgeInsets.only(right: 15),
                                  child: Image.network(
                                    e,
                                    fit: BoxFit.cover,
                                    height: 100,
                                    width: 100,
                                  ),
                                ))
                            .toList(),
                      ),
                    ),
                    Container(
                      alignment: Alignment.topLeft,
                      padding: const EdgeInsets.only(top: 15, left: 10),
                      child: Text(
                        "See all deals",
                        style: TextStyle(color: Colors.cyan[800]),
                      ),
                    )
                  ],
                ),
              );
  }
}
