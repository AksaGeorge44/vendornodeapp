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

class FishprdctPage extends StatefulWidget {
  const FishprdctPage({super.key});

  @override
  State<FishprdctPage> createState() => _FishprdctPageState();
}

class _FishprdctPageState extends State<FishprdctPage> {
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
        title: const Text("Fish Products"),
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
                                    child: const Text("BOWL")),
                                TextButton(
                                    onPressed: () {},
                                    child: const Text("AQUARIUM")),
                                TextButton(
                                    onPressed: () {},
                                    child: const Text("PEBBLES")),
                                TextButton(
                                    onPressed: () {},
                                    child: const Text("PLANTS")),
                                TextButton(
                                    onPressed: () {},
                                    child: const Text("MEDICINES")),
                                TextButton(
                                    onPressed: () {},
                                    child: const Text("SUPPLEMENTS")),
                                TextButton(
                                    onPressed: () {},
                                    child: const Text("OXYGEN PUMP")),
                                TextButton(
                                    onPressed: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  const DogcarePage()));
                                    },
                                    child: const Text("FISH CARE")),
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
                      aspectRatio: 16 / 9, viewportFraction: 1, autoPlay: true),
                  items: [
                    // Replace the Image.network with your own images
                    Image.network(
                      "https://5.imimg.com/data5/SELLER/Default/2022/2/GB/OO/CH/148006569/taiyo-fish-food-super-premium-formula-3-in-1-on-sale-today-500x500.jpg",
                      fit: BoxFit.contain,
                    ),

                    Image.network(
                      "https://www.bigbasket.com/media/uploads/p/m/40224511-7_1-drools-finsters-fish-food.jpg",
                      fit: BoxFit.cover,
                    ),

                    // Add more images as needed
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 20,
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
      name: "Taiyo",
      image:
          "https://m.media-amazon.com/images/I/61d-TebyEoL._AC_UF1000,1000_QL80_.jpg",
          stock: 10,
      description:
          "TAIYO Highly Nutritious Floating Pellet Fish Food for all Tropical Life Stage with Color Enhancing Formula |1 Kg Pouch | Size -5 mm",
      isFavourite: false,
      price: 288,
      status: "pending",
      qty: null),
  ProductModel(
    stock: 35,
      id: "2",
      name: "Taiyo pluss",
      image: "https://m.media-amazon.com/images/I/61z9PBx+ExL._SY450_.jpg",
      description:
          "Taiyo Pluss Discovery Special Fish Food For All Life Stages - 1 Kg (1.2 mm Pellets) Pouch | Daily Nutrition Grow Feed for all Tropical and Koi Fishes",
      isFavourite: false,
      price: 300,
      status: "pending",
      qty: null),
  ProductModel(
      id: "3",
      stock: 36,
      name: "Tunai",
      image: "https://m.media-amazon.com/images/I/71MGQvD1d7L._SY450_.jpg",
      description:
          "TUNAI Fish Food for Aquarium with 26% Protien | Aquarium Fish Food for All Small and Medium Tropical Fishes| Daily Nutrition Pellet Fish Feed for Health & Growth | 100g",
      isFavourite: false,
      price: 125,
      status: "pending",
      qty: null),
  ProductModel(
      id: "4",
      stock: 15,
      name: "Taiyo pluss",
      image: "https://m.media-amazon.com/images/I/61hUoGj8uNL._SY450_.jpg",
      description:
          "Taiyo Pluss Discovery Turtle Premium 1 kg (Pack of 1) by TED TABBIES",
      isFavourite: false,
      status: "pending",
      price: 250,
      qty: null),
];
