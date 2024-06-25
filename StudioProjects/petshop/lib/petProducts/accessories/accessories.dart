import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:petshop/petProducts/accessories/brdsasscry.dart';
import 'package:petshop/petProducts/accessories/catassry.dart';
import 'package:petshop/petProducts/accessories/dogaccessory.dart';
import 'package:petshop/petProducts/accessories/fishacssry.dart';
import 'package:petshop/screens/appbar/Notificationpage.dart';
import 'package:petshop/cart/cartpage.dart';
import 'package:petshop/firebase_helper/prodctmodel.dart';
import 'package:petshop/cart/productdetails.dart';
import 'package:petshop/model/provider.dart';
import 'package:petshop/model/routes.dart';
import 'package:provider/provider.dart';

class AccessoryPage extends StatefulWidget {
  const AccessoryPage({super.key});

  @override
  State<AccessoryPage> createState() => _AccessoryPageState();
}

class _AccessoryPageState extends State<AccessoryPage> {
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

  List<ProductModel> productModelList = [];

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
        title: const Text("Accessories"),
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
                                      builder: (context) => const DogAccsryPage()));
                            },
                            child: const Text("DOG")),
                      
                        TextButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const CatAccsryPage()));
                            },
                            child: const Text("CAT")),
                      
                        TextButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const BirdAccsryPage()));
                            },
                            child: const Text("BIRDS")),
                        TextButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const FishAccsryPage()));
                            },
                            child: const Text("FISH")),
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
                        hintText: "Search for Accessories and more...."),
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
                    "https://img-us.aosomcdn.com/430/110_activity/2023/03/17/4Xy2a9186ed28de23.jpg",
                    fit: BoxFit.fill,
                  ),

                  // Add more images as needed
                ],
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            const Text(
              "Super Save",
              style: TextStyle(fontSize: 22, color: Colors.black),
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
      name: "Pet Collar",
      image:
          "https://m.media-amazon.com/images/I/51cDkTl0gjL._SY300_SX300_QL70_FMwebp_.jpg",
          stock: 22,
      description:
          "Nylon Reflective Safe Pets Collar Breakaway Safety Cat Dog Puppy Kitten Collars with Bells (Red)",
      isFavourite: false,
      price: 199,
      status: "pending",
      qty: null),
  ProductModel(
      id: "2",
      name: "Collar ",
      description:
          "Pets First Collegiate Pet Accessories, Cat Collar, Ohio State Buckeyes, One Size",
          stock: 24,
      image:
          "https://images-cdn.ubuy.co.in/6365f1956d6a6747f23524d3-pets-first-collegiate-pet-accessories.jpg",
      isFavourite: false,
      price: 705,
      status: "pending",
      qty: null),
  ProductModel(
      id: "3",
      name: "Boho Bark",
      image:
          "https://m.media-amazon.com/images/I/51lqWz1HE7L._AC_UF1000,1000_QL80_.jpg",
          stock: 22,
      description:
          "BohoBark Cat & Dog Collar Adjustable Safety Buckle Dog Cat Accessories Fashion Checkered Bow tie with Bell Pack of 1 (Baby Pink, Checkered No .1)",
      isFavourite: false,
      price: 199,
      status: "pending",
      qty: null),
  ProductModel(
      id: "4",
      image:
          "https://m.media-amazon.com/images/I/41mOH7sbr3L._SX300_SY300_QL70_FMwebp_.jpg",
      description:
          "The Pets Company Cat Harness Leash Set for Cats & Kittens, 45 Inches Red",
          stock: 33,
      name: "Leash",
      isFavourite: false,
      status: "pending",
      price: 167,
      qty: null),
  ProductModel(
      id: "5",
      name: "Collar Bell",
      isFavourite: false,
      image: "https://m.media-amazon.com/images/I/71dw7YopJNL._SY450_.jpg",
      stock: 22,
      description:
          "Agirav Adjustable Safety Velvet Collar Bell Buckle Neck Strap for Kitten Cat Puppy (Black)",
      price: 235,
      status: "pending",
      qty: null),
  ProductModel(
      id: "6",
      name: "Comb Brush",
      image: "https://m.media-amazon.com/images/I/71sJqfP64aS._SX450_.jpg",
      stock: 12,
      description:
          "Qpets® Slicker Dog Comb Brush Pet Grooming Brush Daily Use to Clean Loose Fur & Dirt Great for Dogs and Cats with Medium Long Hair Dog Hair Deshedding Brush-Blue",
      isFavourite: false,
      price: 245,
      status: "pending",
      qty: null),
];
