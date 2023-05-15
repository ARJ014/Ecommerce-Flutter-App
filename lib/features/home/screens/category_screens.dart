// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:amazon_clone/common/widget/loader.dart';
import 'package:amazon_clone/features/home/services/home_services.dart';
import 'package:amazon_clone/features/product_details/screens/product_detail_screen.dart';
import 'package:amazon_clone/models/proudct.dart';
import "package:flutter/material.dart";

import '../../../constants/golabal_variables.dart';

class CategoryScreen extends StatefulWidget {
  static const String name = "CategoryScreen";

  final String category;
  const CategoryScreen({
    Key? key,
    required this.category,
  }) : super(key: key);

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  List<Product>? productList;
  final HomeServices homeServices = HomeServices();
  @override
  void initState() {
    super.initState();
    fetchCategoryProducts();
  }

  fetchCategoryProducts() async {
    productList = await homeServices.fetchProductsCategory(
        context: context, category: widget.category);
    setState(() {});
  }

  void productDescriptionScreen(Product product) {
    Navigator.pushNamed(context, ProudctDetailsScreen.name, arguments: product);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(50),
        child: AppBar(
            elevation: 0,
            flexibleSpace: Container(
              decoration:
                  const BoxDecoration(gradient: GlobalVariables.appBarGradient),
            ),
            title: Text(
              widget.category,
              style: const TextStyle(color: Colors.black),
            )),
      ),
      body: productList == null
          ? const LoaderIndicator()
          : Column(
              children: [
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                  alignment: Alignment.topLeft,
                  child: Text(
                    'Keep Shoping for ${widget.category}',
                    style: const TextStyle(fontSize: 20),
                  ),
                ),
                SizedBox(
                  height: 190,
                  child: GridView.builder(
                    padding: const EdgeInsets.only(left: 15),
                    scrollDirection: Axis.horizontal,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 1,
                    ),
                    itemCount: productList!.length,
                    itemBuilder: (BuildContext context, int index) {
                      final product = productList![index];
                      return GestureDetector(
                        onTap: () => productDescriptionScreen(product),
                        child: Column(
                          children: [
                            SizedBox(
                              height: 140,
                              child: DecoratedBox(
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: Colors.black,
                                    width: 0.5,
                                  ),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(10),
                                  child: Image.network(product.images[0]),
                                ),
                              ),
                            ),
                            Container(
                              alignment: Alignment.topLeft,
                              padding: const EdgeInsets.only(
                                  top: 5, left: 0, right: 15),
                              child: Text(
                                product.name,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            Container(
                                alignment: Alignment.center,
                                padding: const EdgeInsets.only(
                                    top: 5, left: 0, right: 15),
                                child: Text(
                                  "$Rs ${product.price}",
                                ))
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
    );
  }
}
