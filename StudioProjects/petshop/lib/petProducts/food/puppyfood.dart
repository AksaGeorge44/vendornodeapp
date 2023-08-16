import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:petshop/screens/appbar/Notificationpage.dart';
import 'package:petshop/cart/cartpage.dart';
import 'package:petshop/firebase_helper/prodctmodel.dart';
import 'package:petshop/cart/productdetails.dart';
import 'package:petshop/model/provider.dart';
import 'package:petshop/model/routes.dart';
import 'package:petshop/screens/homepage.dart';
import 'package:petshop/screens/pets/dog/dogcarepage.dart';
import 'package:provider/provider.dart';

class PuppyFoodPage extends StatefulWidget {
  const PuppyFoodPage({super.key});

  @override
  State<PuppyFoodPage> createState() => _PuppyFoodPageState();
}

class _PuppyFoodPageState extends State<PuppyFoodPage> {
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
        title: const Text("Puppy Foods"),
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
                                      builder: (context) =>
                                          const HomePage()));
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
                            child: const Text("DOG CARE")),
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
                        hintText: "Search for Foods and more...."),
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
                    aspectRatio: 16 / 9, viewportFraction: 1, autoPlay: true),
                items: [

                  // Replace the Image.network with your own images
                  Image.network(
                    "https://www.dogseechew.in/storage/editor_635935a930246-why-you-should-always-choose-natural-food-for-your-dog.png",
                    fit: BoxFit.cover,
                  ),

                  Image.network(
                    "https://www.petsworld.in/blog/wp-content/uploads/2022/04/IAMS-Dog-Food.jpg",
                    fit: BoxFit.contain,
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
              "Pick For Your Pet",
              style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.black),
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
      name: "Drools",
      description: "Drools Puppy chicken Egg, Chicken 10 kg Dry Young, New Born Dog Food",
      image:
      "https://rukminim2.flixcart.com/image/416/416/khdqnbk0/pet-food/q/h/j/10-dog-930343-drools-original-imafxeych9dpy6hc.jpeg?q=70",
      isFavourite: false,
      price: 1700,
      status: "pending",
      stock: 10,
      qty: null),
  ProductModel(
      id: "2",
      name: "Pedigree PRO ",
      description:
        "PEDIGREE PRO Puppy Large Breed, (3-18 Months), 3 kg Dry Young Dog Food",
          stock: 30,
      image:
      "https://rukminim2.flixcart.com/image/416/416/xif0q/pet-food/l/m/h/-original-imagzernrvmma8mr.jpeg?q=70",
      isFavourite: false,
      price: 1745,
      status: "pending",
      
      
      qty: null),
  ProductModel(
      id: "3",
      name: "Pup start",
      stock: 16,
      description: "skyec Pup Start , Premium Puppy Weaning Diet Food for all breeds, 300 gm 0.3 kg Dry New Born, Young Dog Food",
      image:
      "https://rukminim2.flixcart.com/image/850/1000/kf0087k0/pet-food/z/s/s/0-3-dog-pup-start-300-gm-sky-ec-original-imafvje3zh8tqnnr.jpeg?q=90",
      isFavourite: false,
      price: 320,
      status: "pending",
      qty: null),
  ProductModel(
      id: "4",
      name: "Drools",
      stock: 12,
      description:"Drools Focus Puppy Super Premium Chicken 4 kg Dry Young Dog Food",
      image: "https://rukminim2.flixcart.com/image/416/416/khdqnbk0/pet-food/c/8/s/4-dog-930943-drools-original-imafxeycwngam9gp.jpeg?q=70",
      isFavourite: false,
      status: "pending",
      price: 1211,
      qty: null),
  ProductModel(
      id: "5",
      name: "IAMS",
      stock: 15,
      description:"IAMS Proactive Health Premium Chicken 8 kg Dry Adult, New Born Dog Food",
      image:
      "https://rukminim2.flixcart.com/image/400/400/xif0q/pet-food/z/b/q/-original-imagkn9vhnzt62qd.jpeg?q=90&crop=false",
      isFavourite: false,
      price: 4830,
      status: "pending",
      qty: null),
  ProductModel(
      id: "6",
      name: "N&D",
      stock: 12,
      description:
          "N&D Adult Dry dog Food.High-quality, balanced, flavourful dog food",
      image:
      "https://rukminim1.flixcart.com/image/300/300/kmds4nk0/pet-food/u/p/h/0-8-dog-n-d-ancestral-grain-chicken-pomegranate-starter-puppy-original-imagfavyjaghwdme.jpeg?q=90&crop=false",
      isFavourite: false,
      price: 2115,
      status: "pending",
      qty: null),
  ProductModel(
      id: "7",
      name: "Himalaya",
      stock: 17,
      description:
      "HIMALAYA Healthy pet food puppy Mutton, Rice 1.2 kg Dry New Born, Young Dog Food",
      image:
      "https://rukminim2.flixcart.com/image/416/416/k7m8brk0/pet-food/w/n/k/1-2-dog-puppy-himalaya-original-imafptqb2zekgrpg.jpeg?q=70",
      isFavourite: false,
      price: 350,
      status: "pending",
      qty: null),
  ProductModel(
      id: "8",
      name: "Drools",
      stock: 15,
      description:
      "Drools Ultium Performance Chicken 20 kg Dry Adult Dog Food",
      image:
      "https://rukminim2.flixcart.com/image/416/416/l0tweq80/pet-food/b/f/m/-original-imagcjf83yavzfmk.jpeg?q=70",
      isFavourite: false,
      price: 3167,
      status: "pending",
      qty: null),
 
];
