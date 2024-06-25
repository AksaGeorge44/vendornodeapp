import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:petshop/petProducts/food/dogfood.dart';
import 'package:petshop/screens/appbar/Notificationpage.dart';
import 'package:petshop/appoinments/clinicpage.dart';
import 'package:petshop/cart/productdetails.dart';
import 'package:petshop/firebase_helper/prodctmodel.dart';
import 'package:petshop/petProducts/accessories.dart';
import 'package:petshop/petProducts/petproductpage.dart';
import 'package:petshop/petProducts/toys.dart';
import 'package:petshop/grooming/groomingpage.dart';
import 'package:petshop/screens/pets/cat/catpage.dart';
import 'package:petshop/screens/pets/dog/dogpuppy.dart';
import 'package:petshop/screens/pets/fish/fishpage.dart';
import 'package:petshop/screens/pets/petpage.dart';
import 'package:petshop/screens/appbar/sidenav.dart';
import 'package:petshop/cart/cartpage.dart';
import 'package:petshop/screens/pets/birdspage.dart';
import 'package:petshop/screens/pets/dog/dogpage.dart';
import 'package:petshop/screens/pets/rabbitpage.dart';
import 'package:petshop/model/provider.dart';
import 'package:petshop/model/routes.dart';
import 'package:petshop/searchlistpage.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController search = TextEditingController();
  var size, height, width;

  List<ProductModel> searchList = [];

  void searchProducts(String value) {
    searchList = productModelList
        .where((element) =>
            element.name.toLowerCase().contains(value.toLowerCase()))
        .toList();

    // Check if the search query is not empty and navigate to a new page
    if (searchList.isNotEmpty) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => SearchResultsPage(searchList: searchList),
        ),
      );
    }
    setState(() {});
  }

  List<ProductModel> productModelList = [];
   void navigateToCategoryPage(String imageUrl) {
    // Use the 'imageUrl' to determine the category and navigate accordingly
    // For example, you can check the 'imageUrl' against your 'categoriesList'
    // and navigate to the respective page.

    // Here's an example of how to navigate based on imageUrl for two categories:
    if (imageUrl == categoriesList[0]) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const HomePage()),
      );
    } else if (imageUrl == categoriesList[1]) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const DogPage()),
      );
    } else if (imageUrl == categoriesList[2]) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const CatPage()),
      );
    } else if (imageUrl == categoriesList[3]) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const BirdsPage()),
      );
    } else if (imageUrl == categoriesList[4]) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const FishPage()),
      );
    } 
  }


  @override
  Widget build(BuildContext context) {
    AppProvider appProvider = Provider.of<AppProvider>(context);
// Call your function to get user data

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: const Text("Pet App"),
          actions: [
            Padding(
              padding: const EdgeInsets.all(17),
              child: GestureDetector(
                  onTap: () {
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
        ),
        drawer: const MyDrawer(),
        body: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(
                height: 25,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 25),
                child: SizedBox(
                  width: double.infinity,
                  //color: Colors.black,
                  child: Column(
                    children: [
                      Row(
                        children: [
                          TextButton(
                              onPressed: () {}, child: const Text("HOME")),
                          TextButton(
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const PetPages()));
                              },
                              child: const Text("PETS")),
                          TextButton(
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const ClinicPage()));
                              },
                              child: const Text("CARE")),
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
                        ],
                      )
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16),
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
                            hintText: "Search for Products,Pets,Food,Toys...."),
                      ),
                    ),
                  ],
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
                height: 15,
              ),
              // Padding(
              //   padding: const EdgeInsets.all(20),
              //   child: SizedBox(
              //     child: Card(
              //       color: Colors.white,
              //       elevation: 2.0,
              //       shape: RoundedRectangleBorder(
              //         borderRadius: BorderRadius.circular(20),
              //       ),
              //       child: SingleChildScrollView(
              //         scrollDirection: Axis.horizontal,
              //         child: Row(
              //           children: [
              //             Image.network(
              //               "https://thepetsbasket.com/cdn/shop/files/IMG-20220826-WA0005_1920x700.jpg?v=1661891618",
              //               height: 250,
              //               width: 320,
              //               fit: BoxFit.fill,
              //             ),
              //           ],
              //         ),
              //       ),
              //     ),
              //   ),
              // ),
              const SizedBox(
                height: 20,
              ),
              const Text(
                "Deal of the Day",
                style: TextStyle(
                    fontSize: 23,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 85, 82, 82)),
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
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(
                            height: 17,
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
                              style:
                                  TextStyle(fontSize: 20, color: Colors.black),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 0.1),
                child: TextButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>  const DogFoodPage()));
                    },
                    child: const Text("Explore More")),
              ),
              const Column(
                children: [
                  SizedBox(
                    height: 25,
                  ),
                  Text(
                    "Our Services",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 24,
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
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
                                        const ServicesPage()));
                          },
                          child: Image.network(
                            "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT78Iry47FRPyYay0V0AYiye0IYmyV2_Vdmvg&usqp=CAU",
                            height: 100,
                            width: 100,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                    Card(
                      child: GridTile(
                        child: Image.network(
                          "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRsX6EopKhUDBq7R8WnZCoWqt2s9uV51igLRg&usqp=CAU",
                          height: 100,
                          width: 100,
                          fit: BoxFit.cover,
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
                                    builder: (context) => const ClinicPage()));
                          },
                          child: Image.network(
                            "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS4-InS73EniSuCK1KfkquLy-y_2hUGyS_1Kg&usqp=CAU",
                            height: 100,
                            width: 100,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                    Card(
                      child: GridTile(
                        child: Image.network(
                          "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQZuhe1PNn1q-b0L2dN9OKEM17Z2SsY3xAQUg&usqp=CAU",
                          height: 100,
                          width: 100,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 40,
              ),
              const Column(
                children: [
                  Padding(
                    padding: EdgeInsets.only(right: 30),
                    child: Text(
                      "Shop Now",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 24,
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Card(
                  color: const Color.fromARGB(255, 196, 225, 238),
                  child: GridView.count(
                    crossAxisCount: 3,
                    childAspectRatio: 0.7,
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
                                      builder: (context) => const DogPage()));
                            },
                            child: Image.network(
                              "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQThrkAii6pP5_256RhO_4epr5v2SJJxfExNg&usqp=CAU",
                              fit: BoxFit.contain,
                            ),
                          ),
                        ),
                      ),
                      Card(
                        child: GridTile(
                          child: GestureDetector(
                            onTap: (){
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const DogPuppyPage()));

                            },
                            child: Image.network(
                              "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR1aLwvzFWOCpYJhN_MMJPh4RpF4lg6jLpLhA&usqp=CAU",
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
                                      builder: (context) => const BirdsPage()));
                            },
                            child: Image.network(
                              "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSf-gDFiOxsUNuN0Q5Wsav6k1KO6xXQbRh_hw&usqp=CAU",
                              fit: BoxFit.contain,
                            ),
                          ),
                        ),
                      ),
                      Card(
                        child: GridTile(
                          child: GestureDetector(
                            onTap: (){
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const DogPage()));
                            },
                            child: Image.network(
                              "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRilKAveLmGhhB6v2eRa4f3kYknRpf2uIDGGg&usqp=CAU",
                              fit: BoxFit.contain,
                            ),
                          ),
                        ),
                      ),
                      Card(
                        child: GridTile(
                          child: GestureDetector(
                            onTap: (){
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const BirdsPage()));
                            },
                            child: Image.network(
                              "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR8UEO5y28bWVl5oPcclQ5GfFVSE9SvneagN6XbHEHJCRk_uoGhcfQwaKHkPMQcN24mO70&usqp=CAU",
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
                                          const RabbitPage()));
                            },
                            child: Image.network(
                              "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSTEmb2K7nqztrh0xBU0tb0ACDeLs8765CYiA&usqp=CAU",
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
                                      builder: (context) => const ToysPage()));
                            },
                            child: Image.network(
                              "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTYaau5tAi0qIDIXN02SULP4KrjUiL1_9UccQ&usqp=CAU",
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
                                          const AccessoryPage()));
                            },
                            child: Image.network(
                              "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSrhBqI7yOEb-9SMjSNggRB0SSck0uwyQtJKw&usqp=CAU",
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
                                      builder: (context) => const ToysPage()));
                            },
                            child: Image.network(
                              "https://img3.exportersindia.com/product_images/bc-full/dir_139/4164399/pet-accessories-1521261919-3727000.jpg",
                              fit: BoxFit.contain,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 50,
              ),
              const Text(
                "Book Now",
                style: TextStyle(
                  color: Colors.blue,
                  fontSize: 24,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20),
                child: SizedBox(
                  height: 350,
                  child: Card(
                    color: Colors.white,
                    elevation: 2.0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Padding(
                        padding: const EdgeInsets.all(20),
                        child: Row(
                          children: [
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const ServicesPage()));
                              },
                              child: Image.network(
                                "https://d1csarkz8obe9u.cloudfront.net/posterpreviews/pet-grooming-services-design-template-50416c16842cfab0ebfad201f6f40f6d_screen.jpg?ts=1661510866",
                                height: 300,
                                width: 320,
                                fit: BoxFit.cover,
                              ),
                            ),
                          
                            const SizedBox(
                              width: 20,
                            ),
                            Image.network(
                              "https://img.freepik.com/free-psd/pet-shop-poster-template_23-2148919188.jpg?w=2000",
                              height: 300,
                              width: 300,
                              fit: BoxFit.cover,
                            ),
                            const SizedBox(
                              width: 20,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 40,
              ),
              const Text(
                "*Great Deals",
                style: TextStyle(
                  color: Color.fromARGB(255, 164, 133, 248),
                  fontSize: 24,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20),
                child: SizedBox(
                  height: 250,
                  child: Card(
                    color: Colors.white,
                    elevation: 2.0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Padding(
                        padding: const EdgeInsets.all(20),
                        child: Row(
                          children: [
                          
                          
                            Image.network(
                              "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQCCmgdWxc88b3fR7GkXmgVCKaLEDNGxSyZCo49-qEZ69f_dxyFZbAL7aNL6eikypv_sxc&usqp=CAU",
                              height: 300,
                              width: 300,
                              fit: BoxFit.cover,
                            ),
                            const SizedBox(
                              width: 20,
                            ),
                            Image.network(
                              "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTNFT4Iwk5wZBXy4NK8iuStvppCYdVQbpr0eQ&usqp=CAU",
                              height: 300,
                              width: 280,
                              fit: BoxFit.cover,
                            ),
                            const SizedBox(
                              width: 20,
                            ),
                            Image.network(
                              "https://www.petfoodprocessing.net/ext/resources/PFP-Images/Articles/Smuckers-pet-food-brands.jpg?height=667&t=1544565222&width=1080",
                              height: 300,
                              width: 280,
                              fit: BoxFit.cover,
                            ),
                            const SizedBox(
                              width: 20,
                            ),
                            Image.network(
                              "https://pics.walgreens.com/prodimg/610072/450.jpg",
                              height: 300,
                              width: 280,
                              fit: BoxFit.cover,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20),
                child: SizedBox(
                  child: CarouselSlider(
                    options: CarouselOptions(
                      aspectRatio: 16 / 9,
                      viewportFraction: 0.9,
                      autoPlay: true,
                      autoPlayInterval: const Duration(seconds: 3),
                      autoPlayAnimationDuration:
                          const Duration(milliseconds: 800),
                    ),
                    items: [
                      // Replace the Image.network with your own images
                      Image.network(
                        "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTjB7YIqwbqi5wfEfmq4vAvJqEalVnH0pvqsw&usqp=CAU",
                        fit: BoxFit.cover,
                      ),
                      Image.network(
                        "https://marketplace.canva.com/EAE8jJ4de_E/1/0/1600w/canva-blue-gray-modern-pet-store-%28facebook-post%29-nqdXgnx0epU.jpg",
                        fit: BoxFit.cover,
                      ),
                      Image.network(
                        "https://img.freepik.com/free-vector/adopt-pet-landing-page-template_23-2149016587.jpg?w=360",
                        fit: BoxFit.cover,
                      ),
                      Image.network(
                        "https://img.freepik.com/free-psd/veterinary-clinic-template-banner_23-2148782480.jpg?w=2000",
                        fit: BoxFit.cover,
                      ),

                      // Add more images as needed
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
  "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTr-xV3s-xHt_kxMnOEZI8WXeB_Ytj6Kda6AA&usqp=CAU",
  "https://img.freepik.com/premium-photo/golden-retriever-lying-panting-isolated-white_191971-16974.jpg",
  "https://hips.hearstapps.com/hmg-prod/images/beautiful-smooth-haired-red-cat-lies-on-the-sofa-royalty-free-image-1678488026.jpg?crop=1xw:0.84415xh;center,top",
  "https://media.istockphoto.com/id/1243410279/photo/portrait-of-two-cute-cuddling-budgies-perched-on-branch-with-blue-background-as-symbol-of.jpg?s=612x612&w=0&k=20&c=d3YXfJpe6GS1qqs6V-bQVQpLNKv2Dd6Yvh7unm1KeGU=",
  "https://i.guim.co.uk/img/media/693da12bc9c240bbea26f571c2a65700d177df83/0_153_3600_2160/master/3600.jpg?width=1200&quality=85&auto=format&fit=max&s=67d77705314f5b363a87231dcd476666",
];

List<ProductModel> bestProducts = [
  ProductModel(
      id: "1",
      name: "Pedigree",
      description:
          "Pedigree Chicken & Vegetables Adult Dry Dog Food is a wholesome meal, packed with essential nutrients vital to the healthy growth of your pet. The natural goodness of cereals, soybean, carrots, peas & milk blend into a tasty treat for your little one. It assures healthier and a shinier coat, strong muscles, good digestive health, healthy bones and teeth and a stronger immune system.",
      image:
          "https://supertails.com/cdn/shop/products/DFODF0007PG_1_1800x1800.jpg?v=1655873803",
      isFavourite: false,
      stock: 20,
      price: 3741,
      status: "pending",
      qty: 15),
  ProductModel(
      id: "2",
      name: "Drools",
      description:
          " Drools Chicken and Egg Adult Dry Dog Food offers a complete and balanced nutritional diet for your dog. We use Real Chicken which is our #1 ingredient, making our food rich in protein which helps in maintaining lean muscles for top body condition of your dog. It boosts digestive ability and strengthens immune system to keep them active and healthy all day long. ",
      image:
          "https://th.bing.com/th/id/OIP.XCZXimSfnzAcMTHv9jSK5QHaMS?rs=1&pid=ImgDetMain",
      isFavourite: false,
      price: 704,
      stock: 20,
      status: "pending",
      qty: null),
  ProductModel(
      stock: 20,
      id: "3",
      name: "Himalaya food",
      description:
          "Himalaya Healthy Pet food - Adult is a complete and balanced food with over 20 nutrients, vitamins, and minerals, which provides a perfect balance of nutrition and is fortified with herbs for additional health benefits for adult dogs.",
      image:
          "https://supertails.com/cdn/shop/products/Frame1_3334e5ef-bc42-4d99-a3d7-4d78c5968323_1_1_1800x1800.png?v=1655849011",
      isFavourite: false,
      price: 2195,
      status: "pending",
      qty: null),
  ProductModel(
      stock: 10,
      id: "4",
      name: "Royal Canin",
      image:
      "https://img.chewy.com/is/image/catalog/88037_MAIN._AC_SL1500_V1530030553_.jpg",
      description:
          "ROYAL CANIN® Maxi Puppy is specially formulated with the nutritional needs of your large puppy in mind. This food is suitable for large puppies from 2 to 15 months old that will have an adult weight of approximately 26kg-44kg. ROYAL CANIN® Maxi Puppy food contains a patented complex of antioxidants - including the highly beneficial vitamin E - to support your puppy's natural defences while its immune system is immature and still developing. The combination of nutrients that contain high quality protein (such as L.I.P., known for its very high digestibility) as well as prebiotics like FOS help to support your puppy's digestive health Large puppies have a long growth period, that's why they need a diet that accounts for the implications of this period.",
      isFavourite: false,
      status: "pending",
      price: 855,
      qty: null),
];
