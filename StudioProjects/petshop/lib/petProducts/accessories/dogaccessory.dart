import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:petshop/screens/appbar/Notificationpage.dart';
import 'package:petshop/cart/cartpage.dart';
import 'package:petshop/firebase_helper/prodctmodel.dart';
import 'package:petshop/cart/productdetails.dart';
import 'package:petshop/model/provider.dart';
import 'package:petshop/model/routes.dart';
import 'package:provider/provider.dart';

class DogAccsryPage extends StatefulWidget {
  const DogAccsryPage({super.key});

  @override
  State<DogAccsryPage> createState() => _DogAccsryPageState();
}

class _DogAccsryPageState extends State<DogAccsryPage> {
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
        title: const Text("Dog Accessory"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 10,
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
                    "https://media-cldnry.s-nbcnews.com/image/upload/newscms/2022_37/3571392/210507-dog-toys-bd-2x1_0.jpg",
                    fit: BoxFit.fill,
                  ),

                  Image.network(
                    "https://cdn.shopify.com/s/files/1/1199/8502/files/Schesir_Mobile_1.webp?v=1686914771",
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
      name: "Puppy kit",
      stock: 10,
      image: "https://m.media-amazon.com/images/I/81l+OhAi37L._SY355_.jpg",
      description:
          "Puppy Starter Kit - 23pc Puppy Supplies & Dog Essentials. Matching New Puppy Accessories . Lots of Puppy Stuff. Puppy Training Kit, Dog Blanket, Lick Mat, & More. Kit for Small Dogs or Large Puppies",
      isFavourite: false,
      price: 12445,
      status: "pending",
      qty: null),
  ProductModel(
      id: "2",
      name: "Ball ",
      stock: 100,
      image:
          "https://m.media-amazon.com/images/I/41CGRjUiMEL._SX300_SY300_QL70_FMwebp_.jpg",
      description:
          "Cature Dog Squeaky Dog Ball Toys,Dogs Chew Paw Print Ball,Dog Pool Toy,Dog Balls Rubber,Toss Fetch Toys for Puppy Rubber TPR, Dog Chew Toys for Boredom,Teeth Cleaning for Small Snake Cover(Orange)",
      isFavourite: false,
      price: 145,
      status: "pending",
      qty: null),
  ProductModel(
      id: "3",
      name: "Bone Toy",
      image: "https://m.media-amazon.com/images/I/71y9ChQjJJL._SY355_.jpg",
      description:
          "Nylabone Just for Puppies Extra Small Pacifier Bone Puppy Dog Teething Chew Toy",
      isFavourite: false,
      price: 2665,
      status: "pending",
      stock: 12,
      qty: null),
  ProductModel(
      id: "4",
      name: "Dog Collar",
      isFavourite: false,
      stock: 12,
      image:
          "https://m.media-amazon.com/images/I/81Ycrk4Vu-L._AC_UF1000,1000_QL80_.jpg",
      description:
          "FURRYWISE Dog Collar and Dog Leash - Reflective, Durable, Comfortable, Adjustable Dog Accessories - Dog Belt and Leash Combo for Small, Medium and Large Dogs",
      status: "pending",
      price: 711,
      qty: null),
];
