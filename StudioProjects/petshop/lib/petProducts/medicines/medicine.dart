import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:petshop/petProducts/medicines/birdsmedicine.dart';
import 'package:petshop/petProducts/medicines/catmedicine.dart';
import 'package:petshop/petProducts/medicines/dogmedicine.dart';
import 'package:petshop/petProducts/medicines/duckmedicine.dart';
import 'package:petshop/petProducts/medicines/fishmedicine.dart';
import 'package:petshop/petProducts/medicines/henmedicine.dart';
import 'package:petshop/petProducts/medicines/rabbitmedicine.dart';
import 'package:petshop/screens/appbar/Notificationpage.dart';
import 'package:petshop/cart/cartpage.dart';
import 'package:petshop/firebase_helper/prodctmodel.dart';
import 'package:petshop/cart/productdetails.dart';
import 'package:petshop/model/provider.dart';
import 'package:petshop/model/routes.dart';
import 'package:provider/provider.dart';

class MedicinePage extends StatefulWidget {
  const MedicinePage({super.key});

  @override
  State<MedicinePage> createState() => _MedicinePageState();
}

class _MedicinePageState extends State<MedicinePage> {
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
        title: const Text("Medicines"),
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
                                      builder: (context) => const DogMedicinePage()));
                            },
                            child: const Text("DOG")),
                       
                        TextButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const CatMedicinePage()));
                            },
                            child: const Text("CAT")),
                        
                        TextButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const BirdsMedicinePage()));
                            },
                            child: const Text("BIRDS")),
                        TextButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const FishMedicinePage()));
                            },
                            child: const Text("FISH")),
                        TextButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const RabbitMedicinePage()));
                            },
                            child: const Text("RABBIT")),
                        TextButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const DuckMedicinePage()));
                            },
                            child: const Text("DUCK")),
                        TextButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const HenMedicinePage()));
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
                        hintText: "Search for Medicines and more...."),
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
                    "https://www.direct4pet.co.uk/cdn/shop/files/BlackCat-Drontal_HP-Banners-740x495_AUG2023_800x@2x.jpg?v=1690879906",
                    fit: BoxFit.cover,
                  ),

                  Image.network(
                    "https://www.direct4pet.co.uk/cdn/shop/files/RIP_fleas_1800x666_336b3fd6-cddd-43dc-866f-804a10dbf0ba_1520x560@2x.jpg?v=1686134183",
                    fit: BoxFit.contain,
                  ),

                  // Add more images as needed
                ],
              ),
            ),
            const SizedBox(
              height: 25,
            ),
            const Text(
              "Pick For Pet",
              style: TextStyle(fontSize: 25, color: Colors.purple),
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
      name: "Tonic",
      image: "https://m.media-amazon.com/images/I/61zHTjrLVbL._SY679_.jpg",
      stock: 10,
      description:
          "Pharma Aurocal-Pet Calcium Palatable Chicken Flavour Tonic for Dogs and Cats_200ml",
      isFavourite: false,
      price: 199,
      status: "pending",
      qty: null),
  ProductModel(
      id: "2",
      stock: 10,
      name: "Ultramax ",
      image:
          "https://5.imimg.com/data5/JV/CG/MY-7863908/wuff-wuff-ultramax-dog-herbal-tick-fever-tonic-200-ml-500x500.png",
      description:
          "Medicine Grade Ultramax Dog Herbal Tick Fever Tonic 200 Ml, Nutritional Medicine And Immune System",
      isFavourite: false,
      price: 350,
      status: "pending",
      qty: null),
  ProductModel(
      id: "3",
      name: "Spray",
      stock: 15,
      image:
          "https://cdn01.pharmeasy.in/dam/products_otc/A91955/dogz-dudez-neem-shield-spray-tick-flea-repellent-200ml-2-1671743209.jpg?dim=700x0&dpr=1&q=100",
      description:
          "Dogz & Dudez Neem Shield Spray - Tick & Flea Repellent-200ml",
      isFavourite: false,
      price: 315,
      status: "pending",
      qty: null),
  ProductModel(
      id: "4",
      name: "Petvit",
      stock: 15,
      isFavourite: false,
      image:
          "https://cdn01.pharmeasy.in/dam/products_otc/V37538/petvit-calcium-syrup-for-dog-stronger-bones-teeth-growth-in-pet-for-all-age-group-100ml-2-1671742921.jpg?dim=700x0&dpr=1&q=100",
      description:
          "Petvit Calcium Syrup For Dog Stronger Bones Teeth & Growth In Pet For All Age Group 100ml",
      status: "pending",
      price: 250,
      qty: null),
  ProductModel(
      id: "5",
      image:
          "https://cdn01.pharmeasy.in/dam/products_otc/L86372/aziqine-animal-wound-and-dressing-film-forming-gel-50gm-2-1673332471.jpg?dim=700x0&dpr=1&q=100",
      name: "wound gel",
      description: "Aziqine Animal Wound And Dressing Film Forming Gel (50gm)",
      isFavourite: false,
      price: 235,
      status: "pending",
      stock: 12,
      qty: null),
  ProductModel(
      id: "6",
      name: "Respifit",
      stock: 30,
      image:
          "https://refitanimalcare.com/wp-content/uploads/2022/01/cough-syrup-for-cattle.webp",
      description:
          "Respiratory Tonic & Cough Medicine.Respiratory Tonic & Cough Medicine For Poultry, Chicken, Cattle, Calves, Cow, Buffalo, Sheep, Goat and Livestock Animals",
      isFavourite: false,
      price: 245,
      status: "pending",
      qty: null),
];
