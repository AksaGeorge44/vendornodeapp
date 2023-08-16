import 'package:flutter/material.dart';
import 'package:petshop/firebase_helper/prodctmodel.dart';
import 'package:petshop/cart/productdetails.dart';
import 'package:petshop/screens/homepage.dart';
import 'package:petshop/screens/pets/petcare.dart';
import 'package:petshop/model/provider.dart';
import 'package:petshop/model/routes.dart';
import 'package:provider/provider.dart';

class RabbitPage extends StatefulWidget {
  const RabbitPage({super.key});

  @override
  State<RabbitPage> createState() => _RabbitPageState();
}

class _RabbitPageState extends State<RabbitPage> {
  List<ProductModel> productModelList = [];

  @override
  Widget build(BuildContext context) {
        AppProvider appProvider=Provider.of<AppProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Rabbits"),
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
              padding: const EdgeInsets.only(left: 100),
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
              height: 10,
            ),
            const Text(
              "Pick Your Pet",
              style: TextStyle(
                  fontSize: 25,
                 // fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 164, 94, 177)),
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
    stock: 16,
      id: "1",
      name: "Rabbit",
      description: "",
      image:
          "https://plus.unsplash.com/premium_photo-1667155652672-f7a4983f842f?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8N3x8cGV0JTIwcmFiYml0fGVufDB8fDB8fHww&w=1000&q=80",
      isFavourite: false,
      price: 250,
      status: "pending",
      qty: null),
  ProductModel(
    stock: 12,
      id: "2",
      name: "Rabbit",
      description: "",
      image: "https://www.pdsa.org.uk/media/10390/two-rabbits-on-wood.jpg",
      isFavourite: false,
      price: 350,
      status: "pending",
      qty: null),
  ProductModel(
    
      id: "3",
      name: "Rabbit",
      description: "",
      image:
          "https://www.animalhumanesociety.org/sites/default/files/styles/scale_width_960/public/media/image/2019-03/Nibbles.jpg?itok=N4OjWn-p",
      isFavourite: false,
      price: 400,
      stock: 20,
      
      status: "pending",
      qty: null),
  ProductModel(
    stock: 10,
      id: "4",
      name: "Rabbit",
      description: "",
      image:
          "https://myhouserabbit.com/wp-content/uploads/2022/03/iStock-1081925584-scaled.jpg",
      isFavourite: false,
      status: "pending",
      price: 250,
      qty: null),
];
