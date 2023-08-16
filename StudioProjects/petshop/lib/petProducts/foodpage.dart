import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:petshop/petProducts/food/catfoodpage.dart';
import 'package:petshop/petProducts/food/dogfood.dart';
import 'package:petshop/petProducts/food/puppyfood.dart';
import 'package:petshop/screens/appbar/Notificationpage.dart';
import 'package:petshop/cart/cartpage.dart';
import 'package:petshop/firebase_helper/prodctmodel.dart';
import 'package:petshop/cart/productdetails.dart';
import 'package:petshop/model/provider.dart';
import 'package:petshop/model/routes.dart';
import 'package:provider/provider.dart';

class FoodPage extends StatefulWidget {
  const FoodPage({super.key});

  @override
  State<FoodPage> createState() => _FoodPageState();
}

class _FoodPageState extends State<FoodPage> {
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
        title: const Text("Foods"),
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
                                          const DogFoodPage()));
                            },
                            child: const Text("DOG")),
                        TextButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const PuppyFoodPage()));
                            },
                            child: const Text("PUPPY")),
                        TextButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const CatFoodPage()));
                            },
                            child: const Text("CAT")),
                        TextButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const FoodPage()));
                            },
                            child: const Text("KITTEN")),
                        TextButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const FoodPage()));
                            },
                            child: const Text("BIRDS")),
                        TextButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const FoodPage()));
                            },
                            child: const Text("FISH")),
                        TextButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const FoodPage()));
                            },
                            child: const Text("RABBIT")),
                        TextButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const FoodPage()));
                            },
                            child: const Text("DUCK")),
                        TextButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const FoodPage()));
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
                    "https://mypetz.co.in/wp-content/uploads/2021/06/Shop-all-your-favorite-Dog-Treats-2-2.png",
                    fit: BoxFit.cover,
                  ),

                  Image.network(
                    "https://etimg.etb2bimg.com/photo/83146078.cms",
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
              "Deal of the Day",
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
      name: "Pedigree",
      description: "Pedigree"
          "Pedigree Chicken & Vegetables Adult Dry Dog Food"
          "High-quality, wholesome, balanced dog food"
          
          "MRP : ₹100.00 Sale price₹90.00 10% Off incl. of all taxes",
      image:
          "https://m.media-amazon.com/images/I/61R7aAdmu0L._AC_UF1000,1000_QL80_.jpg",
      isFavourite: false,
      price: 100,
      status: "pending",
      stock: 10,
      qty: null),
  ProductModel(
      id: "2",
      name: "Royal Canin ",
      description:
          "Royal Canin Maxi Adult Dry Dog Food.Healthy & highly digestible"
          "Regular priceMRP : ₹850.00 Sale price₹722.50 15% Off incl. of all taxes",
          stock: 30,
      image:
          "https://headsupfortails.com/cdn/shop/products/MaxiAdult-1.png?v=1674795514&width=823",
      isFavourite: false,
      price: 745,
      status: "pending",
      
      
      qty: null),
  ProductModel(
      id: "3",
      name: "Natures Hug",
      stock: 16,
      description:
          "Nature's HUG Junior Growth Toy & Small Breed Vegan Dry Dog Food - 2.27 kg.Supports bone structure and immunity",
      image:
          "https://headsupfortails.com/cdn/shop/products/Nature_sHUGJuniorGrowthToy_SmallBreedVeganDryDogFood-2.27kg.jpg?v=1681965063&width=823",
      isFavourite: false,
      price: 1999,
      status: "pending",
      qty: null),
  ProductModel(
      id: "4",
      name: "Farmina",
      stock: 12,
      description:
          "Farmina:Farmina N&D Low Grain Mini Breed Dry Puppy Food - Chicken & Pomegranate.Preservative-free, GMO-free, delicious dog food"
          "Regular priceMRP : ₹790.00 Sale price₹711.00 10% Offincl. of all taxes",
      image:
          "https://headsupfortails.com/cdn/shop/products/FarminaN_DLowGrainMiniBreedDryPuppyFood-Chicken_Pomegranate.jpg?v=1681905301&width=823",
      isFavourite: false,
      status: "pending",
      price: 711,
      qty: null),
  ProductModel(
      id: "5",
      name: "Origen",
      stock: 15,
      description:
          "Orijen Grain Free Large Breed Dry Puppy Food.High protein, grain-free dog food with fresh ingredients"
          "Regular priceMRP : ₹6,899.00 incl. of all taxes",
      image:
          "https://headsupfortails.com/cdn/shop/products/OrijenGrainFreeLargeBreedDryPuppyFood-2.jpg?v=1681965128&width=823",
      isFavourite: false,
      price: 6500,
      status: "pending",
      qty: null),
  ProductModel(
      id: "6",
      name: "Whiskas",
      stock: 12,
      description:
          "Whiskas Ocean Fish Adult Dry Cat Food.High-quality, balanced, flavourful cat food",
      image:
          "https://cdn.shopify.com/s/files/1/0086/0795/7054/files/WhiskasTunaAdultDryCatFood.jpg?v=1683109213&width=533",
      isFavourite: false,
      price: 215,
      status: "pending",
      qty: null),
  ProductModel(
      id: "7",
      name: "Whiskas Tuna",
      stock: 17,
      description:
          "Whiskas Tuna in Jelly Adult Wet Cat Food - 85 gm packs.Complete, balanced, easy to eat & digest",
      image:
          "https://headsupfortails.com/cdn/shop/files/WhiskasTunainJellyAdultWetCatFood-85gmpacks.jpg?v=1683109340&width=823",
      isFavourite: false,
      price: 50,
      status: "pending",
      qty: null),
  ProductModel(
      id: "8",
      name: "Millets",
      stock: 15,
      description:
          "The Birds Company Foxtail Millet (Kangni), Bird Food for All Life Stages Canary, Finches, Waxbills, Budgies, Lovebirds, Cockatiels, Parrots & Parakeets, 450 g",
      image:
          "https://m.media-amazon.com/images/I/91misVYCiXL._AC_UF1000,1000_QL80_.jpg",
      isFavourite: false,
      price: 167,
      status: "pending",
      qty: null),
  ProductModel(
      id: "9",
      name: "Bird Food",
      description:
          "Bird Food Sparrow Bird Feed 450 Gram, More Than 6 Grains Refill Pack for All Small Wild Birds, House Sparrows, Finches",
      image: "https://m.media-amazon.com/images/I/71uaxR3qB1L._SY450_.jpg",
      isFavourite: false,
      price: 150,
      status: "pending",
      stock: 14,
      qty: null),
  ProductModel(
      id: "10",
      name: "Boltz",
      image: "https://m.media-amazon.com/images/I/61agEiMvxoL.jpg",
      stock: 12,
      description:
          "Boltz Parrot Food 1Kg for Big Parrot,African Grey Parrot,Sun Conure,Macaw,Lovebird and Alexander - All Life Stages Mix Seeds,1 Kg",
      isFavourite: false,
      price: 449,
      status: "pending",
      qty: null),
  ProductModel(
      id: "11",
      stock: 16,
      name: "Red Hen",
      image: "https://www.lauckemills.com.au/spnet6/img/I/1/2/8/5/I_128520.jpg",
      description:
          "Red Hen Free Range Layer is a high energy premium quality poultry breeder and layer food formulated to be fed to all classes of breeding and laying poultry.This high specification diet is nutritionally balanced for essential nutrients necessary for high production, fertility and hatchability.",
      isFavourite: false,
      price: 530,
      status: "pending",
      qty: null),
  ProductModel(
      id: "12",
      name: "Rabbit Food",
      stock: 16,
      image:
          "https://www.taiyogroup.in/wp-content/uploads/2021/01/Untitled-design-24-540x540.png",
      description:
          "Petslife Premium Rabbit Food.Petslife small pets food provides the essential nutrients your pet needs for a long, healthy life, Natural ingredients that aid in digestive health. Naturally preserved for ideal freshness, Formulated with fatty acids to support heart, brain and visual functions.",
      isFavourite: false,
      price: 112,
      status: "pending",
      qty: null),
  ProductModel(
      id: "13",
      name: "Rabbit Pellets",
      stock: 29,
      image:
          "https://starmilling.com/wp-content/uploads/2020/11/KelleysRabbit-Pellets-525x1024.jpg",
      description:
          "Petslife Premium Rabbit Food.Petslife small pets food provides the essential nutrients your pet needs for a long, healthy life, Natural ingredients that aid in digestive health. Naturally preserved for ideal freshness, Formulated with fatty acids to support heart, brain and visual functions.",
      isFavourite: false,
      price: 200,
      status: "pending",
      qty: null),
  ProductModel(
      id: "14",
      name: "Fish Food",
      stock: 16,
      image:
          "https://n2.sdlcdn.com/imgs/k/b/n/850X995_sharpened_2_1/Taiyo-Aini-Fish-food-fast-SDL881859766-1-b71e0.webp",
      description:
          "Taiyo Aini Fish food fast red 330g Premium quality fish foods",
      isFavourite: false,
      price: 239,
      status: "pending",
      qty: null),
];
