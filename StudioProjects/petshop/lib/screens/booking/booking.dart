import 'package:flutter/material.dart';
import 'package:petshop/screens/appbar/Notificationpage.dart';
import 'package:petshop/cart/cartpage.dart';
import 'package:petshop/cart/productdetails.dart';
import 'package:petshop/firebase_helper/prodctmodel.dart';
import 'package:petshop/petProducts/petproductpage.dart';
import 'package:petshop/screens/pets/petpage.dart';
import 'package:petshop/grooming/groomingpage.dart';
import 'package:petshop/appoinments/clinicpage.dart';
import 'package:petshop/model/provider.dart';
import 'package:petshop/model/routes.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class BookingPage extends StatefulWidget {
  const BookingPage({super.key});

  @override
  State<BookingPage> createState() => _BookingPageState();
}

class _BookingPageState extends State<BookingPage> {
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
  Future<void> _launchCall(String phoneNumber) async {
    final phoneUrl = 'tel:$phoneNumber';
    if (await canLaunch(phoneUrl)) {
      await launch(phoneUrl);
    } else {
      throw 'Could not launch $phoneUrl';
    }
  }

  @override
  Widget build(BuildContext context) {
    AppProvider appProvider = Provider.of<AppProvider>(context);

    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              _launchCall(
                  '9922343456'); // Replace 'PHONE_NUMBER' with the actual phone number
            },
            icon: const Icon(Icons.call),
          ),
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
        title: const Text("Booking"),
      ),
      body: SizedBox(
        height: double.infinity,
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(
                height: 25,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 50),
                child: Row(
                  children: [
                    TextButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const PetPages()));
                        },
                        child: const Text("PET")),
                    TextButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const ServicesPage()));
                        },
                        child: const Text("SERVICE")),
                    TextButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const ClinicPage()));
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
                        child: const Text("PRODUCT")),
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
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
                      hintText: "Search for Products,Pets,Food,Toys...."),
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
                            "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSsUs5ZCjZz-iPoxgwsAjZVEzBgumgpYkNiNuMYVJQ2yUFBCZVq_tZehHqrllCs3i-X7BM&usqp=CAU",
                            height: 320,
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
                height: 40,
              ),
              const Text(
                "Deal of the Day",
                style: TextStyle(
                    fontSize: 23,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 105, 159, 252)),
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
            ],
          ),
        ),
      ),
    );
  }
}

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
