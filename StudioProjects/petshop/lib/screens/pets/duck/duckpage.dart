import 'package:flutter/material.dart';
import 'package:petshop/firebase_helper/prodctmodel.dart';
import 'package:petshop/cart/productdetails.dart';
import 'package:petshop/screens/homepage.dart';
import 'package:petshop/screens/pets/petcare.dart';
import 'package:petshop/model/provider.dart';
import 'package:petshop/model/routes.dart';
import 'package:provider/provider.dart';

class DuckPage extends StatefulWidget {
  const DuckPage({super.key});

  @override
  State<DuckPage> createState() => _DuckPageState();
}

class _DuckPageState extends State<DuckPage> {
  List<ProductModel> productModelList = [];

  @override
  Widget build(BuildContext context) {
    AppProvider appProvider = Provider.of<AppProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Ducks"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 10,
            ),
            const Text(
              "Pick Your Pet",
              style: TextStyle(
                  fontSize: 25, color: Color.fromARGB(255, 199, 149, 207)),
            ),
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
                                      builder: (context) => const PetCare()));
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
      name: "Duck",
      description: "",
      stock: 20,
      image:
          "https://www.weedemandreap.com/wp-content/uploads/2017/08/duck-breeds.jpg",
      isFavourite: false,
      price: 750,
      status: "pending",
      qty: null),
  ProductModel(
      id: "2",
      name: "Duck",
      description: "",
      stock: 10,
      image:
          "https://alifeofheritage.com/wp-content/uploads/2021/01/Duck-Mallard-Ducks.jpeg",
      isFavourite: false,
      price: 500,
      status: "pending",
      qty: null),
  ProductModel(
      stock: 20,
      id: "3",
      name: "Vigova",
      description: "",
      image: "https://www.arc.unsw.edu.au/generated/600/ducks2-jpg.jpg",
      isFavourite: false,
      price: 550,
      status: "pending",
      qty: null),
  ProductModel(
      id: "4",
      name: "Duck",
      description: "",
      stock: 10,
      image:
          "https://d.newsweek.com/en/full/2083122/ducklings.jpg?w=1600&h=1600&q=88&f=b217a4324f615a7cc5c4f81aa9ada54e",
      isFavourite: false,
      status: "pending",
      price: 400,
      qty: null),
];
