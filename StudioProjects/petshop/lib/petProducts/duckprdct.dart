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

class DuckprdctPage extends StatefulWidget {
  const DuckprdctPage({super.key});

  @override
  State<DuckprdctPage> createState() => _DuckprdctPageState();
}

class _DuckprdctPageState extends State<DuckprdctPage> {
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
    AppProvider appProvider = Provider.of<AppProvider>(context);

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
        title: const Text("Products"),
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
                                    child: const Text("NEST")),
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
                    height: 10,
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
              padding: const EdgeInsets.all(20),
              child: SizedBox(
                height: 200,
                width: 500,
                child: CarouselSlider(
                  options: CarouselOptions(
                    aspectRatio: 16 / 9,
                    viewportFraction: 1,
                  ),
                  items: [
                    // Replace the Image.network with your own images

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
                          padding: const EdgeInsets.all(10),
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
                                context: context,
                                arguments: appProvider.totalPrice());
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
      name: "Purina",
      image: "https://m.media-amazon.com/images/I/81S6aA1+-kL._AC_SX679_.jpg",
      stock: 15,
      description:
          "Purina | Nutritionally Complete Duck Feed for All Life-Stages | 5 Pound (5 lb.) Bag",
      isFavourite: false,
      price: 480,
      status: "pending",
      qty: null),
  ProductModel(
      id: "2",
      name: "Freshos",
      image: "https://m.media-amazon.com/images/I/518pz3Ql81L._SX569_.jpg",
      stock: 46,
      description: "Freshos Vegetarian Mock Duck, 9.98 oz / 283 g",
      isFavourite: false,
      price: 350,
      status: "pending",
      qty: null),
  ProductModel(
      id: "3",
      name: "Brambles",
      image: "https://m.media-amazon.com/images/I/71Pi4nGRtQL._AC_SY879_.jpg",
      isFavourite: false,
      description: "Brambles Floating Swan and Duck Food, 1.75 kg",
      stock: 12,
      price: 1000,
      status: "pending",
      qty: null),
  ProductModel(
      id: "4",
      name: "Manna Pro",
      isFavourite: false,
      image: "https://m.media-amazon.com/images/I/81m+YGCuIEL.jpg",
      stock: 10,
      description:
          "Manna Pro Duck Starter Grower | Duck Food, Duck Pellets, Chick Feed | 8 Pounds",
      status: "pending",
      price: 710,
      qty: null),
];
