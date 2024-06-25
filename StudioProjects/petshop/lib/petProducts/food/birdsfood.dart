import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:petshop/screens/appbar/Notificationpage.dart';
import 'package:petshop/cart/cartpage.dart';
import 'package:petshop/firebase_helper/prodctmodel.dart';
import 'package:petshop/cart/productdetails.dart';
import 'package:petshop/model/provider.dart';
import 'package:petshop/model/routes.dart';
import 'package:petshop/screens/homepage.dart';
import 'package:petshop/screens/pets/birds/birdscare.dart';
import 'package:provider/provider.dart';

class BirdsFoodPage extends StatefulWidget {
  const BirdsFoodPage({super.key});

  @override
  State<BirdsFoodPage> createState() => _BirdsFoodPageState();
}

class _BirdsFoodPageState extends State<BirdsFoodPage> {
  List<ProductModel> productModelList = [];

  TextEditingController search = TextEditingController();
  // ignore: prefer_typing_uninitialized_variables
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
        title: const Text("Birds Foods"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
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
                                      builder: (context) =>
                                          const HomePage()));
                            },
                            child: const Text("HOME")),
                     
                        TextButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const BirdsCarePage()));
                            },
                            child: const Text("BIRD CARE")),
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
                        hintText: "Search for Foods and more...."),
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
                    "https://m.media-amazon.com/images/I/512BhnlhWIL._AC_UF1000,1000_QL80_.jpg",
                    fit:BoxFit.contain
                    
                  
                  ),

                  Image.network(
                    "https://m.media-amazon.com/images/I/61yGw2Jx7HL._AC_UF1000,1000_QL80_.jpg",
                    fit: BoxFit.contain,
                  ),

                  // Add more images as needed
                ],
              ),
            ),
            const SizedBox(
              height: 25,
            ),
            const SizedBox(
              height: 10,
            ),
            const Text(
              "Pick For Your Pet",
              style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.black),
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
                          padding: const EdgeInsets.all(15),
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
      name: "BOLTZ",
      description: "BOLTZ Bird Food for Adult Budgies - Mix Seeds (1.2 KG)",
      image:
      "https://m.media-amazon.com/images/I/713q7hlIjuL._SY450_.jpg",
      isFavourite: false,
      price: 420,
      status: "pending",
      stock: 10,
      qty: null),
  ProductModel(
      id: "2",
      name: "Millet",
      description:
      "The Birds Company Foxtail Millet (Kangni), Bird Food for All Life Stages Canary, Finches, Waxbills, Budgies, Lovebirds, Cockatiels, Parrots & Parakeets, 450 g",
          stock: 30,
      image:
      "https://m.media-amazon.com/images/I/517xs4o-vpL._SX300_SY300_QL70_FMwebp_.jpg",
      isFavourite: false,
      price: 195,
      status: "pending",
      
      
      qty: null),
  ProductModel(
      id: "3",
      name: "Seed Blend",
      stock: 16,
      description: "The Birds Company Premium Seed Blend of 9 Grains & Nuts, Bird Feeder Food Refill, Mix Seeds for Outside Wild Birds, Indian Parrot, Sparrow, Doves, 450 g",
      image:
      "https://m.media-amazon.com/images/I/5187QLMBsdL._SX300_SY300_QL70_FMwebp_.jpg",
      isFavourite: false,
      price: 320,
      status: "pending",
      qty: null),
  ProductModel(
      id: "4",
      name: "Boltz",
      stock: 12,
      isFavourite: false,
      image: "https://m.media-amazon.com/images/I/418MTL4QrtL._SY300_SX300_QL70_FMwebp_.jpg",
      status: "pending",
      description: "Boltz Adult Bird Food for Cockatiel & Lovebirds Mix Seeds, Canary Seed, Sunflower seed (1.2 KG)",
      price: 300,
      qty: null),
];