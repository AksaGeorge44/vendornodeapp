import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:petshop/cart/productdetails.dart';
import 'package:petshop/model/provider.dart';
import 'package:petshop/model/routes.dart';
import 'package:petshop/screens/appbar/Notificationpage.dart';
import 'package:petshop/cart/cartpage.dart';
import 'package:petshop/firebase_helper/prodctmodel.dart';
import 'package:petshop/petProducts/accessories.dart';
import 'package:petshop/petProducts/birdsprdct.dart';
import 'package:petshop/petProducts/cages.dart';
import 'package:petshop/petProducts/catproduct.dart';
import 'package:petshop/petProducts/dogprdct.dart';
import 'package:petshop/petProducts/duckprdct.dart';
import 'package:petshop/petProducts/fishprdct.dart';
import 'package:petshop/petProducts/foodpage.dart';
import 'package:petshop/petProducts/henprdct.dart';
import 'package:petshop/petProducts/medicine.dart';
import 'package:petshop/petProducts/prdctexplore.dart';
import 'package:petshop/petProducts/rabbitprdct.dart';
import 'package:petshop/petProducts/supplements.dart';
import 'package:petshop/petProducts/toys.dart';
import 'package:provider/provider.dart';

class PetProductPage extends StatefulWidget {
  const PetProductPage({super.key});

  @override
  State<PetProductPage> createState() => _PetProductPageState();
}

class _PetProductPageState extends State<PetProductPage> {
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

  void navigateToCategoryPage(String imageUrl) {
    // Use the 'imageUrl' to determine the category and navigate accordingly
    // For example, you can check the 'imageUrl' against your 'categoriesList'
    // and navigate to the respective page.

    // Here's an example of how to navigate based on imageUrl for two categories:
    if (imageUrl == categoriesList[0]) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const DogprdctPage()),
      );
    } else if (imageUrl == categoriesList[1]) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const CatprdctPage()),
      );
    } else if (imageUrl == categoriesList[2]) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const FishprdctPage()),
      );
    } else if (imageUrl == categoriesList[3]) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const BirdsprdctPage()),
      );
    } else if (imageUrl == categoriesList[4]) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const RabbitprdctPage()),
      );
    } else if (imageUrl == categoriesList[5]) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const DuckprdctPage()),
      );
    } else if (imageUrl == categoriesList[6]) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const HenprdctPage()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
        AppProvider appProvider = Provider.of<AppProvider>(context);

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
        title: const Text("Products"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              SizedBox(
                width: double.infinity,
                child: Column(
                  children: [
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            TextButton(
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const FoodPage()));
                                },
                                child: const Text("FOOD")),
                            TextButton(
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const SupplementsPage()));
                                },
                                child: const Text("SUPPLEMENTS")),
                            TextButton(
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const AccessoryPage()));
                                },
                                child: const Text("ACCESSORIES")),
                            TextButton(
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const ToysPage()));
                                },
                                child: const Text("TOYS")),
                            TextButton(
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const CagesPage()));
                                },
                                child: const Text("CAGES")),
                            TextButton(
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const MedicinePage()));
                                },
                                child: const Text("MEDICINES")),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(17),
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
                            hintText: "Search for Products and more...."),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 190,
                child: CarouselSlider(
                  options: CarouselOptions(
                      aspectRatio: 16 / 9, viewportFraction: 1, ),
                  items: [
                    // Replace the Image.network with your own images
                    Image.network(
                      "https://freebies2deals.com/wp-content/uploads/2013/11/freebies2deals-wag-25-discount.png",
                      fit: BoxFit.contain,
                    ),

                    Image.network(
                      "https://img.freepik.com/free-vector/veterinary-clinic-sale-banner-template_23-2149719955.jpg",
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
                "Shop By Pet",
                style: TextStyle(
                  color: Color.fromARGB(255, 15, 92, 131),
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
                                height: 100,
                                width: 100,
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
                height: 40,
              ),
              const Text(
                "Super Deals",
                style: TextStyle(
                  color: Colors.blueAccent,
                  fontSize: 25,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                  child: Card(
                      child: Padding(
                padding: const EdgeInsets.all(15),
                child: Image.network(
                  "https://goofytails.com/cdn/shop/files/freedom_sale_mobile_banner_fro_goofytails.com.jpg?v=1690893067",
                  fit: BoxFit.cover,
                ),
              ))),
              const SizedBox(
                height: 40,
              ),
              const Text(
                "Deal of the Day",
                style: TextStyle(
                  color: Colors.blueAccent,
                  fontSize: 23,
                ),
              ),
              const SizedBox(
                height: 35,
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
                          child: Image.network(
                            "https://media.mediazs.com/bilder/7/200/pla_163496_cfl_dog_sterilised_mini_1kg_7.jpg",
                            fit: BoxFit.contain,
                            height: 150,
                            width: 150,
                          ),
                        ),
                      ),
                      Card(
                        child: GridTile(
                          child: Image.network(
                            "https://naturalpetfoods.ca/cdn/shop/products/boreal-proper-chicken-dry-cat-food-298434_1024x.jpg?v=1675460136",
                            fit: BoxFit.contain,
                            height: 150,
                            width: 150,
                          ),
                        ),
                      ),
                      Card(
                        child: GridTile(
                          child: Image.network(
                            "https://s7d2.scene7.com/is/image/PetSmart/5197084",
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),
                      Card(
                        child: GridTile(
                          child: Image.network(
                            "https://cdn.shopify.com/s/files/1/0565/8021/0861/products/Frame1-2022-02-02T013047.801_11b6fabd-2e39-4730-bae2-a56b24b86282_large.png?v=1655819673",
                            fit: BoxFit.contain,
                            height: 150,
                            width: 150,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              TextButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const PrdctExplrPage()));
                  },
                  child: const Text("Explore More")),
              const SizedBox(
                height: 30,
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
                        "https://i.pinimg.com/originals/15/9c/47/159c47a2bb3adb75275b63ec4c3a72e9.png",
                        fit: BoxFit.contain,
                      ),

                      Image.network(
                        "https://shop.petlife.com/cdn/shop/files/Food_and_Treats_25_Sale_-_min_300x300.jpg?v=1675378102",
                        fit: BoxFit.contain,
                      ),
                      Image.network(
                        "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQQvrmxtsBr5WRTN3qqaUyiVpV5B1EDCQyPqA&usqp=CAU",
                        fit: BoxFit.contain,
                      ),
                      Image.network(
                        "https://www.rspcaworldforpets.com.au/attachments/PageLayout/107/WFP_Always%20On_Aug23_web%20banner_1_teeth%20clean.jpg?ts=1690851352",
                        fit: BoxFit.contain,
                      ),
                      Image.network(
                        "https://img.paisawapas.com/ovz3vew9pw/2022/08/22121419/super-tail-pw-deal.jpg",
                        fit: BoxFit.contain,
                      ),

                      // Add more images as needed
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              const Text(
                "Accessories & Toys",
                style: TextStyle(
                  color: Colors.purpleAccent,
                  fontSize: 20,
                ),
              ),
              SizedBox(
                  height: 280,
                  width: 350,
                  child: Card(
                      child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const AccessoryPage()));
                    },
                    child: Image.network(
                      "https://st2.depositphotos.com/10614052/44926/i/600/depositphotos_449265910-stock-photo-advertisement-banner-pet-accessories-dog.jpg",
                    ),
                  ))),
              const SizedBox(
                height: 40,
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
      name: "True Instinct",
      description:
          "True Instinct Adult Dry Dog Food is a wholesome meal, packed with essential nutrients vital to the healthy growth of your pet. The natural goodness of cereals, soybean, carrots, peas & milk blend into a tasty treat for your little one. It assures healthier and a shinier coat, strong muscles, good digestive health, healthy bones and teeth and a stronger immune system.",
      image:
      "https://www.foodlionuk.shop/wp-content/uploads/1681/59/your-source-for-personalized-purina-one-true-instinct-high-protein-formula-with-real-beef-and-salmon-dry-dog-food-united-kingdom-on-sale_0.jpg",

      isFavourite: false,
      stock: 20,
      price: 3741,
      status: "pending",
      qty: 15),
  ProductModel(
      id: "2",
      name: "Chicopee",
      description:
          " Chicopee Chicken and Egg Adult Dry Dog Food offers a complete and balanced nutritional diet for your dog. We use Real Chicken which is our #1 ingredient, making our food rich in protein which helps in maintaining lean muscles for top body condition of your dog. It boosts digestive ability and strengthens immune system to keep them active and healthy all day long. ",
      image:
                                  "https://m.media-amazon.com/images/I/81ubviR9ktL._AC_UF894,1000_QL80_.jpg",

      isFavourite: false,
      price: 500,
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
          "https://supertails.com/cdn/shop/products/imageframe_8_52777eae-fcba-4fc0-bf6a-0238caafc914_1800x1800.png?v=1678792389",
      description:
          "ROYAL CANIN® Maxi Puppy is specially formulated with the nutritional needs of your large puppy in mind. This food is suitable for large puppies from 2 to 15 months old that will have an adult weight of approximately 26kg-44kg. ROYAL CANIN® Maxi Puppy food contains a patented complex of antioxidants - including the highly beneficial vitamin E - to support your puppy's natural defences while its immune system is immature and still developing. The combination of nutrients that contain high quality protein (such as L.I.P., known for its very high digestibility) as well as prebiotics like FOS help to support your puppy's digestive health Large puppies have a long growth period, that's why they need a diet that accounts for the implications of this period.",
      isFavourite: false,
      status: "pending",
      price: 855,
      qty: null),
];
