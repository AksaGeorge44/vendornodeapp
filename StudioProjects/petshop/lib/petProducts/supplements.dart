import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:petshop/screens/appbar/Notificationpage.dart';
import 'package:petshop/cart/cartpage.dart';
import 'package:petshop/firebase_helper/prodctmodel.dart';
import 'package:petshop/cart/productdetails.dart';
import 'package:petshop/petProducts/foodpage.dart';
import 'package:petshop/model/provider.dart';
import 'package:petshop/model/routes.dart';
import 'package:provider/provider.dart';

class SupplementsPage extends StatefulWidget {
  const SupplementsPage({super.key});

  @override
  State<SupplementsPage> createState() => _SupplementsPageState();
}

class _SupplementsPageState extends State<SupplementsPage> {
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
        title: const Text("Supplements"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 10,
            ),
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
                                      builder: (context) => const FoodPage()));
                            },
                            child: const Text("DOG")),
                        TextButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const FoodPage()));
                            },
                            child: const Text("PUPPY")),
                        TextButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const FoodPage()));
                            },
                            child: const Text("CAT")),
                        TextButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const FoodPage()));
                            },
                            child: const Text("KITTEN")),
                        TextButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const FoodPage()));
                            },
                            child: const Text("BIRDS")),
                        TextButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const FoodPage()));
                            },
                            child: const Text("FISH")),
                        TextButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const FoodPage()));
                            },
                            child: const Text("RABBIT")),
                        TextButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const FoodPage()));
                            },
                            child: const Text("DUCK")),
                        TextButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const FoodPage()));
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
                        hintText: "Search for Supplements and more...."),
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
                    "https://dr-shiba.com/cdn/shop/files/COM-Desktop_PH_1_460x@2x.jpg?v=1691386420",
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
      name: "Pet Royale",
      stock: 10,
      image: "https://m.media-amazon.com/images/I/6154SYxeLyL.jpg",
      description:
          "Pet Royale Dog Skin and Coat Supplement for Dog | Skin Coat for Dog Puppy Kitten | Dog Supplement multivitamin | Dog Skin Care | Dog Supplements | Protein | Pack of 1 | 60 Tablets",
      isFavourite: false,
      price: 445,
      status: "pending",
      qty: null),
  ProductModel(
      id: "2",
      name: "Petvit ",
      stock: 12,
      image: "https://m.media-amazon.com/images/I/51PBUjqIAlL._SY450_.jpg",
      description:
          "Petvit Skin & Coat Tablets for Dogs Promotes Healthy Skin & Shiny Coat - 60 Palatable Chewable Tablets | for All Age Group",
      isFavourite: false,
      price: 249,
      status: "pending",
      qty: null),
  ProductModel(
      id: "3",
      name: "Pet Royale",
      image: "https://m.media-amazon.com/images/I/61tiAanUKDL._SX679_.jpg",
      description:
          "Pet Royale Dog Supplement - Protein Powder for Dog/Cat/Pet - Control Coat Vitalizer, Omega 3, Shedding Control, Biotin, 40% Clean Protein Powder Blend – 400g Dog Growth Food Supplement",
      isFavourite: false,
      price: 665,
      status: "pending",
      stock: 12,
      qty: null),
  ProductModel(
      id: "4",
      name: "Furlicks",
      isFavourite: false,
      stock: 12,
      image: "https://m.media-amazon.com/images/I/71RVAV2GldL._SY450_.jpg",
      description:
          "Furlicks Skin & Coat Supplement for Dogs & Cats | Biotin (Vitamin B7), Omega 3 & 6 Fatty Acids and Chia Seeds for Thick & Shiny Fur, Healthy Skin & Reduced Shedding (30 Oral Dissolving Strips)",
      status: "pending",
      price: 711,
      qty: null),
  ProductModel(
      id: "5",
      name: "MultiVitamin",
      stock: 14,
      isFavourite: false,
      description:
          "WOW DOG Multivitamin Tablet Dog Supplement 120 Pieces for Dogs with Essential Vitamins & Minerals for Healthy Skin, Heart, Brain Function | Chicken Flavou",
      image:
          "https://m.media-amazon.com/images/I/41bYeRYFyUL._SX300_SY300_QL70_FMwebp_.jpg",
      price: 650,
      status: "pending",
      qty: null),
  ProductModel(
      id: "6",
      name: "Bark Out",
      image: "https://m.media-amazon.com/images/I/71a1pYCXvYL._SX466_.jpg",
      description:
          "Bark Out Loud by Vivaldis - Dog Pillow Skin & Coat, Rich in Omega 3FA, Chelated Zinc, and Biotin for Healthy Skin Dog Treats, Brewer’s Yeast for Shiny Coat, 100 gm",
      isFavourite: false,
      price: 300,
      stock: 15,
      status: "pending",
      qty: null),
  ProductModel(
      id: "7",
      name: "Feed Wale",
      image:
          "https://www.feedwale.com/wp-content/uploads/2021/08/Aquarium-Vitamin-C-Design-1.jpg",
      description:
          "FeedWale Aquarium Vitamin C 100gm Fish Feed Supplement for Better Growth of Ornamental Fishes",
      isFavourite: false,
      price: 249,
      status: "pending",
      stock: 20,
      qty: null),
  ProductModel(
      id: "8",
      name: "Aquaprob",
      image:
          "https://refitanimalcare.com/wp-content/uploads/2022/01/biofloc-probiotic-powder-for-fish-pond.webp",
      description:
          "Aqua Prob+ is a biofloc fish probiotic that adds healthy bacteria to the aquaculture to promote fish growth.",
      isFavourite: false,
      price: 200,
      status: "pending",
      stock: 20,
      qty: null),
  ProductModel(
      id: "9",
      name: "Nekton",
      stock: 20,
      image: "https://m.media-amazon.com/images/I/71RaeDzhYKL._SY450_.jpg",
      description: "Nekton-S Supplement For Birds",
      isFavourite: false,
      price: 4500,
      status: "pending",
      qty: null),
  ProductModel(
      id: "10",
      name: "Birdscare",
      stock: 20,
      image: "https://m.media-amazon.com/images/I/61oCQUF5-aL.jpg",
      description:
          "STAR FARMS Birds Care Birds Health Supplements for Improve Bird General Health Supplements - (500 ml) / Healthy Growth, Full Feathering & Brilliant Color",
      isFavourite: false,
      price: 549,
      status: "pending",
      qty: null),
  ProductModel(
      id: "11",
      name: "Prime",
      stock: 20,
      isFavourite: false,
      image:
          "https://hari.ca/wp-content/uploads/2019/02/Prime-82103_GroupRevised_2.3.png",
      description: "Prime Vitamin Mineral Amino Acid Supplement for Birds",
      price: 1500,
      status: "pending",
      qty: null),
  ProductModel(
    stock: 20,
      id: "12",
      name: "Wiggleboo",
      image: "https://m.media-amazon.com/images/I/61e8xP3dqLL._SY450_.jpg",
      description:
          "WiggleBoo Rabbit Pellet Food Rich in Vitamins D, Minerals,Calcium & Healthy Food for All Kinds of Rabbit Every Bite Have Nutrition (450gm)",
      isFavourite: false,
      price: 175,
      status: "pending",
      qty: null),
  ProductModel(
      id: "13",
      stock: 10,
      name: "Petslife",
      image: "https://m.media-amazon.com/images/I/51gukLmCanL._SY450_.jpg",
      description: "PETSLIFE Rabbit Premium Food 200g",
      isFavourite: false,
      price: 140,
      status: "pending",
      qty: null),
  ProductModel(
      id: "14",
      stock: 10,
      name: "Foodie Puppies",
      isFavourite: false,
      image: "https://m.media-amazon.com/images/I/61mZCk+hkiL._SX450_.jpg",
      description:
          "Foodie Puppies Rabbit Food Dry Pellets, Highly Premium Nutritious Diet - 1Kg | Suitable for All Type Rabbit | Adult Pellet Rabbit Food, Nutritionist Choice",
      price: 229,
      status: "pending",
      qty: null),
];
