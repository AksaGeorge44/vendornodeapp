import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:petshop/cart/cartpage.dart';
import 'package:petshop/cart/productdetails.dart';
import 'package:petshop/firebase_helper/prodctmodel.dart';
import 'package:petshop/screens/homepage.dart';
import 'package:petshop/screens/pets/dog/dogcarepage.dart';
import 'package:petshop/model/provider.dart';
import 'package:petshop/model/routes.dart';
import 'package:provider/provider.dart';

class BirdsprdctPage extends StatefulWidget {
  const BirdsprdctPage({super.key});

  @override
  State<BirdsprdctPage> createState() => _BirdsprdctPageState();
}

class _BirdsprdctPageState extends State<BirdsprdctPage> {
  TextEditingController search = TextEditingController();
  var size, height, width;
  List<ProductModel> searchList = [];

  void searchProducts(String value) {
    searchList = productModelList
        .where((element) =>
            element.name.toLowerCase().contains(value.toLowerCase()))
        .toList();
    setState(() {});
  }

  List<ProductModel> productModelList = [];

  @override
  Widget build(BuildContext context) {
        AppProvider appProvider=Provider.of<AppProvider>(context);

    return Scaffold(
      appBar: AppBar(
        actions: [
          const Padding(
            padding: EdgeInsets.all(17),
            child: Icon(Icons.notification_add_outlined),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const CartScreen()));
                },
                child: const Icon(Icons.shopping_cart)),
          ),
        ],
        title: const Text("Bird Products"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 5),
                    child: SizedBox(
                      width: double.infinity,
                      //color: Colors.black,
                      child: Column(
                        children: [
                          SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              children: [
                                TextButton(
                                    onPressed: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  const HomePage()));
                                    },
                                    child: const Text("HOME")),
                                TextButton(
                                    onPressed: () {},
                                    child: const Text("FEEDING CUP")),
                                TextButton(
                                    onPressed: () {},
                                    child: const Text("FEEDER")),
                                TextButton(
                                    onPressed: () {},
                                    child: const Text("CAGE")),
                                TextButton(
                                    onPressed: () {},
                                    child: const Text("MEDICINES")),
                                TextButton(
                                    onPressed: () {},
                                    child: const Text("SUPPLEMENTS")),
                                TextButton(
                                    onPressed: () {},
                                    child: const Text("TOYS")),
                                TextButton(
                                    onPressed: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  const DogcarePage()));
                                    },
                                    child: const Text("BIRDS CARE")),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    height: 50,
                    width: 800,
                    child: TextFormField(
                      controller: search,
                      onChanged: (String value) {
                        searchProducts(value);
                      },
                      decoration: const InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                          ),
                          prefixIcon: Icon(Icons.search),
                          hintText:
                              "Search for Products, Food, Medicines and more...."),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 1,left: 1,right: 1),
              child: SizedBox(
                height: 200,
                width: 500,
                child: CarouselSlider(
                  options: CarouselOptions(
                      aspectRatio: 16 / 9, viewportFraction: 1,),
                  items: [
                    // Replace the Image.network with your own images
                    Image.network(
                      "https://static.toiimg.com/thumb/msid-94206337,width-400,resizemode-4/94206337.jpg",
                      fit: BoxFit.cover,
                    ),

                    Image.network(
                      "https://shopping.rspb.org.uk/INTERSHOP/static/WFS/RSPB-rspbUK-Site/-/RSPB/en_GB/Homepage/Hero%20images/2023/new-vegan-suet-cakes_DO_hero.jpg",
                      fit: BoxFit.contain,
                    ),

                    // Add more images as needed
                  ],
                ),
              ),
            ),
            const Text(
              "Best Deals",
              style: TextStyle(fontSize: 25, color: Colors.purple),
            ),
            Padding(
              padding: const EdgeInsets.all(25),
              child: GridView.builder(
                padding: const EdgeInsets.all(11),
                shrinkWrap: true,
                itemCount: bestProducts.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    mainAxisSpacing: 20,
                    crossAxisSpacing: 20,
                    childAspectRatio: 0.5,
                    crossAxisCount: 2),
                itemBuilder: (ctx, index) {
                  ProductModel singleProduct = bestProducts[index];
                  return Container(
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.3),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: Colors.blue),
                    ),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(14),
                          child: Image.network(
                            singleProduct.image,
                            height: 100,
                            width: 100,
                          ),
                        ),
                        // const SizedBox(height: 25,),
                        Text(
                          singleProduct.name,
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const SizedBox(
                              width: 15,
                            ),
                            Text("M.R.P: ₹${singleProduct.price}"),
                          ],
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        OutlinedButton(
                          onPressed: () {
                            Routes.instance.push(
                                widget: ProductDetails(
                                    singleProduct: singleProduct),
                                context: context, arguments: appProvider.totalPrice());
                          },
                          style: OutlinedButton.styleFrom(
                            foregroundColor: Colors.redAccent,
                            backgroundColor:
                                const Color.fromARGB(255, 199, 224, 245),
                          ),
                          child: const Text(
                            "Buy",
                            style: TextStyle(fontSize: 20, color: Colors.black),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

List<ProductModel> bestProducts = [
  ProductModel(
      id: "1",
      name: "Hallofeed",
      image: "https://m.media-amazon.com/images/I/71vsst9O-6L._SY355_.jpg",
      stock: 10,
      description: "Hallofeed Special Birds Food for All Birds,700gm",
      isFavourite: false,
      price: 480,
      status: "pending",
      qty: null),
  ProductModel(
      id: "2",
      stock: 26,
      name: "Versele Laga",
      image:
          "https://m.media-amazon.com/images/I/61RsbS9CXaL._SX300_SY300_QL70_FMwebp_.jpg",
      description: "Versele Laga Exotic Nuts, 750 g",
      isFavourite: false,
      price: 913,
      status: "pending",
      qty: null),
  ProductModel(
      id: "3",
      name: "Versele Laga",
      stock: 15,
      image:
          "https://m.media-amazon.com/images/I/41Ka1E++7WL._SY300_SX300_.jpg",
      description: "Versele Laga Prestige Parrot Food, 1 kg",
      isFavourite: false,
      price: 948,
      status: "pending",
      qty: null),
  ProductModel(
      id: "4",
      name: "Bird Food",
      stock: 22,
      image:
          "https://m.media-amazon.com/images/I/51hb9-QjJiL._SY300_SX300_QL70_FMwebp_.jpg",
      description:
          "Versele-Laga, NutriBird A21 Powder Hand Feeding Formula for Birds of All Life Stages, Vegetarian, 250gms (Pack of 1)",
      isFavourite: false,
      status: "pending",
      price: 710,
      qty: null),
];
