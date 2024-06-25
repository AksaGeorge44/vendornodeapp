// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:petshop/screens/appbar/Notificationpage.dart';
import 'package:petshop/cart/cartpage.dart';
import 'package:petshop/firebase_helper/prodctmodel.dart';
import 'package:petshop/cart/productdetails.dart';
import 'package:petshop/model/provider.dart';
import 'package:petshop/model/routes.dart';
import 'package:petshop/screens/homepage.dart';
import 'package:petshop/screens/pets/dog/dogcarepage.dart';
import 'package:provider/provider.dart';

class RabbitMedicinePage extends StatefulWidget {
  const RabbitMedicinePage({super.key});

  @override
  State<RabbitMedicinePage> createState() => _RabbitMedicinePageState();
}

class _RabbitMedicinePageState extends State<RabbitMedicinePage> {
  List<ProductModel> productModelList = [];
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

  @override
  Widget build(BuildContext context) {
    AppProvider appProvider = Provider.of<AppProvider>(context);

    return Scaffold(
      appBar: AppBar(
        actions: [
          Padding(
            padding: const EdgeInsets.all(15),
            child: GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const NotificationPage()));
                },
                child: const Icon(Icons.info_rounded)),
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
        title: const Text("Rabbit Medicines"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 10,
            ),
            Column(
              children: [
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Row(
                      children: [
                        TextButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const HomePage()));
                            },
                            child: const Text("HOME")),
                        TextButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const DogcarePage()));
                            },
                            child: const Text("RABBIT CARE")),
                      ],
                    ),
                  ),
                )
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 50,
                  width: 350,
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
                        hintText: "Search for Medicines and more...."),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            SizedBox(
              height: 190,
              child: CarouselSlider(
                options: CarouselOptions(
                  aspectRatio: 16 / 9,
                  viewportFraction: 1,
                ),
                items: [
                  // Replace the Image.network with your own images
                  Image.network(
                    "https://thumbs.dreamstime.com/z/medicine-research-testing-rabbit-animal-natural-organic-herbal-extraction-medicine-safety-chemical-medicine-research-103532852.jpg",
                    fit: BoxFit.contain,
                  ),

                  // Add more images as needed
                ],
              ),
            ),
            const SizedBox(
              height: 25,
            ),
            const Text(
              "Pick For Pet",
              style: TextStyle(
                  fontSize: 20, color: Color.fromARGB(255, 184, 139, 192)),
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
                        Image.network(
                          singleProduct.image,
                          height: 100,
                          width: 100,
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
      name: "Vetenex",
      image:
          "https://m.media-amazon.com/images/I/41rc-xN2x-L._SX300_SY300_QL70_FMwebp_.jpg",
      stock: 10,
      description:
          "VETENEX Rabbit Booster - Complete Nutritional Supplement with Multivitamins, Minerals & Probiotics for Rabbit, Guinea Pig & Hamsters - 100g",
      isFavourite: false,
      price: 129,
      status: "pending",
      qty: null),
  ProductModel(
      id: "2",
      stock: 10,
      name: "Boltz ",
      image:
          "https://m.media-amazon.com/images/I/51LYQLIO-FL._SX300_SY300_QL70_FMwebp_.jpg",
      description:
          "BOLTZ Rabbit Litter Spray 200 ml and Rabbit Food 1.2 Kg Combo (Rabbit Litter Spray + Rabbit Food)",
      isFavourite: false,
      price: 650,
      status: "pending",
      qty: null),
  ProductModel(
      id: "3",
      name: "API",
      stock: 15,
      image:
          "https://m.media-amazon.com/images/I/41ETj24yzVL._SX300_SY300_QL70_FMwebp_.jpg",
      description: "API Melafix, 237 ml, 1 Piece",
      isFavourite: false,
      price: 1315,
      status: "pending",
      qty: null),
  ProductModel(
      id: "4",
      name: "Felid",
      stock: 15,
      isFavourite: false,
      image:
          "https://m.media-amazon.com/images/I/41FeFWr3OnL._SX300_SY300_QL70_FMwebp_.jpg",
      description: "API Pimafix, 118 ml, 118 ml (Pack of 1)",
      status: "pending",
      price: 550,
      qty: null),
];
