import 'package:flutter/material.dart';
import 'package:petshop/firebase_helper/prodctmodel.dart';
import 'package:petshop/screens/appbar/queries.dart';
import 'package:petshop/screens/pets/dog/dogchecklist.dart';
import 'package:petshop/screens/pets/dog/dogexercise.dart';
import 'package:petshop/screens/pets/dog/dogfeeding.dart';
import 'package:petshop/screens/pets/dog/doggrooming.dart';
import 'package:petshop/screens/pets/dog/doghandling.dart';
import 'package:petshop/screens/pets/dog/doghousing.dart';
import 'package:petshop/screens/pets/dog/dogvaccination.dart';
import 'package:petshop/screens/pets/dog/licensing.dart';
import 'package:petshop/screens/pets/dog/medicines.dart';
import 'package:petshop/screens/pets/dog/sprayingpage.dart';

class DogcarePage extends StatefulWidget {
  const DogcarePage({super.key});

  @override
  State<DogcarePage> createState() => _DogcarePageState();
}

class _DogcarePageState extends State<DogcarePage> {
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
    return Scaffold(
      appBar: AppBar(
        title: const Text("DogCare"),
        actions: [
          Padding(
            padding: const EdgeInsets.all(12),
            child: GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const QueriesPage()));
                },
                child: const Icon(Icons.question_answer)),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 30,
            ),
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
                    hintText: "Ask your questions...."),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: SizedBox(
                child: Card(
                  color: Colors.white,
                  elevation: 2.0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        Image.network(
                          "https://cdn.cdnparenting.com/articles/2018/12/16142018/196619114-H-1024x700.webp",
                          height: 250,
                          width: 300,
                          fit: BoxFit.contain,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            const Text(
              "General Care",
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black),
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
                  return GestureDetector(
                    onTap: () {
                      navigateToPage(index, context);
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.3),
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: Colors.blue),
                      ),
                      child: Column(
                        children: [
                          Image.network(
                            singleProduct.image,
                            height: 150,
                            width: 150,
                          ),
                         
                          Padding(
                            padding: const EdgeInsets.all(14),
                            child: Text(
                              singleProduct.name,
                              style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
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

void navigateToPage(int index, context) {
  switch (index) {
    case 0:
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => const DogFeedingPage()));
      // Navigate to FeedingPage
      break;
    case 1:
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => const DogExercisePage()));

      // Navigate to ExercisePage
      break;
    case 2:
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => const DogGroomingPage()));

      // Navigate to GroomingPage
      break;
    case 3:
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => const DogHandlingPage()));
    case 4:
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => const DogHousingPage()));
    case 5:
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => const LicensingPage()));
    case 6:
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => const DogMedicnePage()));
    case 7:
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => const DogSprayingPage()));
    case 8:
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => const DogVaccinationPage()));
    case 9:
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => const DogCheclistPage()));

    // ... Add cases for other pages
  }
}

List<ProductModel> bestProducts = [
  ProductModel(
      id: "1",
      stock: 10,
      name: "Feeding",
      image:
          "https://image.shutterstock.com/image-photo/dry-dog-food-bowl-on-260nw-764292286.jpg",
      description: "",
      isFavourite: false,
      price: 1700,
      status: "pending",
      qty: null),
  ProductModel(
      stock: 15,
      id: "2",
      name: "Exercise",
      image:
          "https://www.lonetreevet.com/blog/wp-content/uploads/2017/08/LoneTreeExercise_iStock-488058818-1024x723.jpg",
      description: "",
      isFavourite: false,
      price: 1159,
      status: "pending",
      qty: null),
  ProductModel(
      id: "3",
      name: "Grooming",
      stock: 20,
      image:
          "https://img.freepik.com/premium-photo/dog-gets-hair-cut-pet-spa-grooming-salon-closeup-dog-dog-has-haircut-comb-hair-groomer-concept_96727-2558.jpg",
      description: "",
      isFavourite: false,
      price: 948,
      status: "pending",
      qty: null),
  ProductModel(
      id: "4",
      name: "Handling",
      image:
          "https://media.istockphoto.com/id/1389039241/photo/dog-at-the-veterinarian.webp?b=1&s=170667a&w=0&k=20&c=cScNx76adpg1M8LYhd2BfDotBp0lYdWHEhd5Oe08opA=",
      description: "",
      isFavourite: false,
      status: "pending",
      price: 2115,
      stock: 20,
      qty: null),
  ProductModel(
      id: "4",
      name: "Housing",
      image:
          "https://media.istockphoto.com/id/511105254/photo/dog-kennel.jpg?s=612x612&w=0&k=20&c=Tspg82MafVo2dQ87H7EY8YF9kA1jK4dM_9slYzomNSA=",
      description: "",
      isFavourite: false,
      status: "pending",
      price: 2115,
      stock: 26,
      qty: null),
  ProductModel(
      id: "4",
      name: "Licensing and Identification",
      image:
          "https://www.cityofellinwoodks.com/wp-content/uploads/2020/03/2020-pet-tag-flyer-2-pdf-791x1024-2.jpg",
      isFavourite: false,
      description: "",
      status: "pending",
      stock: 15,
      price: 2115,
      qty: null),
  ProductModel(
      id: "4",
      name: "Medicines and Poisons",
      stock: 16,
      image:
          "https://shallowfordvet.com/wp-content/uploads/2017/03/dog-medicine.jpg",
      isFavourite: false,
      description: "",
      status: "pending",
      price: 2115,
      qty: null),
  ProductModel(
      id: "4",
      name: "Spaying and Neutering",
      stock: 17,
      image:
          "https://www.aspca.org/sites/default/files/pet-care_spay-neuter-you-pets_main-image.jpg",
      description: "",
      isFavourite: false,
      status: "pending",
      price: 2115,
      qty: null),
  ProductModel(
      id: "4",
      name: "Vaccinations",
      stock: 16,
      image:
          "https://www.aspca.org/sites/default/files/pet-care_vaccinations_main-image.jpg",
      isFavourite: false,
      description: "",
      status: "pending",
      price: 2115,
      qty: null),
  ProductModel(
      id: "4",
      name: "Dog Supply Checklist",
      stock: 0,
      isFavourite: false,
      image:
          "https://images.squarespace-cdn.com/content/v1/5c6245b42727be14c54eceb9/1612745118167-DCPZ0AM3PAGQ1R41OSUK/New+Puppy+Essential+Checklist",
      description: "",
      status: "pending",
      price: 2115,
      qty: null),
];
