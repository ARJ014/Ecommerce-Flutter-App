import 'package:amazon_clone/common/widget/loader.dart';
import 'package:amazon_clone/features/account/widgets/single_product.dart';
import 'package:amazon_clone/features/admin/screens/add_products.dart';
import 'package:amazon_clone/features/admin/service/admin_services.dart';
import 'package:amazon_clone/models/proudct.dart';
import 'package:flutter/material.dart';

class ProductsScreen extends StatefulWidget {
  const ProductsScreen({super.key});

  @override
  State<ProductsScreen> createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {
  final AdminServices adminServices = AdminServices();

  List<Product>? products;
  @override
  void initState() {
    super.initState();
    fetchAllProducts();
  }

  fetchAllProducts() async {
    products = await adminServices.fetchAllProducts(context);
    setState(() {});
  }

  void deleteProductFromClient(Product product, int index) {
    adminServices.deleteProduct(
        context: context,
        product: product,
        onSuccess: () {
          products!.removeAt(index);
          setState(() {});
        });
  }

  @override
  Widget build(BuildContext context) {
    return products == null
        ? const LoaderIndicator()
        : Scaffold(
            body: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
              ),
              itemCount: products!.length,
              itemBuilder: (BuildContext context, int index) {
                final productData = products![index];
                return Column(children: [
                  Container(
                    margin: const EdgeInsets.only(top: 5),
                    height: 140,
                    child: SingleProduct(image: productData.images[0]),
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          productData.description,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.delete_outline_outlined),
                        onPressed: () {
                          deleteProductFromClient(productData, index);
                        },
                      )
                    ],
                  )
                ]);
              },
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                Navigator.pushNamed(context, AddProductsScreen.name);
              },
              tooltip: "Add a product.",
              child: const Icon(Icons.add),
            ),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerFloat,
          );
  }
}
