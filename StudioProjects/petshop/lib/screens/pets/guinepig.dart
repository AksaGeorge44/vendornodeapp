import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:petshop/screens/appbar/Notificationpage.dart';
import 'package:petshop/cart/cartpage.dart';
import 'package:petshop/firebase_helper/prodctmodel.dart';
import 'package:petshop/cart/productdetails.dart';
import 'package:petshop/screens/homepage.dart';
import 'package:petshop/screens/pets/petcare.dart';
import 'package:petshop/model/provider.dart';
import 'package:petshop/model/routes.dart';
import 'package:provider/provider.dart';

class GuinePage extends StatefulWidget {
  const GuinePage({super.key});

  @override
  State<GuinePage> createState() => _GuinePageState();
}

class _GuinePageState extends State<GuinePage> {
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
           Padding(
            padding: const EdgeInsets.all(17),
            child: GestureDetector(
              onTap: (){
           Navigator.push(context, MaterialPageRoute(builder: (context)=>const NotificationPage()));

              },
              
              child: const Icon(Icons.notification_add_outlined)),
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
        title: const Text("Guinea"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 140),
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
                      "https://hips.hearstapps.com/hmg-prod/images/best-guinea-pig-names-1559254248.png?crop=0.679xw:1.00xh;0.123xw,0&resize=1200:*",
                      fit: BoxFit.fill,
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
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 211, 128, 226)),
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
                        const SizedBox(height: 10,),
                        Image.network(
                          singleProduct.image,
                          height: 100,
                          width: 100,
                        ),
                         const SizedBox(height: 10,),
                        Text(
                          singleProduct.name,
                          style: const TextStyle(
                            fontSize: 17,
                          
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
      name: "Abyssinian Guinea ",
      stock: 20,
      description: "Abyssinians are particularly affectionate and gentle, making them a great choice for first-time guinea pig owners. This breed is known for its short, tufted coat which can be found in various colors. There is also an Abyssinian Satin breed, identifiable by its particularly glossy fur.",
      isFavourite: false,
      image: "https://encrypted-tbn1.gstatic.com/licensed-image?q=tbn:ANd9GcTttXIEykjW4tbIFQ_dYDvRDNJ1ha6u2YsFph_n2d5vsGxn5esNXjSQo_qMzx_GGyvaNP-EJBgJOTJ0Q2Y",
      price: 5000,
      status: "pending",
      qty: null),
  ProductModel(
      id: "2",
      name: "American Guinea ",
      description: "American Guinea Pigs are the most common breed, popular because of their short, smooth coat that's easy to take care of, as well as their sweet, easygoing personalities with both people and other piggies. The American Guinea Pig Satin breed has an extra-shiny coat.",
      image: "https://hips.hearstapps.com/hmg-prod/images/guinea-pig-breeds-american-guinea-pig-156414947-1634140507.jpg?crop=0.665xw:1.00xh;0.112xw,0&resize=980:*",
      isFavourite: false,
      price: 4500,
      stock: 15,
      status: "pending",
      qty: null),
  ProductModel(
      id: "3",
      name: "Coronet Guinea",
      image: "https://hips.hearstapps.com/hmg-prod/images/guinea-pig-breeds-coronet-2-643242590-1634140801.jpg?crop=0.668xw:1.00xh;0.190xw,0&resize=980:*",
      description: "Coronets are a breed of long-haired guinea pigs, with fur flowing from front to back, a coronet or rosette in the middle of its head, and a coat that comes in a range of hues. They're known for being especially playful and affectionate though, like all long-haired breeds, require extra grooming.",
      isFavourite: false,
      stock: 14,
      price: 5500,
      status: "pending",
      qty: null),
  ProductModel(
      id: "4",
      name: "Peruvian Guinea ",
      stock: 15,
      image: "https://hips.hearstapps.com/hmg-prod/images/guinea-pig-breeds-peruvian-guinea-pig-466063199-1634141065.jpg?crop=0.668xw:1.00xh;0.241xw,0&resize=980:*",
      description: "The Peruvian Guinea Pig's long locks (which can grow up to 2 feet!) make it a popular with owners who like to show their cavies (yes, there are guinea pig shows). It's one of the oldest breeds of guinea pigs, and the ACBA also recognizes the Peruvian Satin breed.",
      isFavourite: false,
      status: "pending",
      price: 5000,
      qty: null),
 
];
