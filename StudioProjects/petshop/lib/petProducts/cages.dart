import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:petshop/screens/appbar/Notificationpage.dart';
import 'package:petshop/cart/cartpage.dart';
import 'package:petshop/firebase_helper/prodctmodel.dart';
import 'package:petshop/cart/productdetails.dart';
import 'package:petshop/model/provider.dart';
import 'package:petshop/model/routes.dart';
import 'package:provider/provider.dart';

class CagesPage extends StatefulWidget {
  const CagesPage({super.key});

  @override
  State<CagesPage> createState() => _CagesPageState();
}

class _CagesPageState extends State<CagesPage> {
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
        title: const Text("Cages"),
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
                              // Navigator.push(
                              //     context,
                              //     MaterialPageRoute(
                              //         builder: (context) => const FoodPage()));
                            },
                            child: const Text("DOG")),
                        TextButton(
                            onPressed: () {
                              // Navigator.push(
                              //     context,
                              //     MaterialPageRoute(
                              //         builder: (context) => const FoodPage()));
                            },
                            child: const Text("PUPPY")),
                        TextButton(
                            onPressed: () {
                              // Navigator.push(
                              //     context,
                              //     MaterialPageRoute(
                              //         builder: (context) => const FoodPage()));
                            },
                            child: const Text("CAT")),
                        TextButton(
                            onPressed: () {
                              // Navigator.push(
                              //     context,
                              //     MaterialPageRoute(
                              //         builder: (context) => const FoodPage()));
                            },
                            child: const Text("KITTEN")),
                        TextButton(
                            onPressed: () {
                              // Navigator.push(
                              //     context,
                              //     MaterialPageRoute(
                              //         builder: (context) => const FoodPage()));
                            },
                            child: const Text("BIRDS")),
                        TextButton(
                            onPressed: () {
                              // Navigator.push(
                              //     context,
                              //     MaterialPageRoute(
                              //         builder: (context) => const FoodPage()));
                            },
                            child: const Text("FISH")),
                        TextButton(
                            onPressed: () {
                              // Navigator.push(
                              //     context,
                              //     MaterialPageRoute(
                              //         builder: (context) => const FoodPage()));
                            },
                            child: const Text("RABBIT")),
                        TextButton(
                            onPressed: () {
                              // Navigator.push(
                              //     context,
                              //     MaterialPageRoute(
                              //         builder: (context) => const FoodPage()));
                            },
                            child: const Text("DUCK")),
                        TextButton(
                            onPressed: () {
                              // Navigator.push(
                              //     context,
                              //     MaterialPageRoute(
                              //         builder: (context) => const FoodPage()));
                            },
                            child: const Text("HEN")),
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
                        hintText: "Search for Cages and more...."),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            SizedBox(
              child: CarouselSlider(
                options: CarouselOptions(
                  aspectRatio: 16 / 9,
                  viewportFraction: 1,
                ),
                items: [
                  // Replace the Image.network with your own images
                  Image.network(
                    "https://img.freepik.com/premium-psd/poster-your-business-with-cute-puppy-wooden-cage-as-background_634423-2964.jpg",
                    fit: BoxFit.contain,
                  ),
                  Image.network(
                    "https://m.media-amazon.com/images/S/aplus-media-library-service-media/df041f33-fbcf-4d15-96be-4d6f3966f236.__CR0,0,970,600_PT0_SX970_V1___.jpg",
                    fit: BoxFit.cover,
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
              "Pick For Pet",
              style: TextStyle(fontSize: 25, color: Colors.purple),
            ),
            const SizedBox(
              height: 10,
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
      name: "Crate",
      stock: 17,
      image:
          "https://m.media-amazon.com/images/I/71qjN2JNCcL._AC_UF1000,1000_QL80_.jpg",
      description:
          "24x7 eMall Pet Travel Carrier Dog Cat Crate Plastic Handle Hinged Door Folding Collapsible Kennel Transport Box Crate Pet Cage (Regular - 19.5 x 13 x 12.5 Inch)",
      isFavourite: false,
      price: 1499,
      status: "pending",
      qty: null),
  ProductModel(
      id: "2",
      name: "Dog Cage",
      stock: 10,
      image:
          "https://5.imimg.com/data5/SELLER/Default/2022/8/WS/YW/LQ/30764310/whatsapp-image-2022-08-10-at-2-02-06-pm-500x500.jpeg",
      description: "Cages for dog and cat",
      isFavourite: false,
      price: 2300,
      status: "pending",
      qty: null),
  ProductModel(
      id: "3",
      image: "https://m.media-amazon.com/images/I/91XQ7mhS-IL._SX450_.jpg",
      description:
          "AVI CRAVE Bird cage Large 2.5 feet for Birds,Parrot,Finches,Love Birds, with 2 Perch Stick,Cuttlefish Bone Holder,with Cuttlefish Bone,2 gate to Install breeding Box,Anti Bird Escape Lock (Black)",
      name: "Bird Cage",
      isFavourite: false,
      price: 3100,
      status: "pending",
      stock: 10,
      qty: null),
  ProductModel(
      id: "4",
      name: "Bird Cage",
      isFavourite: false,
      image: "https://m.media-amazon.com/images/I/513uSn3r5TL._SY450_.jpg",
      description:
          "Central Fish Aquarium Bird cage for Budgies,Finches,Love Birds,Cuttlefish BoneHolder,Cuttlefish Bone, 1perch,2 Cups (30 x 23 x 49 cms)(Colors May Vary) C16",
      status: "pending",
      price: 1200,
      stock: 16,
      qty: null),
  ProductModel(
      id: "5",
      image:
          "https://m.media-amazon.com/images/I/31fgby2e3pL._AC_UF1000,1000_QL80_.jpg",
      description: "CoLoraquariumsupplies 2L Glass Fish Bowl 8 inch (Upto 4L)",
      name: "Fish bowl",
      isFavourite: false,
      price: 198,
      status: "pending",
      stock: 15,
      qty: null),
  ProductModel(
      id: "6",
      name: "Aquarium",
      isFavourite: false,
      image: "https://m.media-amazon.com/images/I/71x23ro-2ML._SY450_.jpg",
      description:
          "JAINSONS PET PRODUCTS Aquarium Glass Tank Aquarium Tank for Home with Light and Filter Aquarium Tank Set (22 Liter) Model MJ-360 (Color May Vary)",
      status: "pending",
      price: 3799,
      stock: 12,
      qty: null),
];
