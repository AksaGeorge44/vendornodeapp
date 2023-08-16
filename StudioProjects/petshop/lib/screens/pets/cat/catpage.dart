import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:petshop/cart/cartpage.dart';
import 'package:petshop/firebase_helper/prodctmodel.dart';
import 'package:petshop/cart/productdetails.dart';
import 'package:petshop/screens/homepage.dart';
import 'package:petshop/screens/pets/cat/catcare.dart';
import 'package:petshop/model/provider.dart';
import 'package:petshop/model/routes.dart';
import 'package:provider/provider.dart';

class CatPage extends StatefulWidget {
  const CatPage({super.key});

  @override
  State<CatPage> createState() => _CatPageState();
}

class _CatPageState extends State<CatPage> {
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
        title: const Text("Cats"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 80),
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
                            onPressed: () {}, child: const Text("KITTEN")),
                        TextButton(
                            onPressed: () {}, child: const Text("ADULT")),
                        TextButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const CatCarePage()));
                            },
                            child: const Text("CAT CARE")),
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
                      "https://media.istockphoto.com/id/1058510144/photo/cats-sitting-in-a-row.jpg?s=612x612&w=0&k=20&c=mA0-E6BQzPl9eN4e-c9gXTmJdGjf-AOQcVu1_Y7jAyc=",
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
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 182, 135, 190)),
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
      name: "Persian Cat",
      stock: 16,
      description:
          "A show-style Persian cat has an extremely long and thick coat, short legs, a wide head with the ears set far apart, large eyes, and an extremely shortened muzzle. The breed was originally established with a short muzzle, but over time, this characteristic has become extremely exaggerated, particularly in North America. Persian cats can have virtually any color or markings.",
      image:
          "https://cattime.com/wp-content/uploads/sites/14/2011/12/file_2676_persian-460x290.jpg",
      isFavourite: false,
      price: 10000,
      status: "pending",
      qty: null),
  ProductModel(
      id: "2",
      name: "Ragdoll",
      description:
          "The big, beautiful ragdoll cat does not reach its full size, about 15 pounds on average, until about four years of age. With its easygoing personality and social temperament, the ragdoll is ready to be friends with just about anyone. Prepare your lap for extended cuddling sessions in which your ragdoll will flop like a mop across your legs and expect enthusiastic belly rubs. The ragdoll does not need a lot of exercise or rambunctious play time, but snuggle time is essential.",
      image:
          "https://encrypted-tbn3.gstatic.com/licensed-image?q=tbn:ANd9GcQY4gPbyFQGWoyjFrKYzOIahxfeivKHbcLkeqsY5LWP9Q3m2bPAITrz_hwi108_LJpDpIe-OSrOL7h7kBY",
      isFavourite: false,
      price: 3899,
      stock: 15,
      status: "pending",
      qty: null),
  ProductModel(
      id: "3",
      name: "Siamese Cat",
      description:
          "The breed standard of the modern Siamese calls for an elongated, tubular, and muscular body and a triangular head, forming a perfect triangle from the tip of the nose to each tip of the ear. The eyes are almond-shaped and light blue, while the ears are large, wide-based, and positioned more toward the side of the head. The breed has a long neck, a slender tail, and fur that is short, glossy, fine, and adheres to the body with no undercoat. ",
      image:
          "https://encrypted-tbn1.gstatic.com/licensed-image?q=tbn:ANd9GcSTkG18MNcdgf52ZpQmPS6oGY4KKCKJ5ecRNfGlpEhrSS0xeWsSqVVrmhtvMsIqESfwwO4FHrvOOVMBApk",
      isFavourite: false,
      stock: 14,
      price: 5500,
      status: "pending",
      qty: null),
  ProductModel(
      id: "4",
      name: "Birman",
      stock: 10,
      description:
          "The Birman is another ‘colour point’ cat, with a pale cream to white coat over the body, and coloured points, i.e., the face, ears, legs and tail. The Birman is a semi long-haired cat with a silky soft, luxuriant coat, beautiful blue eyes and pure white feet (gloves on the front paws, socks on the back.) Under the fur this is a moderately built cat, medium to large with a well-muscled body, rounded face and neat ears.",
      image:
          "https://encrypted-tbn1.gstatic.com/licensed-image?q=tbn:ANd9GcT7lkMy8AKIS51EabEKBRBxF3jgi5xk4j6tqWCsr0bzyUGdhsHbWXaetM8peTvAXM9GXlS7tvo9CWNARuM",
      isFavourite: false,
      status: "pending",
      price: 6000,
      qty: null),
  ProductModel(
      id: "5",
      name: "Bombay Cat",
      stock: 16,
      description:
          "This breed is stocky and somewhat compact, but is very muscular with heavy boning. The Bombay is round all over. The head is round, the tips of the ears are round, the eyes, chin and even the feet are round.The coat of the Bombay is short and glossy. When the coat is in proper condition, its deep black luster looks like patent leather.The Bombay has a characteristic walk. Her body appears almost to sway when she walks. Again, this walk is reminiscent of the Indian black leopard.",
      image:
          "https://upload.wikimedia.org/wikipedia/commons/d/de/Gata_com%C3%BAn_negra.png",
      isFavourite: false,
      price: 6000,
      status: "pending",
      qty: null),
  ProductModel(
      id: "6",
      stock: 10,
      name: "Devon Rex",
      description:
          "The Devon Rex is an active, energetic breed. She is truly a little clown and will delight her parent by giving enchanting playful performances. For this, of course, the Devon expects to be thanked with pets and loving attention and will return affection with purring.",
      image:
          "https://encrypted-tbn3.gstatic.com/licensed-image?q=tbn:ANd9GcQ8Gj4LkF4PtgC0Y4Z6Li3Ke2gv3rl_klH3caMvZRqDkuMzDPW6Cl9kZffkTTZaWkbCzpCoCDZZKIwVfaw",
      isFavourite: false,
      price: 10000,
      status: "pending",
      qty: null),
  ProductModel(
      id: "7",
      name: "Manx Cat",
      stock: 19,
      description:
          "The Manx cat is a unique-looking, affectionate, friendly cat. Manx owners love their cat's stubby tail and high trainability. They are known to hunt rodents and insects with precision, but their hunting instincts don't translate to an aggressive temperament toward humans. These cats are excellent jumpers, which may make for some frustration, but remember that the Manx cat's playful nature is a gift. The Manx cat has a wonderful personality and makes a great addition to any family. ",
      image:
          "https://encrypted-tbn2.gstatic.com/licensed-image?q=tbn:ANd9GcRkPV9HrHy41iaj_nPiZHJDlyF8rjynIHPCXOM4zYN7l9akdDNf5r9Ci7tA1fjFE8G2PiKQoBSOuBCG6JE",
      isFavourite: false,
      price: 10000,
      status: "pending",
      qty: null),
  ProductModel(
      id: "8",
      name: "Toyger",
      stock: 10,
      description:
          "Toygers have a distinctly tiger-like appearance, marked by its broken, vertical orange and black or brown-bordered stripes. The International Cat Association describes the markings as dark markings on a vividly bright orange background on the outer to top portions of the cat with a whited ground color on the undersides and insides...enhanced by the scatter of gold glitter over the top.",
      image:
          "https://encrypted-tbn2.gstatic.com/licensed-image?q=tbn:ANd9GcS5k1pOG9bd59aQP8IdhGL0mMPGhVmsY3_rcXlmYF7FwBrjBAwv0SxlKrKMSbn83AggQvrl75eyQIyO1FQ",
      isFavourite: false,
      price: 15000,
      status: "pending",
      qty: null),
  ProductModel(
      id: "9",
      name: "Burmilla",
      stock: 10,
      description:
          "The Burmilla has an elegant appearance, soft fur, and an athletic, medium-sized body that's heavy and sturdy. This breed typically weighs between 6–13 pounds, with males tending to weigh more than females.",
      image:
          "https://www.dailypaws.com/thmb/UAGizX6e4aZCsIGuEK-uaXZauwI=/750x0/filters:no_upscale():max_bytes(150000):strip_icc():format(webp)/burmilla-crouched-facing-camera-955530172-2000-2c770116e0034d4ab1aa3db998fe4e9c.jpg",
      isFavourite: false,
      price: 15000,
      status: "pending",
      qty: null),
  ProductModel(
      id: "10",
      name: "Ocicat",
      stock: 10,
      description:
          "This medium to large breed has a well-muscled athletic build with a strong, dense bone structure. This makes them surprisingly heavy for their size, which combined with their low-slung stance and often ‘stalky’ walk, lends much to their ‘big cat’ appearance, even though this is a purely domestic cat with no wild ancestry at all! ",
      image:
          "https://www.purina.co.uk/sites/default/files/styles/square_medium_440x440/public/2022-06/Ocicat.jpg?itok=e9whf2OP",
      isFavourite: false,
      price: 3000,
      status: "pending",
      qty: null),
];
