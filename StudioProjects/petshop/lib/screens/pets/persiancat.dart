import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:petshop/cart/cartpage.dart';
import 'package:petshop/firebase_helper/prodctmodel.dart';
import 'package:petshop/cart/productdetails.dart';
import 'package:petshop/screens/homepage.dart';
import 'package:petshop/screens/pets/dog/dogcarepage.dart';
import 'package:petshop/model/provider.dart';
import 'package:petshop/model/routes.dart';
import 'package:provider/provider.dart';

class PersiancatPage extends StatefulWidget {
  const PersiancatPage({super.key});

  @override
  State<PersiancatPage> createState() => _PersiancatPageState();
}

class _PersiancatPageState extends State<PersiancatPage> {
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
    AppProvider appProvider = Provider.of<AppProvider>(context);

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
        title: const Text("PersianCats"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 35),
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
                          hintText: "Search for Pets...."),
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
                    aspectRatio: 16 / 9,
                    viewportFraction: 1,
                  ),
                  items: [
                    // Replace the Image.network with your own images
                    Image.network(
                      "https://media.istockphoto.com/id/1058510144/photo/cats-sitting-in-a-row.jpg?s=612x612&w=0&k=20&c=mA0-E6BQzPl9eN4e-c9gXTmJdGjf-AOQcVu1_Y7jAyc=",
                      fit: BoxFit.contain,
                    ),

                    // Add more images as needed
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            const Text(
              "Pick Your Pet",
              style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 198, 104, 214)),
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
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            singleProduct.name,
                            style: const TextStyle(
                              fontSize: 20,
                            ),
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
                            backgroundColor: Colors.blue,
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
      name: "Persian Cat",
      stock: 16,
      description:
          "A show-style Persian cat has an extremely long and thick coat, short legs, a wide head with the ears set far apart, large eyes, and an extremely shortened muzzle. The breed was originally established with a short muzzle, but over time, this characteristic has become extremely exaggerated, particularly in North America. Persian cats can have virtually any color or markings.",
      image:"https://w7.pngwing.com/pngs/326/62/png-transparent-persian-cat-bengal-cat-kitten-dog-white-persian-cat-mammal-cat-like-mammal-animals.png",
      isFavourite: false,
      price: 10000,
      status: "pending",
      qty: null),
  ProductModel(
      id: "2",
      name: "White Persian Cat",
      description:
      "White Persian cats will have pure, snow-white coats with no sign of cream. Their nose leather and paw pads will be pink. Their eyes should be either a brilliant copper or a deep blue. Odd-colored eyes are allowed in the Persian breed standard as long as both eyes have an equal depth of color.",
      image:
      "https://media.istockphoto.com/id/516891004/photo/persian-cat-sitting-in-front-of-white-background.jpg?s=612x612&w=0&k=20&c=HrMhatNr2f9-qpx2ZTs8k8X57B7X1HUoL8Oge_ZwtAE=",
      isFavourite: false,
      price: 12000,
      stock: 15,
      status: "pending",
      qty: null),
  ProductModel(
      id: "3",
      name: "Black Persian Cat",
      description:"Black Persian cats should have a coal-black coat without any paler undercoat or rust-red hair tips. Their noses should be black, and their paw pads can be either black or brown. They have brilliant copper eyes.",
      image:
      "https://images.unsplash.com/photo-1591429939960-b7d5add10b5c?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Mnx8cGVyc2lhbiUyMGNhdHxlbnwwfHwwfHx8MA%3D%3D&w=1000&q=80",
      isFavourite: false,
      stock: 14,
      price: 12500,
      status: "pending",
      qty: null),
  ProductModel(
      id: "4",
      name: "Red Persian Cat",
      stock: 10,
      description:
          "The Birman is another ‘colour point’ cat, with a pale cream to white coat over the body, and coloured points, i.e., the face, ears, legs and tail. The Birman is a semi long-haired cat with a silky soft, luxuriant coat, beautiful blue eyes and pure white feet (gloves on the front paws, socks on the back.) Under the fur this is a moderately built cat, medium to large with a well-muscled body, rounded face and neat ears.",
      image:"https://excitedcats.com/wp-content/uploads/2020/12/Solid-Red-Persian.webp",
      isFavourite: false,
      status: "pending",
      price: 9000,
      qty: null),
  ProductModel(
      id: "5",
      name: "Shaded Silver Cat",
      stock: 16,
      description:"A shaded silver Persian has a white undercoat with black tips, but they are much darker than a chinchilla silver Persian. The black shading will be most apparent on their sides, faces, and tails. They have brick-red noses and black paw pads, and their eyes can be green or blue-green.",
      image:"https://excitedcats.com/wp-content/uploads/2020/12/Shaded-Silver.webp",
      isFavourite: false,
      price: 8500,
      status: "pending",
      qty: null),
  ProductModel(
      id: "6",
      stock: 10,
      name: "Blue Chinchilla",
      description:"These Persians have pure white undercoats, with blue tipping on their back, sides, head, and tail. Their legs may be slightly shaded, but their chin, ear tufts, chest, and stomach should be pure white. They will have a rose-colored nose, with paw pads in rose or blue.",
      image:"https://excitedcats.com/wp-content/uploads/2020/12/longhair-cat-golden-blue-chinchilla-with-green-eyes_OksanaSusoeva_shutterstock.webp",
      isFavourite: false,
      price: 10000,
      status: "pending",
      qty: null),
  ProductModel(
      id: "7",
      name: "Shaded Golden Cat",
      stock: 19,
      description:"A shaded golden Persian will have an undercoat in a golden shade, with most of their coat covered with black tips. The overall effect is darker than the chinchilla’s golden coloring. Shaded golden Persians will have rose noses and black paw pads.",
      image:"https://excitedcats.com/wp-content/uploads/2021/01/shaded-golden-persian-cat_Eric-Isselee_Shutterstock.webp",
      isFavourite: false,
      price: 10000,
      status: "pending",
      qty: null),
  ProductModel(
      id: "8",
      name: "Blue Chinchilla",
      stock: 10,
      description:"A blue chinchilla golden Persian has an ivory to honey-colored undercoat. The coat is tipped with blue across their back, sides, head, and tail. Their noses are rose, and their paw pads are black. They have blue-green or blue eyes.",
      image:"https://excitedcats.com/wp-content/uploads/2020/12/longhair-cat-golden-blue-chinchilla-with-green-eyes2_OksanaSusoeva_shutterstock.webp",
      isFavourite: false,
      price: 15000,
      status: "pending",
      qty: null),
  ProductModel(
      id: "9",
      name: "Shell Camio",
      stock: 10,
      description:"Sometimes also called the red chinchilla, the shell cameo has a white undercoat with a small amount of red tipping across their back, flanks, tails, and heads. Their legs may also show a small amount of tipped hairs. They have rose-pink noses and paw pads and bright copper eyes.",
      image:
      "https://excitedcats.com/wp-content/uploads/2020/12/Shell-Cameo-Persian-Domestic-Cat_slowmotiongli_shutterstock.webp",
      isFavourite: false,
      price: 15000,
      status: "pending",
      qty: null),
  ProductModel(
      id: "10",
      name: "Shell Blue Cream",
      stock: 10,
      description:
          "This medium to large breed has a well-muscled athletic build with a strong, dense bone structure. This makes them surprisingly heavy for their size, which combined with their low-slung stance and often ‘stalky’ walk, lends much to their ‘big cat’ appearance, even though this is a purely domestic cat with no wild ancestry at all! ",
      image:"https://excitedcats.com/wp-content/uploads/2020/12/shell-blue-cream-1.webp",
      isFavourite: false,
      price: 13500,
      status: "pending",
      qty: null),
];
