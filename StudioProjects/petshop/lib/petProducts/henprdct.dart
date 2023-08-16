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

class HenprdctPage extends StatefulWidget {
  const HenprdctPage({super.key});

  @override
  State<HenprdctPage> createState() => _HenprdctPageState();
}

class _HenprdctPageState extends State<HenprdctPage> {
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
              child: CarouselSlider(
                options: CarouselOptions(
                  aspectRatio: 16 / 9,
                  viewportFraction: 1,
                ),
                items: [
                  // Replace the Image.network with your own images
                  Image.network(
                    "https://static.toiimg.com/thumb/msid-94206337,width-400,resizemode-4/94206337.jpg",
                    fit: BoxFit.contain,
                  ),

                  // Add more images as needed
                ],
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
      name: "MZON",
      image: "https://m.media-amazon.com/images/I/81eTTkAoEuL._SY355_.jpg",
      stock: 10,
      description:
          "MZON Premium Grower Baby Chicken/CHICK'S Pellet Feed (Hen,Duck, BATER, EMU & Other) (Pack of 1)",
      isFavourite: false,
      price: 240,
      status: "pending",
      qty: null),
  ProductModel(
      id: "2",
      stock: 20,
      name: "REFIT",
      image: "https://m.media-amazon.com/images/I/716lnLirlbL._SY355_.jpg",
      description:
          "REFIT ANIMAL CARE Broiler Feed Supplement | Broiler Growth Promoter | Poultry Broiler Weight Gainer | Broiler Chicken Weight Gain Powder (Pack of 5Kg) - Broiler+",
      isFavourite: false,
      price: 1144,
      status: "pending",
      qty: null),
  ProductModel(
      id: "3",
      name: "VC",
      isFavourite: false,
      stock: 26,
      image:
          "https://m.media-amazon.com/images/I/41qUeaugoRL._SX300_SY300_QL70_FMwebp_.jpg",
      description:
          "VC™ (Pre-Starter) Ideal for Duck, Quail, emu, Turkey, Layer, Rooster, Country,Broiler.",
      price: 240,
      status: "pending",
      qty: null),
  ProductModel(
      id: "4",
      stock: 16,
      name: "Starter",
      isFavourite: false,
      image:
          "https://m.media-amazon.com/images/I/415PehVueAL._SX300_SY300_QL70_FMwebp_.jpg",
      description:
          "VC™ (Starter) Ideal for Duck, Quail, emu, Turkey, Layer, Rooster, Country,Broiler.",
      status: "pending",
      price: 215,
      qty: null),
];
