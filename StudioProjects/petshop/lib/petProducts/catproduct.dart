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

class CatprdctPage extends StatefulWidget {
  const CatprdctPage({super.key});

  @override
  State<CatprdctPage> createState() => _CatprdctPageState();
}

class _CatprdctPageState extends State<CatprdctPage> {
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
        title: const Text("Cat Products"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 40),
              child: SizedBox(
                width: double.infinity,
                //color: Colors.black,
                child: Column(
                  children: [
                    Row(
                      children: [
                        TextButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const HomePage()));
                            },
                            child: const Text("HOME")),
                        TextButton(
                            onPressed: () {}, child: const Text("KITTEN")),
                        TextButton(
                            onPressed: () {}, child: const Text("ADULT")),
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
                    )
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
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
                          hintText: "Search for Prodcts, Medicines...."),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: categoriesList
                    .map(
                      (e) => Padding(
                        padding: const EdgeInsets.only(left: 15),
                        child: Card(
                          color: Colors.white,
                          elevation: 3.0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: SizedBox(
                            height: 70,
                            width: 70,
                            child: Image.network(e),
                          ),
                        ),
                      ),
                    )
                    .toList(),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: SizedBox(
                height: 250,
                width: 500,
                child: CarouselSlider(
                  options: CarouselOptions(
                      aspectRatio: 16 / 9, viewportFraction: 1, autoPlay: true),
                  items: [
                    // Replace the Image.network with your own images
                    Image.network(
                      "https://www.petland.ca/cdn/shop/files/AugLong2023.jpg?v=1691156018",
                      fit: BoxFit.contain,
                    ),
                    Image.network(
                      "https://img.freepik.com/free-vector/hand-drawn-cat-food-youtube-thumbnail_23-2149199454.jpg",
                      fit: BoxFit.contain,
                    ),

                    // Add more images as needed
                  ],
                ),
              ),
            ),
            const Text(
              "Best Deals",
              style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  color: Colors.black),
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
                                                        Text("M.R.P: \$${singleProduct.price}"),

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

List<String> categoriesList = [
  "https://supervet.in/wp-content/uploads/2021/03/ezgif.com-webp-to-png7.png",
  "https://images-na.ssl-images-amazon.com/images/I/816oI-onrYL._AC_UL330_SR330,330_.jpg",
  "https://image.chewy.com/is/image/catalog/212447_main._AC_SL600_V1580742780_.jpg",
  "https://m.media-amazon.com/images/I/31OjLT8FWZS._SX300_SY300_QL70_FMwebp_.jpg",
  "https://5.imimg.com/data5/SELLER/Default/2021/5/ZN/RW/XU/89400773/buraq-pets-cat-dog-accessories--500x500.jpeg",
  "https://m.media-amazon.com/images/I/4151PoRaaOL._AC_SS300_.jpg",
  "https://m.media-amazon.com/images/I/41najSl8TvL._SY300_SX300_QL70_FMwebp_.jpg",
];

List<ProductModel> bestProducts = [
  ProductModel(
      id: "1",
      name: "Signature Grain",
      stock: 13,
      image:
          "https://m.media-amazon.com/images/I/51KAsAf95yL._AC_UF1000,1000_QL80_.jpg",
      description:
          "Signature Grain Zero Persian & Long Coat Cat Food - 7 kg - Ocean Fish Sardine & Mackerel",
      isFavourite: false,
      price: 1700,
      status: "pending",
      qty: null),
  ProductModel(
      id: "2",
      stock: 15,
      name: "Royal canin",
      image:
          "https://m.media-amazon.com/images/I/512eKdJzhkL._SY450_PIbundle-12,TopRight,0,0_SX446SY450SH20_.jpg",
      description:
          "Royal Canin Intense Beauty Gravy Adult Cat Seafood, 85g (12 Pack)",
      isFavourite: false,
      price: 1159,
      status: "pending",
      qty: null),
  ProductModel(
      id: "3",
      name: "Cat health food",
      stock: 14,
      image:
          "https://m.media-amazon.com/images/I/71A5NLIG-dL._SY450_PIbundle-2,TopRight,0,0_AA450SH20_.jpg",
      description: "Meat Up Adult Cat Food, 3 kg (Buy 1 Get 1 Free )",
      isFavourite: false,
      price: 948,
      status: "pending",
      qty: null),
  ProductModel(
      id: "4",
      name: "Whiskas",
      stock: 16,
      image: "https://m.media-amazon.com/images/I/7181YKTnfaL._SY450_.jpg",
      description:
          "Whiskas Adult (+1 year) Dry Cat Food Food, Tuna Flavour, 7kg Pack",
      isFavourite: false,
      status: "pending",
      price: 2115,
      qty: null),
];
