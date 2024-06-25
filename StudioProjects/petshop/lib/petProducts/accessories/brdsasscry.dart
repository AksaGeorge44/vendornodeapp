import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:petshop/screens/appbar/Notificationpage.dart';
import 'package:petshop/cart/cartpage.dart';
import 'package:petshop/firebase_helper/prodctmodel.dart';
import 'package:petshop/cart/productdetails.dart';
import 'package:petshop/model/provider.dart';
import 'package:petshop/model/routes.dart';
import 'package:provider/provider.dart';

class BirdAccsryPage extends StatefulWidget {
  const BirdAccsryPage({super.key});

  @override
  State<BirdAccsryPage> createState() => _BirdAccsryPageState();
}

class _BirdAccsryPageState extends State<BirdAccsryPage> {
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
        title: const Text("Bird Accessory"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 40,
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
                    "https://cdn11.bigcommerce.com/s-9hte4zottw/images/stencil/original/image-manager/aviators-1284x600-2023.jpg?t=1687958223",
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
      name: "Bird Toy Set",
      stock: 10,
      image:"https://m.media-amazon.com/images/I/51EyXt-Lf1L._SY355_.jpg",
      description:"Bird Toy Set Ladders, Hanging Swings Toys Cage Accessories for Love Birds, Budgies, Finches. (Ladder 1piece Twelve Steps, Oval Swing 1pieces, Round Swing 1piece Multi Color)",
      isFavourite: false,
      price: 699,
      status: "pending",
      qty: null),
  ProductModel(
      id: "2",
      name: "Birds Cage",
      stock: 12,
      image:"https://m.media-amazon.com/images/I/71A-aBS11-L._SY355_.jpg",
      description:
      "Petzlifeworld Bird Cage Hanging Ring Swing Toy (2 Pcs) + Plastic Climb Ladder Toy (1 Pcs) + Bell Ball Toy (2 Pcs) Combo for Cockatiel, Love Bird, Budgie, Finches, Macaws, Conures, Sparrow, etc.",
      isFavourite: false,
      price: 219,
      status: "pending",
      qty: null),
 
];
