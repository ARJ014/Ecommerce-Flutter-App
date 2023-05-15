// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:amazon_clone/common/widget/loader.dart';
import 'package:amazon_clone/features/home/widgets/address_box.dart';
import 'package:amazon_clone/features/product_details/screens/product_detail_screen.dart';
import 'package:amazon_clone/features/search/service/search_services.dart';
import 'package:amazon_clone/features/search/widgets/searched_products_template.dart';
import 'package:amazon_clone/models/proudct.dart';
import 'package:flutter/material.dart';

import '../../../constants/golabal_variables.dart';

class SearchScreen extends StatefulWidget {
  static const String name = "SearchScreen";
  final String searchQuery;
  const SearchScreen({
    Key? key,
    required this.searchQuery,
  }) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  List<Product>? products;
  final SearchServices searchServices = SearchServices();
  final fieldText = TextEditingController();
  void navigateToSearch(String value) {
    Navigator.pushNamed(context, SearchScreen.name, arguments: value);
  }

  @override
  void initState() {
    super.initState();
    fetchSearchQuery();
  }

  void fetchSearchQuery() async {
    products = await searchServices.getSearchProduct(
        context: context, searchQuery: widget.searchQuery);
    setState(() {});
  }

  void clearText() {
    fieldText.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(60),
          child: AppBar(
            elevation: 0,
            flexibleSpace: Container(
              decoration:
                  const BoxDecoration(gradient: GlobalVariables.appBarGradient),
            ),
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Container(
                    margin: const EdgeInsets.only(left: 15),
                    height: 42,
                    child: Material(
                      elevation: 1,
                      borderRadius: BorderRadius.circular(7),
                      child: TextFormField(
                        controller: fieldText,
                        onFieldSubmitted: navigateToSearch,
                        decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.white,
                            contentPadding: const EdgeInsets.only(top: 10),
                            border: const OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(7)),
                                borderSide: BorderSide.none),
                            enabledBorder: const OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(7)),
                                borderSide: BorderSide(
                                    color: Colors.black38, width: 1)),
                            hintText: "Search in amazon",
                            hintStyle: const TextStyle(
                                fontSize: 17, fontWeight: FontWeight.w500),
                            prefixIcon: InkWell(
                              onTap: () {
                                fieldText.clear();
                              },
                              child: const Padding(
                                padding: EdgeInsets.only(left: 6),
                                child: Icon(
                                  Icons.search,
                                  color: Colors.black,
                                  size: 23,
                                ),
                              ),
                            )),
                      ),
                    ),
                  ),
                ),
                Container(
                  color: Colors.transparent,
                  height: 42,
                  margin: const EdgeInsets.symmetric(horizontal: 10),
                  child: const Icon(
                    Icons.mic,
                    size: 25,
                    color: Colors.black,
                  ),
                )
              ],
            ),
          ),
        ),
        body: products == null
            ? const LoaderIndicator()
            : Column(
                children: [
                  const AddressBox(),
                  const SizedBox(height: 10),
                  products!.isEmpty
                      ? const Center(
                          child: Text(
                          "No Matching Products",
                          style: TextStyle(fontSize: 20),
                        ))
                      : Expanded(
                          child: ListView.builder(
                            itemCount: products!.length,
                            itemBuilder: (BuildContext context, int index) {
                              return GestureDetector(
                                  onTap: () {
                                    Navigator.pushNamed(
                                        context, ProudctDetailsScreen.name,
                                        arguments: products![index]);
                                  },
                                  child: SearchedProduct(
                                      product: products![index]));
                            },
                          ),
                        )
                ],
              ));
  }
}
