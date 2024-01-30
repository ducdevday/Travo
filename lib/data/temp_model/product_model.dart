import 'package:equatable/equatable.dart';

class Product extends Equatable {
  final String id;
  final String name;
  final String category;
  final String imageUrl;
  final double price;
  final bool isRecommended;
  final bool isPopular;
  final String? description;

  Product(
      {required this.id,
      required this.name,
      required this.category,
      required this.imageUrl,
      required this.price,
      required this.isRecommended,
      required this.isPopular,
      this.description});

  @override
  List<Object?> get props =>
      [name, category, imageUrl, price, isRecommended, isPopular];

  static List<Product> productList = [
    Product(
        id: '1',
        name: 'Soft Drink #1',
        category: 'Soft Drinks',
        imageUrl:
            'https://images.unsplash.com/photo-1598614187854-26a60e982dc4?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=1050&q=80',
        price: 2.99,
        isRecommended: true,
        isPopular: false,
        description:
            "In the early 19th century, British officials stationed in India mixed a mixture of sugar, quinine and soda as a drink to fight malaria. From there, tonic water was born. In 1858, tonic water was first produced commercially. Nowadays, tonic water with its sweet, sour and bitter flavors has become an irreplaceable part of mixing into diverse cocktails, especially drinks containing vodka or gin."),
    Product(
        id: '2',
        name: 'Soft Drink #2',
        category: 'Soft Drinks',
        imageUrl:
            'https://images.unsplash.com/photo-1610873167013-2dd675d30ef4?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=488&q=80',
        price: 2.99,
        isRecommended: false,
        isPopular: true,
        description:
            "Pepsi is a carbonated beverage, first produced by Caleb Bradham. Initially, he mixed up an easy-to-absorb drink made from carbonate water, sugar, vanilla and a little cooking oil under the name Brad's Drink in 1892. Pepsi was first produced in 1890 by pharmacists. Invented by Caleb Bradham in New Bern, North Carolina, Pepsi has had many variations produced over the years since 1898."),
    Product(
        id: '3',
        name: 'Soft Drink #3',
        category: 'Soft Drinks',
        imageUrl:
            'https://images.unsplash.com/photo-1603833797131-3c0a18fcb6b1?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=1050&q=80',
        price: 2.99,
        isRecommended: true,
        isPopular: true,
        description:
            "A famous beer brand originating from Mexico since 1925 with excellent flavor. Corona Extra beer 330ml has a clear, bright straw yellow color, mild aroma, smooth, smooth beer taste and strong carbonation. Corona beer has a low concentration and is very suitable for conversations with family and friends."),
    Product(
        id: '4',
        name: 'Smoothies #1',
        category: 'Smoothies',
        imageUrl:
            'https://images.unsplash.com/photo-1526424382096-74a93e105682?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=634&q=80',
        price: 2.99,
        isRecommended: true,
        isPopular: false,
        description:
            "When life gives you lemons, make the Best Lemonade Ever! This aptly named recipe is as good as it gets: Sweet, tart, easy to throw together, and oh-so refreshing. Sweeten your day with our top-rated lemonade recipe (and get our best lemonade serving and storage tips)."),
    Product(
        id: '5',
        name: 'Smoothies #2',
        category: 'Smoothies',
        imageUrl:
            'https://images.unsplash.com/photo-1505252585461-04db1eb84625?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=1552&q=80',
        price: 2.99,
        isRecommended: false,
        isPopular: false,
        description:
            "An ice cream cone or poke (Ireland/Scotland) is a brittle, cone-shaped pastry, usually made of a wafer similar in texture to a waffle, made so ice cream can be carried and eaten without a bowl or spoon, for example, the Hong Kong–style bubble cone. Many styles of cones are made, including pretzel cones, sugar-coated and chocolate-coated cones (coated on the inside). The term ice cream cone can also refer, informally, to the cone with one or more scoops of ice cream on top. There are two techniques for making cones: one is by baking them flat and then quickly rolling them into shape (before they harden), the other is by baking them inside a cone-shaped mold."),
    Product(
        id: '6',
        name: 'Aquafina',
        category: 'Water',
        imageUrl: 'https://profood.vn/wp-content/uploads/2023/03/15-1.jpg',
        price: 1.99,
        isRecommended: false,
        isPopular: false,
        description:
            "Aquafina is pure drinking water treated through the Hydro-7 filtration process, which includes reverse osmosis technology and a number of other filtration steps to thoroughly remove minerals, bacteria and impurities in water. Thanks to that, creating a perfect pure water product with a completely different fresh flavor. Aquafina is a product of Suntory PepsiCo Vietnam Beverage Co., Ltd. and is manufactured under copyright by PepsiCo Inc 700 Anderson Hill Road, Purchase, New York 10577, USA, in accordance with the Drinking Water standards of the Health Organization. Healthy World."),
    // Product(
    //   id: '6',
    //   name: 'Soft Drink #1',
    //   category: 'Soft Drinks',
    //   imageUrl:
    //   'https://images.unsplash.com/photo-1598614187854-26a60e982dc4?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=1050&q=80',
    //   price: 2.99,
    //   isRecommended: true,
    //   isPopular: false,
    // ),
    // Product(
    //   id: '7',
    //   name: 'Soft Drink #2',
    //   category: 'Soft Drinks',
    //   imageUrl:
    //   'https://images.unsplash.com/photo-1610873167013-2dd675d30ef4?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=488&q=80',
    //   price: 2.99,
    //   isRecommended: false,
    //   isPopular: true,
    // ),
    // Product(
    //   id: '8',
    //   name: 'Soft Drink #3',
    //   category: 'Soft Drinks',
    //   imageUrl:
    //   'https://images.unsplash.com/photo-1603833797131-3c0a18fcb6b1?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=1050&q=80',
    //   price: 2.99,
    //   isRecommended: true,
    //   isPopular: true,
    // ),
    // Product(
    //   id: '9',
    //   name: 'Smoothies #1',
    //   category: 'Smoothies',
    //   imageUrl:
    //   'https://images.unsplash.com/photo-1526424382096-74a93e105682?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=634&q=80',
    //   price: 2.99,
    //   isRecommended: true,
    //   isPopular: false,
    // ),
    // Product(
    //   id: '10',
    //   name: 'Smoothies #2',
    //   category: 'Smoothies',
    //   imageUrl:
    //   'https://images.unsplash.com/photo-1505252585461-04db1eb84625?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=1552&q=80',
    //   price: 2.99,
    //   isRecommended: false,
    //   isPopular: false,
    // ),
    // Product(
    //   id: '11',
    //   name: 'Soft Drink #1',
    //   category: 'Soft Drinks',
    //   imageUrl:
    //   'https://images.unsplash.com/photo-1598614187854-26a60e982dc4?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=1050&q=80',
    //   price: 2.99,
    //   isRecommended: true,
    //   isPopular: false,
    // ),
    // Product(
    //   id: '12',
    //   name: 'Soft Drink #2',
    //   category: 'Soft Drinks',
    //   imageUrl:
    //   'https://images.unsplash.com/photo-1610873167013-2dd675d30ef4?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=488&q=80',
    //   price: 2.99,
    //   isRecommended: false,
    //   isPopular: true,
    // ),
    // Product(
    //   id: '13',
    //   name: 'Soft Drink #3',
    //   category: 'Soft Drinks',
    //   imageUrl:
    //   'https://images.unsplash.com/photo-1603833797131-3c0a18fcb6b1?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=1050&q=80',
    //   price: 2.99,
    //   isRecommended: true,
    //   isPopular: true,
    // ),
    // Product(
    //   id: '14',
    //   name: 'Smoothies #2',
    //   category: 'Smoothies',
    //   imageUrl:
    //   'https://images.unsplash.com/photo-1505252585461-04db1eb84625?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=1552&q=80',
    //   price: 2.99,
    //   isRecommended: false,
    //   isPopular: false,
    // ),
  ];
}
