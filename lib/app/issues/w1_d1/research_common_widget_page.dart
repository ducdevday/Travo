import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:my_project/app/config/app_router.dart';
import 'package:my_project/app/issues/w1_d3/product_detail_page.dart';
import 'package:my_project/app/utils/string_format_util.dart';
import 'package:my_project/data/temp_model/category_model.dart';
import 'package:my_project/data/temp_model/product_model.dart';

class ResearchCommonWidgetPage extends StatelessWidget {
  static const String routeName = "/researchCommonWidget";
  final String title;

  static Route route({required String title}) {
    return MaterialPageRoute(
      settings: RouteSettings(name: routeName),
      builder: (context) => ResearchCommonWidgetPage(
        title: title,
      ),
    );
  }

  const ResearchCommonWidgetPage({Key? key, required this.title})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final products = Product.productList;
    final categories = Category.categories;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          title,
          style: TextStyle(fontSize: 14),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Sự khác nhau giữa Cupertino App và Material App:",
              style: TextStyle(fontWeight: FontWeight.w700),
            ),
            const Text(
                "Cupertino App và Material App là hai loại ứng dụng Flutter được sử dụng để tạo ứng dụng cho các nền tảng iOS và Android. Cả hai loại ứng dụng đều cung cấp các widget và API để phát triển giao diện người dùng (UI) cho ứng dụng.\nKhác biệt giữa Cupertino App và Material App là về giao diện. Cupertino App sử dụng giao diện Cupertino, được thiết kế theo phong cách iOS. Material App sử dụng giao diện Material, được thiết kế theo phong cách Android."),
            const Text(
              "Các Common Widget:",
              style: TextStyle(fontWeight: FontWeight.w700),
            ),
            const Text(
              "Category:",
              style: TextStyle(fontWeight: FontWeight.w700),
            ),
            //? Wrap is same Flex (parent of Row và Column), but it can arrange children widget into new column/ row base on space remaining.
            Wrap(
              direction: Axis.horizontal,
              spacing: 4,
              children: categories
                  .map((cat) => Container(
                        padding: const EdgeInsets.symmetric(
                            vertical: 4, horizontal: 8),
                        decoration: BoxDecoration(
                            color: Colors.grey,
                            borderRadius:
                                const BorderRadius.all(Radius.circular(8)),
                            border: Border.all(color: Colors.grey)),
                        child: Text(cat.name),
                      ))
                  .toList(),
            ),
            const Text(
              "Product:",
              style: TextStyle(fontWeight: FontWeight.w700),
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

class ProductItem extends StatelessWidget {
  const ProductItem({super.key, required this.product});

  final Product product;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(8)),
          border: Border.all(color: Colors.grey)),
      child: InkWell(
        onTap: () {
          Navigator.of(context)
              .pushNamed(ProductDetailPage.routeName, arguments: product.id);
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                CachedNetworkImage(
                  imageUrl: product.imageUrl,
                  height: 200,
                  width: double.maxFinite,
                  fit: BoxFit.cover,
                  placeholder: (context, url) =>
                      const CircularProgressIndicator(),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                ),
                widgetIcon(product.isRecommended),
              ],
            ),
            Row(
              children: [
                //? Expanded is just a shorthand for Flexible
                //? Flexible are by default WRAP_CONTENT
                //? Expanded is MATCH_PARENT
                //? Expanded == Flexible with fit: FlexFit.tight
                Flexible(
                    fit: FlexFit.tight,
                    child: Text(
                      product.name,
                    )),
                Text("${StringFormatUtil.formatMoney(product.price)}")
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [const Text("Category:"), Text(product.category)],
            ),
          ],
        ),
      ),
    );
  }
}

Widget widgetIcon(bool isRecommended) {
  if (isRecommended) {
    return const Icon(
      Icons.diamond_rounded,
      color: Colors.amberAccent,
    );
  } else {
    return const SizedBox();
  }
}
