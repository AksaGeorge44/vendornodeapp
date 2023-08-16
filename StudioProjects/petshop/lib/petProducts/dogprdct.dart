import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:petshop/cart/cartpage.dart';
import 'package:petshop/cart/productdetails.dart';
import 'package:petshop/firebase_helper/prodctmodel.dart';
import 'package:petshop/screens/homepage.dart';
import 'package:petshop/screens/pets/dog/dogcarepage.dart';
import 'package:petshop/model/provider.dart';
import 'package:petshop/model/routes.dart';
import 'package:provider/provider.dart';

class DogprdctPage extends StatefulWidget {
  const DogprdctPage({super.key});

  @override
  State<DogprdctPage> createState() => _DogprdctPageState();
}

class _DogprdctPageState extends State<DogprdctPage> {
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
        AppProvider appProvider=Provider.of<AppProvider>(context);

    return Scaffold(
      appBar: AppBar(
        actions: [
          const Padding(
            padding: EdgeInsets.all(17),
            child: Icon(Icons.notification_add_outlined),
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
        title: const Text("Dog Products"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 35),
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
                                            builder: (context) =>
                                                const HomePage()));
                                  },
                                  child: const Text("HOME")),
                              TextButton(
                                  onPressed: () {}, child: const Text("PUPPY")),
                              TextButton(
                                  onPressed: () {}, child: const Text("ADULT")),
                              TextButton(
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const DogcarePage()));
                                  },
                                  child: const Text("DOG CARE")),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
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
                          hintText:
                              "Search for Products, Food, Medicines and more...."),
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
                        child: Card(
                          color: Colors.white,
                          elevation: 3.0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: SizedBox(
                            height: 70,
                            width: 70,
                            child: Image.network(e),
                          ),
                        ),
                      ),
                    )
                    .toList(),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: SizedBox(
                height: 200,
                width: 500,
                child: CarouselSlider(
                  options: CarouselOptions(
                      aspectRatio: 16 / 9, viewportFraction: 1, autoPlay: true),
                  items: [
                    // Replace the Image.network with your own images
                    Image.network(
                      "https://images-eu.ssl-images-amazon.com/images/G/31/img16/PetSupplies/Pedigree/StorerefreshOct17/rvkumar_2017-09-21T11-28_ab664a_ID_1068730_750x375_2_offer._CB514411476_.jpg",
                      fit: BoxFit.contain,
                    ),

                    Image.network(
                      "https://mypetz.co.in/wp-content/uploads/2021/06/Shop-all-your-favorite-Dog-Treats-2-2.png",
                      fit: BoxFit.cover,
                    ),
                    Image.network(
                      "https://hellosubscription.com/wp-content/uploads/2021/07/image_60e86c97d45cc.png?quality=90&strip=all",
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
              "Best Deals",
              style: TextStyle(
                  fontSize: 23,
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 105, 159, 252)),
            ),
            Padding(
              padding: const EdgeInsets.all(23),
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

List<String> categoriesList = [
  "https://www.nappets.com/wp-content/uploads/2023/01/15-01.jpg",
  "https://m.media-amazon.com/images/I/71rV-YfPmwL.jpg",
  "https://m.media-amazon.com/images/I/81JPNAtTSNL.jpg",
  "https://singpetclub.com/media/catalog/product/cache/c2b537241485d7caf08a9fcbaebdec88/P/a/Paw-Osteosupport-Joint-Care-Powder-Dogs_26.jpg",
  "https://goofytails.com/cdn/shop/products/Untitled-1_6527a59d-1b8c-4fd2-be40-ede8c35b8dcf.jpg?v=1676117247",
  "https://www.goblespetandgrain.com.au/cdn/shop/products/Side-Release-Collar-Reflective-Stitching-HB-K-Pink_c3ff560b-f13a-49d5-99a5-c9c2062e19ce_large.jpg?v=1528253678",
  "https://m.media-amazon.com/images/I/41WV4L3zH2L._SX355_.jpg"
];

List<ProductModel> bestProducts = [
  ProductModel(
      id: "1",
      name: "Pedigree 15kg",
      description:
          "Pedigree Chicken & Vegetables Adult Dry Dog Food is a wholesome meal, packed with essential nutrients vital to the healthy growth of your pet. The natural goodness of cereals, soybean, carrots, peas & milk blend into a tasty treat for your little one. It assures healthier and a shinier coat, strong muscles, good digestive health, healthy bones and teeth and a stronger immune system.",
      image:
          "https://supertails.com/cdn/shop/products/DFODF0007PG_1_1800x1800.jpg?v=1655873803",
          stock: 10,
      isFavourite: false,
      price: 3741,
      status: "pending",
      qty: null),
  ProductModel(
    stock: 20,
      id: "2",
      name: "Drools",
      description:
          " Drools Chicken and Egg Adult Dry Dog Food offers a complete and balanced nutritional diet for your dog. We use Real Chicken which is our #1 ingredient, making our food rich in protein which helps in maintaining lean muscles for top body condition of your dog. It boosts digestive ability and strengthens immune system to keep them active and healthy all day long. ",
      image:
          "https://supertails.com/cdn/shop/files/image536_11563aff-c8f2-427d-a7dc-9e44a2226ede_1800x1800.png?v=1686051438",
      isFavourite: false,
      price: 704,
      status: "pending",
      qty: null),
  ProductModel(
      id: "3",
      name: "Himalaya food",
      stock: 24,
      description:
          "Himalaya Healthy Pet food - Adult is a complete and balanced food with over 20 nutrients, vitamins, and minerals, which provides a perfect balance of nutrition and is fortified with herbs for additional health benefits for adult dogs.",
      image:
          "https://supertails.com/cdn/shop/products/Frame1_3334e5ef-bc42-4d99-a3d7-4d78c5968323_1_1_1800x1800.png?v=1655849011",
      isFavourite: false,
      price: 2195,
      status: "pending",
      qty: null),
  ProductModel(
      id: "4",
      stock: 23,
      name: "Royal Canin",
      image:
          "https://supertails.com/cdn/shop/products/imageframe_8_52777eae-fcba-4fc0-bf6a-0238caafc914_1800x1800.png?v=1678792389",
      description:
          "ROYAL CANIN® Maxi Puppy is specially formulated with the nutritional needs of your large puppy in mind. This food is suitable for large puppies from 2 to 15 months old that will have an adult weight of approximately 26kg-44kg. ROYAL CANIN® Maxi Puppy food contains a patented complex of antioxidants - including the highly beneficial vitamin E - to support your puppy's natural defences while its immune system is immature and still developing. The combination of nutrients that contain high quality protein (such as L.I.P., known for its very high digestibility) as well as prebiotics like FOS help to support your puppy's digestive health Large puppies have a long growth period, that's why they need a diet that accounts for the implications of this period.",
      isFavourite: false,
      status: "pending",
      price: 855,
      qty: null),
  ProductModel(
      id: "5",
      name: "Drools",
      image:
          "https://supertails.com/cdn/shop/products/1_08336a68-44cd-431b-b95a-d08b1d839638_1_1800x1800.jpg?v=1655832022",
      isFavourite: false,
      description:
          "Drools optimum performance adult pet food are easily digestible high quality food contains all the essential nutritional elements that provide a complete balanced diet for your dog ensuring that your dog will be kept in top body condition. The food contain highest quality of protein source from chicken. Drools pet food is the result of comprehensive scientific research by veterinarians and nutritionists. The product are manufactured with atmost care in the most modern and largest plant of Asia.",
      price: 1360,
      status: "pending",
      stock: 22,
      qty: null),
  ProductModel(
      id: "6",
      name: "Drools tablet",
      image:
          "https://www.petoly.in/cdn/shop/products/OILPETDRL128_1_1024x1024.jpg?v=1638186888",
      description:
          "Puppies need balanced nutrition, Drools recognises this and created Drools Chicken and Egg dog food to provide high quality, complete and balanced nutrition, specially formulated with proper protein and fat levels for energy and growth. Real Chicken is the primary ingredient which provides an excellent source of protein. Drools Puppy Chicken and Egg also contains an optimum ratio of Omega 6 and Omega 3 fatty acids to help your puppy have healthy skin and a beautiful coat. Our highest quality ingredients are scientifically formulated to provide 100% complete nutrition with 0% filler.",
      isFavourite: false,
      price: 245,
      status: "pending",
      stock: 22,
      qty: null),
  ProductModel(
      id: "7",
      name: "Maxi dry food",
      image:
          "https://encrypted-tbn0.gstatic.com/shopping?q=tbn:ANd9GcQXdhPicOxE4S84ZdhDj0X4rG8_JOAnFpPuxFkOW6VT2V3qW0DwJsN_Z3RGW5Q8NXMHvPtgjD0r96NkD_varyF167Yvf-CNovo75siooXWmrkBqmjC2RKs2&usqp=CAE",
      description:
          "Maxi chicken and liver adult is a complete food for adult dogs with regular activity. It contains all the essential ingredients to satisfy the nutritional needs of your dog. It promotes healthy digestion and provides overall wellness to your dog. Features: Product type: Dry food for dogs Contains essential vitamins, minerals and antioxidants Promotes growth and immunity Balanced nutrition for adult dogs and supports healthy digestion.",
      isFavourite: false,
      price: 1200,
      status: "pending",
      stock: 12,
      qty: null),
  ProductModel(
      id: "8",
      name: "TRM powder",
      description:
          "Mutiplex powder for dogs & cats comes from the house of TRM – Vetina joint venture and is a very premium vitamin mineral supplement for dogs & cats. Multiplex powder is a complementary Vitamin and Mineral feed"
          "supplement for dogs and cats. Particularly suitable for dogs who are involved in intensive exercise, working dogs, lactating bitches, dogs and cats in rehabilitation, or not being fed a complete diet."
          "Usual dosage is 1g per 5kg bodyweight in dogs & cats as well as puppies and kittens. To be added to feed."
          "Quantity: 200g.",
      image:
          "https://www.loyalpetzone.com/wp-content/uploads/2023/02/multiplex-powder-dogs-cats.jpg",
      isFavourite: false,
      price: 1300,
      stock: 14,
      status: "pending",
      qty: null),
  ProductModel(
      id: "9",
      name: " Allergy food",
      description: "Natural Nutrition for Canine Sensitivities"
          "Best food for dogs with allergies. Contains limited ingredient and is grain free for optimal digestion"
          "Fresh, natural dog food for dogs with allergies: No preservatives, additives or toxic ingredients"
          "Created for dogs with skin, stomach & environmental sensitivities"
          "Clean, balanced superfoods combat allergies from the inside out",
      image:
          "https://res.cloudinary.com/drharveys/image/upload/c_scale,dpr_1.0,f_auto,q_auto,w_500/v1687536389/brand_images/457-allergy.png",
      isFavourite: false,
      price: 560,
      stock: 13,
      status: "pending",
      qty: null),
  ProductModel(
      id: "10",
      name: "Invigro",
      stock: 12,
      description:
          "INVIGRO - using fresh and premium ingredients, we have tailor-made the right diet for dogs of all breeds and sizes, making sure their requisite nutrients levels have been met. Best part is that we do it all without any use of preservatives, chemicals, added flavours or steroids. Just fresh, flavourful and full of goodness!",
      image:
          "https://www.jiomart.com/images/product/original/rvyvwu3boj/invigro-standard-fish-chicken-dry-adult-dog-food-high-protein-variant-standard-20-kg-pack-product-images-orvyvwu3boj-p594684144-0-202210201147.jpg?im=Resize=(1000,1000)",
      isFavourite: false,
      price: 2400,
      status: "pending",
      qty: null),
];
