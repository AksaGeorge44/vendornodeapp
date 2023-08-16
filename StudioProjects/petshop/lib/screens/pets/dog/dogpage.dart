import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:petshop/cart/cartpage.dart';
import 'package:petshop/firebase_helper/prodctmodel.dart';
import 'package:petshop/cart/productdetails.dart';
import 'package:petshop/screens/homepage.dart';
import 'package:petshop/screens/pets/dog/dogadult.dart';
import 'package:petshop/screens/pets/dog/dogcarepage.dart';
import 'package:petshop/screens/pets/dog/dogpuppy.dart';
import 'package:petshop/model/provider.dart';
import 'package:petshop/model/routes.dart';
import 'package:provider/provider.dart';

class DogPage extends StatefulWidget {
  const DogPage({super.key});

  @override
  State<DogPage> createState() => _DogPageState();
}

class _DogPageState extends State<DogPage> {
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
        title: const Text("Dogs"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 10,
            ),
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
                                      builder: (context) => const HomePage()));
                            },
                            child: const Text("HOME")),
                          
                         TextButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const DogPuppyPage()));
                            },
                            child: const Text("PUPPY")),
                        TextButton(
                            onPressed: () {
                               Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const DogAdultPage()));


                            }, child: const Text("ADULT")),
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
                      "https://gomineofficial.com/cdn/shop/articles/different_dog_breeds_845x450.jpg?v=1549800021",
                      fit: BoxFit.fill,
                    ),

                    Image.network(
                      "https://www.khbuzz.com/wp-content/uploads/2017/06/Various-Dog-Breeds-Together.jpg",
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
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 199, 120, 212)),
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
                        const SizedBox(height: 10,),
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
      stock: 10,
      name: "Labrador",
      description:
          "Labradors are medium to large-sized dogs with a strong, athletic build. They have a well-balanced and sturdy frame, and their bodies are slightly longer than they are tall. Labradors have a broad head with a friendly expression, a moderately long muzzle, and kind, expressive eyes.",
      image:
          "https://www.seekpng.com/png/detail/1-13990_dog-png-animals-picture-with-name.png",
      isFavourite: false,
      price: 10000,
      status: "pending",
      qty: null),
  ProductModel(
      id: "2",
      stock: 10,
      name: "Retriever",
      description:
          "Golden Retrievers are medium to large-sized dogs. Males typically stand between 23 to 24 inches (58-61 cm) at the shoulder, while females are slightly smaller, ranging from 21.5 to 22.5 inches (55-57 cm)"
          "Weight: Adult Golden Retrievers usually weigh between 55 to 75 pounds (25-34 kg)"
          "Coat: They have a dense and water-resistant double coat with a thick undercoat and a longer, wavy or straight outer coat. The coat color is typically various shades of gold, ranging from cream to dark golden.",
      image:
          "https://e7.pngegg.com/pngimages/635/811/png-clipart-labrador-retriever-golden-retriever-newfoundland-dog-dog-breed-golden-retriever-animals-carnivoran-thumbnail.png",
      isFavourite: false,
      price: 12000,
      status: "pending",
      qty: null),
  ProductModel(
      id: "3",
      stock: 12,
      name: "Lab Puppy",
      description: "Affordable Lab puppies for sale",
      image:
          "https://cdn.imgbin.com/3/24/16/imgbin-puppy-labrador-retriever-golden-retriever-puppy-jDRXMGxvUMFhNvviic9Z6MaTG.jpg",
      isFavourite: false,
      price: 6000,
      status: "pending",
      qty: null),
  ProductModel(
      id: "4",
      name: "German",
      stock: 17,
      description:
          "German Shepherd Dog is a large, agile, muscular dog of noble character and high intelligence. Loyal, confident, courageous, and steady, the German Shepherd is truly a dog lover's delight.",
      image:
          "https://static.vecteezy.com/system/resources/previews/012/893/835/original/german-shepherd-dog-transparent-background-free-png.png",
      isFavourite: false,
      status: "pending",
      price: 12000,
      qty: null),
  ProductModel(
      id: "5",
      name: "Pug",
      stock: 20,
      description:
          " Pug is a breed of toy dog that has a short black muzzle and a tightly curled tail. It is a squarely built muscular dog with a large head, prominent dark eyes, and small drooping ears.",
      image:
          "https://e7.pngegg.com/pngimages/622/975/png-clipart-adult-fawn-pug-cute-pug-puppy-animals-pugs-thumbnail.png",
      isFavourite: false,
      price: 6500,
      status: "pending",
      qty: null),
  ProductModel(
      id: "6",
      stock: 20,
      name: "German",
      description:
          "German Shepherd Dog is a large, agile, muscular dog of noble character and high intelligence. Loyal, confident, courageous, and steady, the German Shepherd is truly a dog lover's delight.",
      image:
          "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTMsaSauftf0EeZo0VTgn-2K-9L26CaWXiUChHfyks6HBKXmble5zlBmYUJLjo3XzBxY8I&usqp=CAU",
      isFavourite: false,
      price: 10000,
      status: "pending",
      qty: null),
  ProductModel(
      id: "7",
      stock: 12,
      name: "Sniffer",
      description:
          "Sniffer dog is a dog that is trained to use its senses to detect substances such as explosives, illegal drugs, wildlife scat, currency, blood, and contraband electronics such as illicit mobile phones. The sense most used by detection dogs is smell.",
      image: "https://support.wwfindia.org/super_sniffer/photo/dog.png",
      isFavourite: false,
      price: 5500,
      status: "pending",
      qty: null),
  ProductModel(
      id: "8",
      stock: 20,
      name: "Lab Puppy",
      description: "2 year old lab puppies for sale",
      image:
          "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRP5_0Nr4o8DxHETGlQD9vLDOv68hi7Fi3ZdV41OM_a9wq7gxbWaNnx-Np_XLaH_a_zJVs&usqp=CAU",
      isFavourite: false,
      price: 6500,
      status: "pending",
      qty: null),
  ProductModel(
      id: "9",
      stock: 20,
      name: "Rottweiler Puppy",
      description: "Puppies for sale",
      image:
          "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSQj6P6KaVfiCBnY6yA5TMLyfkdUBPV3VtrPTUmtSE0s32CtJ8fzs0R1yotohIF6qj8SPA&usqp=CAU",
      isFavourite: false,
      price: 5000,
      status: "pending",
      qty: null),
  ProductModel(
      id: "10",
      stock: 10,
      name: "Rottweiler",
      description:
          "Rottweiler is a robust working breed of great strength descended from the mastiffs of the Roman legions. A gentle playmate and protector within the family circle, the Rottie observes the outside world with a self-assured aloofness.",
      image: "https://www.petindiaonline.com/story_images/23_pic23.jpg",
      isFavourite: false,
      price: 4500,
      status: "pending",
      qty: null),
];
