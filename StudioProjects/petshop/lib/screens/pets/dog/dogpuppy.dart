import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:petshop/screens/appbar/Notificationpage.dart';
import 'package:petshop/cart/cartpage.dart';
import 'package:petshop/firebase_helper/prodctmodel.dart';
import 'package:petshop/cart/productdetails.dart';
import 'package:petshop/screens/homepage.dart';
import 'package:petshop/screens/pets/dog/dogcarepage.dart';
import 'package:petshop/model/provider.dart';
import 'package:petshop/model/routes.dart';
import 'package:provider/provider.dart';

class DogPuppyPage extends StatefulWidget {
  const DogPuppyPage({super.key});

  @override
  State<DogPuppyPage> createState() => _DogPuppyPageState();
}

class _DogPuppyPageState extends State<DogPuppyPage> {
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
                 Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const NotificationPage()));

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
        title: const Text("Puppies"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 120),
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
                            child: const Text("DOG CARE")),
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
                      "https://media.istockphoto.com/id/1069531070/photo/groups-of-dogs-labrador-puppies-puppy-chocolate-labrador-retriever-in-front-of-white.jpg?s=612x612&w=0&k=20&c=JplDyHWDC0stouz_ddSAE4HHXBHRXd-jlFRbPBgdS38=",
                      fit: BoxFit.fill,
                    ),

                    Image.network(
                      "https://static.wixstatic.com/media/944167_6d182b6e2cd744eb9f22700ebe63fdbe~mv2.png/v1/fill/w_738,h_384,al_c/944167_6d182b6e2cd744eb9f22700ebe63fdbe~mv2.png",
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
              "Latest one's",
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 199, 120, 212)),
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
                        const SizedBox(height: 10,),
                        Text(
                          singleProduct.name,
                          style: const TextStyle(
                            fontSize: 16,
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
      stock: 10,
      name: "Labrador",
      description:
          "Labradors are medium to large-sized dogs with a strong, athletic build. They have a well-balanced and sturdy frame, and their bodies are slightly longer than they are tall. Labradors have a broad head with a friendly expression, a moderately long muzzle, and kind, expressive eyes.",
      image:
      "https://cdn.pixabay.com/photo/2016/12/13/05/15/puppy-1903313_1280.jpg",
      isFavourite: false,
      price: 10000,
      status: "pending",
      qty: null),
  ProductModel(
      id: "2",
      stock: 10,
      name: "Pug",
      description:"Pug puppies for sale",
      image:
      "https://i.guim.co.uk/img/media/fe1e34da640c5c56ed16f76ce6f994fa9343d09d/0_174_3408_2046/master/3408.jpg?width=1200&height=900&quality=85&auto=format&fit=crop&s=0d3f33fb6aa6e0154b7713a00454c83d",
      isFavourite: false,
      price: 12000,
      status: "pending",
      qty: null),
  ProductModel(
      id: "3",
      stock: 12,
      name: "Rotweiller",
      description: "Affordable Rottweiler puppies for sale",
      image:"https://dogtime.com/wp-content/uploads/sites/12/2021/05/GettyImages-527878946-e1689082645117.jpg?w=1024",
      isFavourite: false,
      price: 6000,
      status: "pending",
      qty: null),
  ProductModel(
      id: "4",
      name: "German",
      stock: 17,
      description:
          "German Shepherd Dog is a large, agile, muscular dog of noble character and high intelligence. Loyal, confident, courageous, and steady, the German Shepherd is truly a dog lover's delight.",
      image:
      "https://cdn-cafdl.nitrocdn.com/fQHdfFSxWCuDmbpNBOTabVcchzVvBqxc/assets/images/optimized/rev-10d6093/blog/wp-content/uploads/2015/09/german-shepherd.jpg",
      isFavourite: false,
      status: "pending",
      price: 12000,
      qty: null),
 
];
