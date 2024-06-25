import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:petshop/screens/appbar/Notificationpage.dart';
import 'package:petshop/cart/cartpage.dart';
import 'package:petshop/firebase_helper/prodctmodel.dart';
import 'package:petshop/cart/productdetails.dart';
import 'package:petshop/model/provider.dart';
import 'package:petshop/model/routes.dart';
import 'package:provider/provider.dart';

class CatAccsryPage extends StatefulWidget {
  const CatAccsryPage({super.key});

  @override
  State<CatAccsryPage> createState() => _CatAccsryPageState();
}

class _CatAccsryPageState extends State<CatAccsryPage> {
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
        title: const Text("Cat Accessory"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 30,
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
                        hintText: "Search for accessories and more...."),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 40,
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
                    "https://www.nappets.com/wp-content/uploads/2023/06/Cat-Accessories.jpg",
                    fit: BoxFit.fill,
                  ),

                  // Add more images as needed
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            const Text(
              "Pick For Pet",
              style: TextStyle(fontSize: 25, color: Colors.black),
            ),
            Padding(
              padding: const EdgeInsets.all(20),
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
      name: "Sleeping mat",
      stock: 10,
      image:
          "https://m.media-amazon.com/images/I/71Nhd5NtM4L._AC_UF894,1000_QL80_.jpg",
      description:
          "Hoodinter Car Dashboard Big Sleeping Cat Plush Toy for Car Interior Decoration Soft Cat Accessories Figurines Showpiece for Car Dashboard Room, Office & Table (White, Grey Mix)",
      isFavourite: false,
      price: 799,
      status: "pending",
      qty: null),
  ProductModel(
      id: "2",
      name: "Cat Collar",
      stock: 12,
      image:
          "https://m.media-amazon.com/images/I/71Rgup-bhML._AC_UF1000,1000_QL80_.jpg",
      description:
          "LLHK 4 Pack Small Fish Cat Collars with Bow Tie and Bell,Personalized Breakaway Kitten Collar for Girl boy Cats,Adjustable 7-12inch,Cute for Kitty Kitten Adult Cats,Pet Supplies,Stuff,Accessories",
      isFavourite: false,
      price: 2149,
      status: "pending",
      qty: null),
  ProductModel(
      id: "3",
      name: "Cat Tree",
      isFavourite: false,
      image:
          "https://m.media-amazon.com/images/I/716dzhBCtDL.__AC_SX300_SY300_QL70_FMwebp_.jpg",
      description:
          "Calmbee Cat Tree Cat Tower Cat Scratching Post, Purple Cute Cat Tree for Indoor Cats, Natural Sisal Cat Climbing Activity Trees with Hammock & Stairs for Cats Kittens Pets Small Cat (Style 3)",
      price: 6665,
      status: "pending",
      stock: 12,
      qty: null),
  ProductModel(
      id: "4",
      name: "Toy Set",
      image:
          "https://m.media-amazon.com/images/I/712dNBnPw+L._AC_UF350,350_QL80_.jpg",
      description:
          "21 PCS Cat Toy Set Cat Toys Variety Pack, Cat Toy Set with Balls Feather Toy, Cat Toy Pack, Kitten Mouse Toy Set, Cat Toys Variety Pack",
      isFavourite: false,
      price: 665,
      status: "pending",
      stock: 12,
      qty: null),
];
