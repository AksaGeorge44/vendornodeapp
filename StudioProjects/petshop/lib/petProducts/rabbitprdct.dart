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

class RabbitprdctPage extends StatefulWidget {
  const RabbitprdctPage({super.key});

  @override
  State<RabbitprdctPage> createState() => _RabbitprdctPageState();
}

class _RabbitprdctPageState extends State<RabbitprdctPage> {
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
        title: const Text("Rabbit Products"),
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
                                    child: const Text("RABBIT CARE")),
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
                      "https://m.media-amazon.com/images/S/aplus-media-library-service-media/235b89c3-9de4-4b27-a3f3-e69492971b93.__CR0,0,970,600_PT0_SX970_V1___.png",
                      fit: BoxFit.contain,
                    ),

                    Image.network(
                      "https://m.media-amazon.com/images/S/aplus-media-library-service-media/98e13588-ab26-4dba-b164-cb5c5e9c64f9.__CR0,0,970,600_PT0_SX970_V1___.png",
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
                          padding: const EdgeInsets.all(12),
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
      name: "Petslife",
      stock: 10,
      image: "https://m.media-amazon.com/images/I/51b13FfnasL._SY355_.jpg",
      description:
          "PETSLIFE Premium Rabbit Food with Essential Nutrients and High Fibre Content for Small & Adult Bunnies ,1kg",
      isFavourite: false,
      price: 600,
      status: "pending",
      qty: null),
  ProductModel(
      id: "2",
      name: "Boltz",
      image:
          "https://m.media-amazon.com/images/I/51iD43eP3LL._SX300_SY300_QL70_FMwebp_.jpg",
          stock: 10,
      description:
          "Boltz Premium Adult Pellet Rabbit Food, Nutritionist Choice (Rabbit Food 1.2KG)",
      isFavourite: false,
      price: 425,
      status: "pending",
      qty: null),
  ProductModel(
      id: "3",
      name: "Boltz",
      image:
          "https://m.media-amazon.com/images/I/71OT7hHvi+L._SY355_PIbundle-2,TopRight,0,0_SX343SY355SH20_.jpg",
      description:
          "BOLTZ Rabbit Litter Spray 200 ml and Rabbit Food 1.2 Kg Combo (Rabbit Litter Spray + Rabbit Food)",
      isFavourite: false,
      price: 645,
      status: "pending",
      stock: 10,
      qty: null),
  ProductModel(
      id: "4",
      name: "Zupreem",
      isFavourite: false,
      image: "https://m.media-amazon.com/images/I/81khzQqwp9L._SY450_.jpg",
      stock: 10,
      description:
          "Zupreem Nature's Promise Hay for Pet Rabbit of All Life Stages, Variety Flavour, 397 G",
      status: "pending",
      price: 586,
      qty: null),
];
