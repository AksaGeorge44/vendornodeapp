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

class HamsterPage extends StatefulWidget {
  const HamsterPage({super.key});

  @override
  State<HamsterPage> createState() => _HamsterPageState();
}

class _HamsterPageState extends State<HamsterPage> {
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
        title: const Text("Hamster"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 110),
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
                      "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTNUCXr4s_G-VoCZ_GAZiUMM2NaLFrmNQmsvg&usqp=CAU",
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
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 209, 110, 226)),
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
      name: "Syrian hamster",
      stock: 20,
      description:"Syrian hamsters are one of the most common pets in Singapore due to their cuddly and docile nature. These charming furry babies are also known as golden hamsters or teddy bear hamsters.",
      image:"https://blog.petloverscentre.com/wp-content/uploads/2019/10/Syrian-hamster-on-blue-background-1024x683.png",
      isFavourite: false,
      price: 5000,
      status: "pending",
      qty: null),
  ProductModel(
      id: "2",
      name: "Winter white",
      description:"winter white dwarf hamsters originated from snowy regions. They also go by the names Siberian hamster and Djungarian hamster.Interestingly, their coats turn white in winter to help protect them from predators! They share a similar appearance to Campbell’s dwarf hamsters, with the exception of having furry feet, smaller ears and a wider dorsal stripe. ",
      image:"https://blog.petloverscentre.com/wp-content/uploads/2021/07/Winter-white-hamster-eating-corn-1024x683.png",
      isFavourite: false,
      price: 4500,
      stock: 15,
      status: "pending",
      qty: null),
  ProductModel(
      id: "3",
      name: "Chinese hamster",
      description:"Chinese hamsters are small rodents that came from the deserts of China and Mongolia. They’re often mistaken as mice due to their pointed noise and noticeable tail.",
      image:"https://blog.petloverscentre.com/wp-content/uploads/2021/07/Front-of-Chinese-hamster-1024x683.png",
      isFavourite: false,
      stock: 14,
      price: 5500,
      status: "pending",
      qty: null),
  ProductModel(
      id: "4",
      name: "Campbell's dwarf",
      stock: 15,
      description:"With their round bodies and small size, Campbell’s dwarf hamsters have an adorable look. It may be common to see pet stores naming them as “yellow pudding”, “blue pudding” or “sapphire” hamsters depending on their coat colour.",
      image:"https://blog.petloverscentre.com/wp-content/uploads/2021/07/Campbell-dwarf-hamster-sitting-on-a-bench-1024x683.png",
      isFavourite: false,
      status: "pending",
      price: 3500,
      qty: null),
 
];
