// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:amazon_clone/common/widget/button.dart';
import 'package:amazon_clone/common/widget/rating_bar_star.dart';
import 'package:amazon_clone/features/address/address_screen.dart';
import 'package:amazon_clone/features/product_details/services/product_detail_services.dart';
import 'package:amazon_clone/provider/user_provider.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

import 'package:amazon_clone/models/proudct.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart' as star;
import 'package:provider/provider.dart';

import '../../../constants/golabal_variables.dart';
import '../../search/screen/search_screen.dart';

class ProudctDetailsScreen extends StatefulWidget {
  static const String name = "ProductDetailScreen";
  final Product product;
  const ProudctDetailsScreen({
    Key? key,
    required this.product,
  }) : super(key: key);

  @override
  State<ProudctDetailsScreen> createState() => _ProudctDetailsScreenState();
}

class _ProudctDetailsScreenState extends State<ProudctDetailsScreen> {
  final ProductDetailServices productDetailServices = ProductDetailServices();
  double myRating = 0;
  double averageRating = 0;

  void navigateToSearch(String value) {
    Navigator.pushNamed(context, SearchScreen.name, arguments: value);
  }

  void addToCart() {
    productDetailServices.addToCart(context: context, product: widget.product);
  }

  void naviagateToAddressScreen(String totalAmount) {
    Navigator.pushNamed(context, AddressScreen.name, arguments: totalAmount);
  }

  @override
  void initState() {
    super.initState();
    double ratingSum = 0;
    if (widget.product.ratings != null) {
      for (int i = 0; i < widget.product.ratings!.length; i++) {
        if (widget.product.ratings![i].userId ==
            Provider.of<UserProvider>(context, listen: false).user.id) {
          myRating = widget.product.ratings![i].ratings;
        }
        ratingSum += widget.product.ratings![i].ratings;
      }
      if (ratingSum != 0) {
        averageRating = ratingSum / widget.product.ratings!.length;
      }
    }
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
                              borderSide:
                                  BorderSide(color: Colors.black38, width: 1)),
                          hintText: "Search in amazon",
                          hintStyle: const TextStyle(
                              fontSize: 17, fontWeight: FontWeight.w500),
                          prefixIcon: InkWell(
                            onTap: () {},
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
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(Provider.of<UserProvider>(context).user.email),
                  RatingBar(rating: averageRating)
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
              child: Text(
                widget.product.name,
                style:
                    const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
            ),
            CarouselSlider(
              items: widget.product.images.map((e) {
                return Builder(
                    builder: ((context) => Image.network(
                          e,
                          fit: BoxFit.contain,
                          height: 200,
                        )));
              }).toList(),
              options: CarouselOptions(height: 250, viewportFraction: 1),
            ),
            Container(
              color: Colors.black12,
              height: 5,
            ),
            Padding(
              padding: const EdgeInsets.all(8),
              child: RichText(
                text: TextSpan(
                    text: "Deal Price:",
                    style: const TextStyle(
                        fontSize: 16,
                        color: Colors.black,
                        fontWeight: FontWeight.bold),
                    children: [
                      TextSpan(
                        text: "$Rs${widget.product.price}",
                        style: const TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.w500,
                            color: Colors.red),
                      ),
                    ]),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(widget.product.description),
            ),
            Container(
              color: Colors.black12,
              height: 5,
            ),
            widget.product.quantity == 0
                ? Container(
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    alignment: Alignment.center,
                    child: const Text(
                      "Out Of Stock",
                      style: TextStyle(
                          fontSize: 30, color: GlobalVariables.secondaryColor),
                    ),
                  )
                : Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: CustomButton(
                          text: "Buy Now",
                          ontap: () => naviagateToAddressScreen(
                            widget.product.price.toString(),
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: CustomButton(
                          color: const Color.fromRGBO(254, 216, 19, 1),
                          text: "Add To Cart",
                          ontap: addToCart,
                        ),
                      ),
                    ],
                  ),
            const SizedBox(height: 10),
            Container(
              color: Colors.black12,
              height: 5,
            ),
            const SizedBox(height: 10),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.0),
              child: Text(
                "Rate the Product",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
            ),
            star.RatingBar.builder(
                initialRating: myRating,
                minRating: 1,
                direction: Axis.horizontal,
                allowHalfRating: true,
                itemCount: 5,
                itemPadding: const EdgeInsets.symmetric(horizontal: 4),
                itemBuilder: (context, index) => const Icon(
                      Icons.star,
                      color: GlobalVariables.secondaryColor,
                    ),
                onRatingUpdate: (rating) {
                  productDetailServices.rateProduct(
                      context: context,
                      product: widget.product,
                      rating: rating);
                })
          ],
        ),
      ),
    );
  }
}
