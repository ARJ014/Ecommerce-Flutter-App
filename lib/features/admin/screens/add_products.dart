import 'dart:io';

import 'package:amazon_clone/common/widget/button.dart';
import 'package:amazon_clone/common/widget/textField.dart';
import 'package:amazon_clone/constants/utils.dart';
import 'package:amazon_clone/features/admin/service/admin_services.dart';
import 'package:amazon_clone/features/home/widgets/carousel_slider.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';

import '../../../constants/golabal_variables.dart';

class AddProductsScreen extends StatefulWidget {
  static const String name = "/Add-Proudcts";
  const AddProductsScreen({super.key});

  @override
  State<AddProductsScreen> createState() => _AddProductsScreenState();
}

class _AddProductsScreenState extends State<AddProductsScreen> {
  TextEditingController productName = TextEditingController();
  TextEditingController productDescr = TextEditingController();
  TextEditingController price = TextEditingController();
  TextEditingController quantity = TextEditingController();
  final formKey = GlobalKey<FormState>();
  final AdminServices adminServices = AdminServices();

  List<String> productCategories = [
    'Mobiles',
    'Essentials',
    'Appliances',
    'Books',
    'Fashion'
  ];
  String category = "Mobiles";
  List<File> images = [];

  void selctImages() async {
    var result = await pickImages();
    setState(() {
      images = result;
    });
  }

  void addProduct() {
    if (formKey.currentState!.validate() && images.isNotEmpty) {
      adminServices.sellProduct(
          context: context,
          name: productName.text,
          description: productDescr.text,
          price: int.parse(price.text),
          quantity: int.parse(quantity.text),
          category: category,
          images: images);
    }
  }

  @override
  void dispose() {
    super.dispose();
    productName.dispose();
    productDescr.dispose();
    quantity.dispose();
    price.dispose();
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
            title: const Text("Add Product",
                style: TextStyle(
                    color: Colors.black, fontWeight: FontWeight.bold))),
      ),
      body: SingleChildScrollView(
          child: Form(
        key: formKey,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              images.isNotEmpty
                  ? CarouselSlider(
                      options:
                          CarouselOptions(viewportFraction: 1, height: 200),
                      items: images.map((e) {
                        return Builder(
                            builder: ((context) => Image.file(
                                  e,
                                  fit: BoxFit.cover,
                                  height: 200,
                                )));
                      }).toList(),
                    )
                  : GestureDetector(
                      onTap: selctImages,
                      child: DottedBorder(
                        borderType: BorderType.RRect,
                        radius: const Radius.circular(10),
                        dashPattern: const [10, 4],
                        strokeCap: StrokeCap.round,
                        child: Container(
                          width: double.infinity,
                          height: 200,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10)),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(
                                Icons.folder_open_outlined,
                                size: 40,
                              ),
                              const SizedBox(height: 15),
                              Text(
                                "Add product Images",
                                style: TextStyle(
                                    fontSize: 15, color: Colors.grey.shade400),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
              const SizedBox(height: 10),
              CustomTextField(
                  controller: productName, hintText: "Product Name"),
              const SizedBox(height: 10),
              CustomTextField(
                  controller: productDescr,
                  hintText: "Product Description",
                  maxlines: 7),
              const SizedBox(height: 10),
              CustomTextField(controller: price, hintText: "Product Price"),
              const SizedBox(height: 10),
              CustomTextField(
                  controller: quantity, hintText: "Product quantity"),
              const SizedBox(height: 10),
              SizedBox(
                width: double.infinity,
                child: DropdownButton(
                  onChanged: (String? value) {
                    setState(() {
                      category = value!;
                    });
                  },
                  value: category,
                  icon: const Icon(Icons.arrow_drop_down_sharp),
                  items: productCategories.map((e) {
                    return DropdownMenuItem(
                      value: e,
                      child: Text(e),
                    );
                  }).toList(),
                ),
              ),
              const CrouselSlider(),
              const SizedBox(height: 10),
              CustomButton(
                text: "Add Product",
                ontap: () {
                  addProduct();
                },
              )
            ],
          ),
        ),
      )),
    );
  }
}
