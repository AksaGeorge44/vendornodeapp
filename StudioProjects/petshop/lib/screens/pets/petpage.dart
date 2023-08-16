import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:petshop/appoinments/clinicpage.dart';
import 'package:petshop/cart/cartpage.dart';
import 'package:petshop/cart/productdetails.dart';
import 'package:petshop/firebase_helper/prodctmodel.dart';
import 'package:petshop/petProducts/petproductpage.dart';
import 'package:petshop/screens/appbar/Notificationpage.dart';
import 'package:petshop/screens/appbar/contact.dart';
import 'package:petshop/grooming/groomingpage.dart';
import 'package:petshop/screens/homepage.dart';
import 'package:petshop/screens/pets/birdspage.dart';
import 'package:petshop/screens/pets/cat/catpage.dart';
import 'package:petshop/screens/pets/dog/dogpage.dart';
import 'package:petshop/screens/pets/duckpage.dart';
import 'package:petshop/screens/pets/fish/fishpage.dart';
import 'package:petshop/screens/pets/guinepig.dart';
import 'package:petshop/screens/pets/hamster.dart';
import 'package:petshop/screens/pets/henpage.dart';
import 'package:petshop/screens/pets/persiancat.dart';
import 'package:petshop/screens/pets/rabbitpage.dart';
import 'package:petshop/model/provider.dart';
import 'package:petshop/model/routes.dart';
import 'package:provider/provider.dart';

class PetPages extends StatefulWidget {
  const PetPages({super.key});

  @override
  State<PetPages> createState() => _PetPagesState();
}

class _PetPagesState extends State<PetPages> {
  List<ProductModel> productModelList = [];

  void navigateToCategoryPage(String imageUrl) {
    // Use the 'imageUrl' to determine the category and navigate accordingly
    // For example, you can check the 'imageUrl' against your 'categoriesList'
    // and navigate to the respective page.

    // Here's an example of how to navigate based on imageUrl for two categories:
    if (imageUrl == categoriesList[0]) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const DogPage()),
      );
    } else if (imageUrl == categoriesList[1]) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const CatPage()),
      );
    } else if (imageUrl == categoriesList[2]) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const FishPage()),
      );
    } else if (imageUrl == categoriesList[3]) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const BirdsPage()),
      );
    } else if (imageUrl == categoriesList[4]) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const RabbitPage()),
      );
    } else if (imageUrl == categoriesList[5]) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const DuckPage()),
      );
    } else if (imageUrl == categoriesList[6]) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const HenPage()),
      );
    }
  }

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
        title: const Text("Pets"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              const SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 12),
                child: SizedBox(
                  width: double.infinity,
                  //color: Colors.black,
                  child: Column(
                    children: [
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
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
                                              const ClinicPage()));
                                },
                                child: const Text("CLINIC")),
                            TextButton(
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const PetProductPage()));
                                },
                                child: const Text("SHOP")),
                            TextButton(
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const ServicesPage()));
                                },
                                child: const Text("SERVICES")),
                            TextButton(
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const ContactPage()));
                                },
                                child: const Text("CONTACT")),
                          ],
                        ),
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
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20)),
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
                        autoPlay: true),
                    items: [
                      // Replace the Image.network with your own images
                      Image.network(
                        "https://www.pethaus.com/cdn/shop/collections/PH-Clearance-Sale-1000-x-500-banner.png?v=1654504668",
                        fit: BoxFit.fill,
                      ),

                      Image.network(
                        "https://img.freepik.com/free-vector/veterinary-clinic-sale-banner-template_23-2149719955.jpg",
                        fit: BoxFit.contain,
                      ),

                      // Add more images as needed
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 25,
              ),
              const Text(
                "Categories",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 25,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: categoriesList
                      .map(
                        (e) => Padding(
                          padding: const EdgeInsets.only(left: 15),
                          child: GestureDetector(
                            onTap: () => navigateToCategoryPage(
                                e), // Handle navigation here
                            child: Card(
                              color: Colors.white,
                              elevation: 3.0,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: SizedBox(
                                height: 80,
                                width: 80,
                                child: Image.network(e),
                              ),
                            ),
                          ),
                        ),
                      )
                      .toList(),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              const Padding(
                padding: EdgeInsets.all(15),
                child: Text(
                  "New One's",
                  style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 108, 156, 238)),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(15),
                child: Card(
                  child: GridView.builder(
                    padding: const EdgeInsets.all(11),
                    shrinkWrap: true,
                    itemCount: bestProducts.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
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
                              padding: const EdgeInsets.all(19),
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
                                style: TextStyle(
                                    fontSize: 20, color: Colors.black),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ),
              const SizedBox(
                height: 25,
              ),
              const Text(
                "Find your purr-fect pet match!",
                style: TextStyle(
                  color: Colors.blueAccent,
                  fontSize: 20,
                ),
              ),
              const SizedBox(
                height: 25,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Card(
                  child: GridView.count(
                    crossAxisCount: 2,
                    childAspectRatio: 0.9,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    children: [
                      Card(
                        child: GridTile(
                          child: GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const PersiancatPage()));
                            },
                            child: Image.network(
                              "https://www.pngall.com/wp-content/uploads/6/Persian-Cat-PNG-Image.png",
                              height: 60,
                              width: 60,
                              fit: BoxFit.contain,
                            ),
                          ),
                        ),
                      ),
                      Card(
                        child: GridTile(
                          child: GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const PersiancatPage()));
                            },
                            child: Image.network(
                              "https://w7.pngwing.com/pngs/838/26/png-transparent-persian-cat-maine-coon-norwegian-forest-cat-munchkin-cat-pet-sitting-persian-miscellaneous-mammal-cat-like-mammal-thumbnail.png",
                              fit: BoxFit.contain,
                              height: 60,
                              width: 60,
                            ),
                          ),
                        ),
                      ),
                      Card(
                        child: GridTile(
                          child: GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const HamsterPage()));
                            },
                            child: Image.network(
                              "https://images.saymedia-content.com/.image/ar_4:3%2Cc_fill%2Ccs_srgb%2Cfl_progressive%2Cq_auto:eco%2Cw_1200/MTk3MDUzOTA3NTMxMjEyMDk1/my-hamster-is-pregnant-now-what.jpg",
                              fit: BoxFit.contain,
                            ),
                          ),
                        ),
                      ),
                      Card(
                        child: GridTile(
                          child: GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const HamsterPage()));
                            },
                            child: Image.network(
                              "https://famillypet.com/wp-content/uploads/2020/01/race-de-hamster-1-768x512-1.jpg",
                              fit: BoxFit.contain,
                              height: 60,
                              width: 60,
                            ),
                          ),
                        ),
                      ),
                      Card(
                        child: GridTile(
                          child: GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const GuinePage()));
                            },
                            child: Image.network(
                              "https://nationaltoday.com/wp-content/uploads/2021/07/Guinea-Pig-Appreciation-Day-1200x834.jpg",
                              fit: BoxFit.contain,
                              height: 60,
                              width: 60,
                            ),
                          ),
                        ),
                      ),
                      Card(
                        child: GridTile(
                          child: GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const GuinePage()));
                            },
                            child: Image.network(
                              "https://cdn.britannica.com/93/150093-050-A20009B5/guinea-pigs-coloration.jpg",
                              fit: BoxFit.contain,
                              height: 60,
                              width: 60,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

List<String> categoriesList = [
  "https://img.freepik.com/premium-photo/golden-retriever-lying-panting-isolated-white_191971-16974.jpg?w=2000",
  "https://www.seekpng.com/png/detail/406-4068283_animal-cat-pet-isolated-sit-wait-imagenes-de.png",
  "https://cdn.imgbin.com/0/21/1/imgbin-pet-sitting-oranda-aquarium-fish-fish-bowl-two-goldfishes-in-fish-bowl-rSQ0ybZ84DeGuYN6YNpDdGDFy.jpg",
  "https://w1.pngwing.com/pngs/72/223/png-transparent-dog-and-cat-budgerigar-bird-parrot-cockatiel-lovebird-pet-parakeet.png",
  "https://freepngimg.com/thumb/rabbit/20706-7-transparent-pet-bunny-rabbit.png",
  "https://i.pinimg.com/originals/39/24/01/392401cd8ab1f6dbf057869e753662c4.png",
  "https://w7.pngwing.com/pngs/62/658/png-transparent-country-cock-rooster-thumbnail.png",
];
List<ProductModel> bestProducts = [
  ProductModel(
      id: "1",
      name: "Persian Cat",
      stock: 10,
      description: "4 year old Persian cat Maine Coon Norwegian Forest cat",
      image:
          "https://w7.pngwing.com/pngs/838/26/png-transparent-persian-cat-maine-coon-norwegian-forest-cat-munchkin-cat-pet-sitting-persian-miscellaneous-mammal-cat-like-mammal-thumbnail.png",
      isFavourite: false,
      price: 10000,
      status: "pending",
      qty: null),
  ProductModel(
      id: "2",
      name: "Scottish Cat",
      stock: 25,
      image:
          "https://w7.pngwing.com/pngs/106/1013/png-transparent-scottish-fold-british-shorthair-persian-cat-siamese-cat-selkirk-rex-gray-cat-mammal-animals-cat-like-mammal-thumbnail.png",
      description:
          "Scottish Fold British Shorthair Persian cat Siamese cat Selkirk Rex, Gray cat, mammal",
      isFavourite: false,
      price: 12000,
      status: "pending",
      qty: null),
  ProductModel(
      id: "3",
      name: "Jerman Sheperd",
      stock: 16,
      image: "https://pngimg.com/d/dog_PNG172.png",
      description: "5year old male jerman sheperd",
      isFavourite: false,
      price: 14000,
      status: "pending",
      qty: null),
  ProductModel(
      id: "4",
      stock: 15,
      name: "Labrador",
      image: "https://freepngdownload.com/image/thumb/dog-png-with-teeth.png",
      description: "4 year old female Labrador with browinish white colour",
      isFavourite: false,
      status: "pending",
      price: 15000,
      qty: null),
];
