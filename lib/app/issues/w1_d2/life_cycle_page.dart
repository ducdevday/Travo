import 'package:flutter/material.dart';
import 'package:my_project/data/temp_model/category_model.dart';

class LifeCyclePage extends StatelessWidget {
  static const String routeName = '/lifeCycle';
  final String title;
  static Route route({required String title}) {
    return MaterialPageRoute(
      settings: RouteSettings(name: routeName),
      builder: (context) => LifeCyclePage(title: title,),
    );
  }
  const LifeCyclePage({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          title,
          style: TextStyle(fontSize: 14),
        ),
      ),
      body: const Padding(
        padding: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CategoryTitle(),
            CategoryFilter(),
          ],
        ),
      ),
    );
  }
}

class CategoryTitle extends StatelessWidget {
  const CategoryTitle({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      "Category:",
      style: TextStyle(fontWeight: FontWeight.w700),
    );
  }
}

class CategoryFilter extends StatefulWidget {
  const CategoryFilter({
    super.key,
  });

  @override
  State<CategoryFilter> createState() => _CategoryFilterState();
}

class _CategoryFilterState extends State<CategoryFilter> {
  final categories = Category.categories;
  Category? catSelected;

  @override
  void initState() {
    super.initState();
    print("CategoryFilter init");
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    print("CategoryFilter didChangeDependencies");
  }

  @override
  void deactivate() {
    super.deactivate();
    print("CategoryFilter deactivate");
  }

  @override
  void dispose() {
    super.dispose();
    print("CategoryFilter dispose");
  }

  @override
  void didUpdateWidget(dynamic oldWidget) {
    super.didUpdateWidget(oldWidget);
    print("CategoryFilter didUpdateWidget");
  }

  @override
  Widget build(BuildContext context) {
    print("CategoryFilter build");
    return Wrap(
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
                backgroundColor:
                    catSelected == cat ? Color(0xff168e9b) : Colors.white,
                label: Text(
                  cat.name,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: catSelected == cat
                          ? Colors.white
                          : Color(0xff168e9b)),
                ),
                selected: catSelected == cat,
                onSelected: (bool selected) {
                  if (selected) {
                    setState(() {
                      catSelected = cat;
                    });
                  }
                }),
          )
          .toList(),
    );
  }
}
