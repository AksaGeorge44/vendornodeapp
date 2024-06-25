// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:petshop/petProducts/cages/birdscages.dart';
import 'package:petshop/screens/appbar/Notificationpage.dart';
import 'package:petshop/cart/cartpage.dart';
import 'package:petshop/firebase_helper/prodctmodel.dart';
import 'package:petshop/cart/productdetails.dart';
import 'package:petshop/model/provider.dart';
import 'package:petshop/model/routes.dart';
import 'package:petshop/screens/homepage.dart';
import 'package:provider/provider.dart';

class BirdsMedicinePage extends StatefulWidget {
  const BirdsMedicinePage({super.key});

  @override
  State<BirdsMedicinePage> createState() => _BirdsMedicinePageState();
}

class _BirdsMedicinePageState extends State<BirdsMedicinePage> {
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
        AppProvider appProvider=Provider.of<AppProvider>(context);

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
        title: const Text("Birds Medicines"),
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
                                      builder: (context) => const BirdsCagePage()));
                            },
                            child: const Text("BIRDS CARE")),
                        
                      
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
                    aspectRatio: 16 / 9, viewportFraction: 1, autoPlay: true),
                items: [
                  // Replace the Image.network with your own images
                  Image.network(
                    "https://i.ytimg.com/vi/mzc4ICYE4nc/maxresdefault.jpg",
                    fit: BoxFit.cover,
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
              style: TextStyle(fontSize: 22, color: Colors.purple),
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
                          padding: const EdgeInsets.all(8.0),
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
      name: "Boltz",
      image: "https://m.media-amazon.com/images/I/41tlAP6ihUL._SX300_SY300_QL70_FMwebp_.jpg",
      stock: 10,
      description:
      "BOLTZ Immunity Booster for All Birds for Healthy Growth with Essential Vitamins, Minerals and Amino acids-100ml, transperent, Small",
      isFavourite: false,
      price: 299,
      status: "pending",
      qty: null),
  ProductModel(
      id: "2",
      stock: 10,
      name: "Boltz ",
      image:
      "https://m.media-amazon.com/images/I/51Bd5o-xQiL._SX300_SY300_QL70_FMwebp_.jpg",
      description:
      "BOLTZ All Life Stages Natural Mineral Block with Cuttlefish Bone 250 gm for Birds",
      isFavourite: false,
      price: 350,
      status: "pending",
      qty: null),
  ProductModel(
      id: "3",
      name: "Petcare",
      stock: 15,
      image:
      "https://m.media-amazon.com/images/I/41MBJzORzgL._SY300_SX300_QL70_FMwebp_.jpg",
      description:
      "Pet Care International (PCI) Vita-Boost to Provide Essential Vitamins for Healthy Bird Healthcare (100ml), 1 Piece",
      isFavourite: false,
      price: 315,
      status: "pending",
      qty: null),
  ProductModel(
      id: "4",
      name: "Felid",
      stock: 15,
      isFavourite: false,
      image:
      "https://m.media-amazon.com/images/I/31M2lHpRJwL._SX300_SY300_QL70_FMwebp_.jpg",
      description:
      "FeliD Feline Oral Suspension Deworming Syrup for Kittens & Young Cats (15ml)",
      status: "pending",
      price: 250,
      qty: null),
];
