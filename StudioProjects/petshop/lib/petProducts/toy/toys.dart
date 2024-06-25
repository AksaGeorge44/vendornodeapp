import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:petshop/petProducts/toy/cattoy.dart';
import 'package:petshop/petProducts/toy/dogtoy.dart';
import 'package:petshop/screens/appbar/Notificationpage.dart';
import 'package:petshop/cart/cartpage.dart';
import 'package:petshop/firebase_helper/prodctmodel.dart';
import 'package:petshop/cart/productdetails.dart';
import 'package:petshop/model/provider.dart';
import 'package:petshop/model/routes.dart';
import 'package:provider/provider.dart';

class ToysPage extends StatefulWidget {
  
  const ToysPage({super.key});

  @override
  State<ToysPage> createState() => _ToysPageState();
}

class _ToysPageState extends State<ToysPage> {

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
                          builder: (context) =>  const CartScreen()));
                },
                child: const Icon(Icons.shopping_cart)),
          ),
        ],
        title: const Text("Toys"),
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
                                      builder: (context) => const DogToyPage()));
                            },
                            child: const Text("DOG")),
                       
                        TextButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const CAttoyPage()));
                            },
                            child: const Text("CAT")),
                       
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
                        hintText: "Search for Toys and more...."),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            SizedBox(
              height: 160,
              width: 300,
              child: CarouselSlider(
                options: CarouselOptions(
                  aspectRatio: 16 / 9,
                  viewportFraction: 1,
                ),
                items: [
                  // Replace the Image.network with your own images
                  Image.network(
                    "https://cdn.media.amplience.net/i/petsathome/hp-promo-large-shopalldogtoys-mb?w=700&",
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
              "New Deals",
              style: TextStyle(fontSize: 24, color: Colors.black),
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
      stock: 14,
      name: "Toy Ball",
      image:
          "https://rukminim2.flixcart.com/image/850/1000/xif0q/pet-toy/f/8/c/1-pet-squeaker-made-of-plastic-maycreate-original-imaghcxywmjrugvg.jpeg?q=90",
      description:
          "HASTHIP Interactive Toy Ball for Dogs, Dog Toy Fun Bouncing Giggle Ball,PVC Dog Molar  (Green)",
      isFavourite: false,
      price: 799,
      status: "pending",
      qty: null),
  ProductModel(
      id: "2",
      name: "Toy Chew Bone",
      stock: 10,
      image: "https://img.fruugo.com/product/8/91/700650918_max.jpg",
      description:
          "Dog Chew Toy Bone - Tpr Rubber Petal Bone Shape Indestructible Dog Toy ",
      isFavourite: false,
      price: 705,
      status: "pending",
      qty: null),
  ProductModel(
      id: "3",
      name: "Toy Set",
      image:
          "https://m.media-amazon.com/images/I/81zo+JCCb1L._AC_SY300_SX300_.jpg",
          stock: 16,
      description:
          "Dog Chew Toys 20 Pack Indestructible Pet Interactive Tug of War Rope Toys for Puppies Chewers, Small Dogs Durable Squeaky Toys for Boredom Chew Teething",
      isFavourite: false,
      price: 1999,
      status: "pending",
      qty: null),
  ProductModel(
      id: "4",
      stock: 10,
      name: "Comboset",
      image: "https://m.media-amazon.com/images/I/71+cmdeLvFS._SY450_.jpg",
      description:
          "BLACKDOG Puppies Combo Toys for Dogs Squeaky Chew Ball Toy, Two Knot Chew Rope Toy, Nylon Chew Bone Toys for Puppies - Pack of 3",
      isFavourite: false,
      status: "pending",
      price: 167,
      qty: null),
];
