import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:my_project/app/issues/w1_d1/research_common_widget_page.dart';
import 'package:my_project/data/temp_model/category_model.dart';
import 'package:my_project/data/temp_model/product_model.dart';

class GoRouterPage extends StatefulWidget {
  static const String routeName = '/goRouter';
  final String title;

  static Route route({required String title}) {
    return MaterialPageRoute(
      settings: RouteSettings(name: routeName),
      builder: (context) => GoRouterPage(title: title),
    );
  }

  const GoRouterPage({Key? key, required this.title}) : super(key: key);

  @override
  State<GoRouterPage> createState() => _GoRouterPageState();
}

class _GoRouterPageState extends State<GoRouterPage> {
  final categories = Category.categories;
  Category catSelected = Category.categories[0];
  var products = Product.productList;

  void handleCategorySelected(Category category) {
    setState(() {
      catSelected = category;
      products = Product.productList
          .where((product) => product.category == category.name)
          .toList();
      if (products.isEmpty) {
        products = Product.productList;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.title,
          style: TextStyle(fontSize: 14),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            SvgPicture.asset(
              "assets/images/Marketplace-bro.svg", width: 274,
              // Adjust the image size as needed
              height: 202,
            ),
            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Category:",
                style: TextStyle(fontWeight: FontWeight.w700),
              ),
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Wrap(
                direction: Axis.horizontal,
                spacing: 4,
                children: categories
                    .map(
                      (cat) => FilterChip(
                          padding: const EdgeInsets.symmetric(horizontal: 4),
                          showCheckmark: false,
                          selectedColor: const Color(0xff168e9b),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            side: const BorderSide(
                              color: Color(0xff168e9b),
                              width: 2.0,
                            ),
                          ),
                          backgroundColor: catSelected == cat
                              ? const Color(0xff168e9b)
                              : Colors.white,
                          label: Text(
                            cat.name,
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: catSelected == cat
                                    ? Colors.white
                                    : const Color(0xff168e9b)),
                          ),
                          selected: catSelected == cat,
                          onSelected: (bool selected) {
                            if (selected) {
                              handleCategorySelected(cat);
                            }
                          }),
                    )
                    .toList(),
              ),
            ),
            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Product:",
                style: TextStyle(fontWeight: FontWeight.w700),
              ),
            ),
            Expanded(
              child: ListView.builder(
                  itemCount: products.length,
                  itemBuilder: (context, index) =>
                      ProductItem(product: products[index])),
            ),
          ],
        ),
      ),
    );
  }
}
