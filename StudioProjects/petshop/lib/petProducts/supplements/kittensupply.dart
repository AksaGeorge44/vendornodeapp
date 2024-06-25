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

class KittenSupplyPage extends StatefulWidget {
  const KittenSupplyPage({super.key});

  @override
  State<KittenSupplyPage> createState() => _KittenSupplyPageState();
}

class _KittenSupplyPageState extends State<KittenSupplyPage> {
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
        title: const Text("Kitten Supplements"),
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
                                          const DogcarePage()));
                            },
                            child: const Text("CAT CARE")),
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
                    aspectRatio: 16 / 9, viewportFraction: 1, 
                    ),
                items: [

                  // Replace the Image.network with your own images
                  Image.network(
                    "https://m.media-amazon.com/images/S/aplus-media-library-service-media/01bbe679-5f05-40bc-a1f7-b94aa4033605.__CR0,0,1464,600_PT0_SX1464_V1___.jpg",
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
      name: "Palamountains",
      image: "https://m.media-amazon.com/images/I/41z5KwYvBAL._SX300_SY300_QL70_FMwebp_.jpg",
      isFavourite: false,
      price: 1425,
      description: "Palamountains My Beau Cat Supplement Vitamin & Mineral 300-ml",
      status: "pending",
      stock: 15,
      qty: null),
  ProductModel(
      id: "2",
      name: "WOW",
          stock: 30,
      isFavourite: false,
      image: "https://m.media-amazon.com/images/I/41o0SCtIZ4L._SX300_SY300_QL70_FMwebp_.jpg",
      description: "WOW DOG Chewable Calcium Tablet - Calcium for Dogs Supplement with Vitamin D3, B12, Magnesium & Zinc | Chicken Flavour - 120 Tablets",
      price: 499,
      status: "pending",
      
      
      qty: null),
  ProductModel(
      id: "3",
      name: "Virbac Tablet",
      stock: 16,
      isFavourite: false,
      price: 225,
      image: "https://m.media-amazon.com/images/I/41SZog4HUAL._SX355_.jpg",
      description: "Virbac Nutrich Tablets 60 Pieces Minerals and Vitamins Supplement for Dog & Cat, 60 Count",
      status: "pending",
      qty: null),
  ProductModel(
      id: "4",
      name: "Henlo",
      stock: 12,
      isFavourite: false,
      description: "Henlo Everyday Nutrition Topper | Dog Supplement and Multivitamin | Improved Skin & Coat, Joint Support, Heart, and Gut Health Human Grade Ingredients | All Life Stages | 100g",
    image: "https://m.media-amazon.com/images/I/31Bx9GIYmML._SX300_SY300_QL70_FMwebp_.jpg",
      status: "pending",
      price: 434,
      qty: null),
];