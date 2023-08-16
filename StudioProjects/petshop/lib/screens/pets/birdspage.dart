import 'package:flutter/material.dart';
import 'package:petshop/firebase_helper/prodctmodel.dart';
import 'package:petshop/cart/productdetails.dart';
import 'package:petshop/screens/homepage.dart';
import 'package:petshop/screens/pets/petcare.dart';
import 'package:petshop/model/provider.dart';
import 'package:petshop/model/routes.dart';
import 'package:provider/provider.dart';

class BirdsPage extends StatefulWidget {
  const BirdsPage({super.key});

  @override
  State<BirdsPage> createState() => _BirdsPageState();
}

class _BirdsPageState extends State<BirdsPage> {
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
        title: const Text("Birds"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 10,
            ),
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 160),
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
                                          const PetCare()));
                            },
                            child: const Text("PET CARE")),
                      ],
                    )
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 25,
            ),
            const Text(
              "Pick Your Pet",
              style: TextStyle(
                  fontSize: 25,
                  color: Color.fromARGB(255, 146, 98, 155)),
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
                          padding: const EdgeInsets.all(8.0),
                          child: Image.network(
                            singleProduct.image,
                            height: 100,
                            width: 100,
                          ),
                        ),
                        const SizedBox(height: 15,),
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
      name: "Parakeet",
      stock: 20,
      description:
          "Also known as budgies, according to PetSmart, Parakeets can quickly become your family's best friend with their sweet gestures and songs. With practice, Parakeets can nibble out of your hand, whistle in tune, and learn basic commands. How can you resist?Weight: 1 ounce"
          "Length: 7 inches Life expectancy: 7 to 15 years",
      image:"https://media.istockphoto.com/id/682216682/photo/budgies-are-in-the-roost-on-the-green-background.jpg?s=612x612&w=0&k=20&c=H8L843VhnaPN0C59GwWtvQu0JIPgM-cvmukjB_NUe2o=",
      isFavourite: false,
      price: 500,
      status: "pending",
      qty: null),
  ProductModel(
      id: "2",
      stock: 25,
      name: "Cockatiel",
      description:
          "A perfect beginner bird, PetSmart notes that cockatiels love playing with their owners, and should be given at least one hour of attention a day. These bright birds love spending time outside of their cage, so consider purchasing a perch for them to hang out on and socialize, even if you're not actively playing with them.",
      image:
          "https://hips.hearstapps.com/hmg-prod/images/best-pet-birds-cockatiel-1572839067.jpg?crop=1.00xw:0.667xh;0,0.0600xh&resize=980:*",
      isFavourite: false,
      price: 7000,
      status: "pending",
      qty: null),
  ProductModel(
      id: "3",
      name: "Lovebirds",
      stock: 10,
      description:
          "If you're looking for a companion for life, stop your search now. There's no bond-breaking when lovebirds make a connection with their partners — whether it's with another bird of their kind or with their human. These creatures love bathing, so give them a bowl of water to wash in two or three times a week for some playtime.",
      image:
          "https://hips.hearstapps.com/hmg-prod/images/best-pet-birds-lovebird-1572839070.jpg?crop=1.00xw:0.666xh;0,0.215xh&resize=980:*",
      isFavourite: false,
      price: 250,
      status: "pending",
      qty: null),
  ProductModel(
      stock: 10,
      id: "4",
      name: "Finch",
      description:
          "If your family is looking for a bird that doesn't require much attention, the finch might just be the perfect fit. While its beautiful look and charming chirps are fun to watch, finches prefer to stay inside their cage, away from human interaction. If you want a bird of a similar size, but with a more hands-on experience, check out the parakeet.",
      image:
          "https://hips.hearstapps.com/hmg-prod/images/best-pet-birds-finch-1572839070.jpg?crop=0.789xw:0.611xh;0.0748xw,0.187xh&resize=980:*",
      isFavourite: false,
      status: "pending",
      price: 200,
      qty: null),
];
