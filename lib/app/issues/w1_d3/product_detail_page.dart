import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:my_project/data/temp_model/product_model.dart';

class ProductDetailPage extends StatefulWidget {
  static const String routeName = '/productDetail';

  static Route route({required String productID}) {
    return MaterialPageRoute(
      settings: RouteSettings(name: routeName),
      builder: (context) => ProductDetailPage(productID: productID,),
    );
  }
  final String productID;

  const ProductDetailPage({Key? key, required this.productID})
      : super(key: key);

  @override
  State<ProductDetailPage> createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage> {
  late Product product;

  @override
  void initState() {
    super.initState();
    product = Product.productList
        .firstWhere((product) => product.id == widget.productID);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Product Detail",
          style: TextStyle(fontSize: 14),
        ),
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              children: [
                Stack(
                  children: [
                    CachedNetworkImage(
                      imageUrl: product.imageUrl,
                      height: 200,
                      width: double.maxFinite,
                      fit: BoxFit.cover,
                      placeholder: (context, url) => const CircularProgressIndicator(),
                      errorWidget: (context, url, error) => const Icon(Icons.error),
                    ),
                    Builder(
                        builder: (_) => product.isRecommended
                            ? const Icon(
                                Icons.diamond_rounded,
                                color: Colors.amberAccent,
                              )
                            : const SizedBox())
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Stack(
                  children: <Widget>[
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: 60,
                      alignment: Alignment.bottomCenter,
                      decoration: BoxDecoration(
                        color: Colors.black.withAlpha(50),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.all(5.0),
                      width: MediaQuery.of(context).size.width - 10,
                      height: 50,
                      decoration: const BoxDecoration(
                        color: Colors.black,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              product.name,
                              style: Theme.of(context)
                                  .textTheme
                                  .headline5!
                                  .copyWith(color: Colors.white),
                            ),
                            Text(
                              '${product.price}',
                              style: Theme.of(context)
                                  .textTheme
                                  .headline5!
                                  .copyWith(color: Colors.white),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                // ExpansionTile(
                //   initiallyExpanded: true,
                //   title: Text(
                //     "Product Information",
                //     style: Theme.of(context).textTheme.headline3,
                //   ),
                //   children: <Widget>[
                //     ListTile(
                //       title: Text(
                //         product.description ?? '',
                //         style: Theme.of(context).textTheme.bodyText1,
                //       ),
                //     )
                //   ],
                // ),
                SizedBox(
                  height: 10,
                ),
                ExpansionTile(
                  title: Text(
                    "Description",
                  ),
                  children: <Widget>[
                    ListTile(
                      title: Text(product.description!),
                    )
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
