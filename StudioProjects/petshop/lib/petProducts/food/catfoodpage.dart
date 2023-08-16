import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:petshop/screens/appbar/Notificationpage.dart';
import 'package:petshop/cart/cartpage.dart';
import 'package:petshop/firebase_helper/prodctmodel.dart';
import 'package:petshop/cart/productdetails.dart';
import 'package:petshop/model/provider.dart';
import 'package:petshop/model/routes.dart';
import 'package:petshop/screens/homepage.dart';
import 'package:petshop/screens/pets/cat/catcare.dart';
import 'package:provider/provider.dart';

class CatFoodPage extends StatefulWidget {
  const CatFoodPage({super.key});

  @override
  State<CatFoodPage> createState() => _CatFoodPageState();
}

class _CatFoodPageState extends State<CatFoodPage> {
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
        title: const Text("Cat Foods"),
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
                                          const CatCarePage()));
                            },
                            child: const Text("CAT CARE")),
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
                    "https://rukminim2.flixcart.com/fk-p-ads/850/400/dp-doc/1682070585232-clgqdea345ix30x76cmdyduvd-flipkart---PCA-AD---1440x640%20%282%29.png?q=90",
                    fit: BoxFit.contain,
                  ),

                  Image.network(
                    "https://www.whiskas.in/cdn-cgi/image/format=auto,q=90/sites/g/files/fnmzdf2051/files/2022-11/whiskas-new-variants_0.png",
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
                      border: Border.all(color: Colors.black),
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
      name: "Whiskas",
      description: "Whiskas (+1 year) Ocean Fish 3 kg Dry Adult Cat Food",
      image:
      "https://rukminim2.flixcart.com/image/416/416/l3vxbbk0/pet-food/0/k/m/-original-imagewg4ryrz652h.jpeg?q=70",
      isFavourite: false,
      price: 1008,
      status: "pending",
      stock: 10,
      qty: null),
  ProductModel(
      id: "2",
      name: "Kittibles",
      description:
          "Wiggles Kittibles Kitten Food Dry Kitty, 1kg, 1-12 Months - Baby Cats Chicken Fish Food Chicken 1 kg Dry Adult Cat Food",
          stock: 50,
      image:"https://rukminim2.flixcart.com/image/416/416/xif0q/pet-food/q/j/f/1-cat-1-ssrplp90-wiggles-original-imaggkp9am6gmhzq.jpeg?q=70",
      isFavourite: false,
      price: 745,
      status: "pending",
      
      
      qty: null),
  ProductModel(
      id: "3",
      name: "Me-O",
      stock: 16,
      description: "Me-O JP Pet Products TUNA 400gm Tuna, Pork 0.4 kg Wet Adult Cat Food",
      image:
      "https://rukminim2.flixcart.com/image/850/1000/kdukgi80/pet-food/j/g/g/0-4-cat-tuna-400gm-me-o-original-imafunqkpgkzhafw.jpeg?q=90",
      isFavourite: false,
      price: 345,
      status: "pending",
      qty: null),
  ProductModel(
      id: "4",
      name: "Sheba",
      stock: 12,
      description: "Sheba Chicken 0.4 kg Dry Adult, Young Cat Food",
      image: "https://rukminim2.flixcart.com/image/450/400/xif0q/pet-food/c/v/x/0-4-cat-1-6914973706286-sheba-original-imagzsd5bwvydtjd.jpeg?q=90&crop=false",
      isFavourite: false,
      status: "pending",
      price: 370,
      qty: null),
  
 
];
