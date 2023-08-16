import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:petshop/screens/appbar/queries.dart';

class DonationPage extends StatefulWidget {
  const DonationPage({super.key});

  @override
  State<DonationPage> createState() => _DonationPageState();
}

class _DonationPageState extends State<DonationPage> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  final picker = ImagePicker();
  late Future<PickedFile?> pickedFile = Future.value(null);

  TextEditingController breed = TextEditingController();
  TextEditingController age = TextEditingController();
  TextEditingController issues = TextEditingController();
  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController address = TextEditingController();
  TextEditingController mobile = TextEditingController();
  TextEditingController city = TextEditingController();
  TextEditingController instructions = TextEditingController();
  TextEditingController images = TextEditingController();

  List<String> itemList = []; // List to store the fetched item names

  Future<void> fetchDataFromFirestore() async {
    try {
      // Assuming you have a collection named "items" in Firestore
      QuerySnapshot querySnapshot =
          await FirebaseFirestore.instance.collection('donations').get();

      if (querySnapshot.size > 0) {
        // Clear the list before adding new data
        itemList.clear();

        // Loop through the query snapshot and add item names to the list
        for (QueryDocumentSnapshot documentSnapshot in querySnapshot.docs) {
          String itemName = documentSnapshot.get('breed');
          itemList.add(itemName);
        }

        // Refresh the UI to display the fetched data
        setState(() {});
      }
    } catch (e) {
      // Handle any errors that might occur during fetching
      if (kDebugMode) {
        print('Error fetching data: $e');
      }
    }
  }

  @override
  void initState() {
    super.initState();
    fetchDataFromFirestore();
  }

  Future<void> _saveDataToFirebase() async {
    var getbreed = breed.text;
    var getage = age.text;
    var getissues = issues.text;
    var getname = name.text;
    var getemail = email.text;
    var getaddress = address.text;
    var getmobile = mobile.text;
    var getcity = city.text;
    var getinstructions = instructions.text;
    var getimages = images.text; // It seems like you're not using this field.

    // Access the Firestore instance
    FirebaseFirestore firestore = FirebaseFirestore.instance;

    // Create a reference to your collection (replace 'donations' with your desired collection name)
    CollectionReference donationCollection = firestore.collection('donations');

    // Add a new document with a generated ID
    donationCollection.add({
      'breed': getbreed,
      'age': getage,
      'issues': getissues,
      'name': getname,
      'email': getemail,
      'address': getaddress,
      'mobile': getmobile,
      'city': getcity,
      'instructions': getinstructions,
      'images': getimages, // You can add this field if needed.
    }).then((value) {
      // Success, data is saved to Firestore
      if (kDebugMode) {
        print("Data saved to Firebase!");
      }

      // Here you can show a success message or navigate to another page if needed.
    }).catchError((error) {
      // Error occurred while saving data
      if (kDebugMode) {
        print("Error saving data: $error");
      }
      // Here you can show an error message or handle the error as needed.
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions:  [
          Padding(
            padding: const EdgeInsets.all(20),
            child: GestureDetector(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>const QueriesPage()));
              },
              child: const Icon(Icons.message_rounded)),
          )
        ],
        title: const Text("DonationPage"),
      ),
      key: _scaffoldKey, // Step 2: Assign the GlobalKey to the Scaffold
      body: SingleChildScrollView(child: Builder(builder: (context) {
        return Column(
          children: [
            const SizedBox(
              height: 40,
            ),
            const Center(
              child: Text(
                "DONATION FORM",
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            const Center(
                child: Text(
              "DOG DETAILS",
              style: TextStyle(
                  fontSize: 20,
                  color: Colors.blueAccent,
                  fontWeight: FontWeight.bold),
            )),
            const SizedBox(
              height: 20,
            ),
            SizedBox(
              width: 300,
              child: TextFormField(
                controller: breed,
                decoration: const InputDecoration(
                    labelText: "breed name",
                    hintText: "enter breed name",
                   
                    
                    ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            SizedBox(
              width: 300,
              child: TextFormField(
                controller: age,
                decoration: const InputDecoration(
                    labelText: "age",
                    hintText: "enter breed age",
                   
                    
                    ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            SizedBox(
              width: 300,
              child: TextFormField(
                controller: issues,
                decoration: const InputDecoration(
                    hintText: "Any physical issues",
                   
                    
                    ),
              ),
            ),
            const SizedBox(
              height: 50,
            ),
            const Center(
                child: Text(
              "CUSTOMER DETAILS",
              style: TextStyle(
                  fontSize: 20,
                  color: Colors.blueAccent,
                  fontWeight: FontWeight.bold),
            )),
            const SizedBox(
              height: 20,
            ),
            SizedBox(
              width: 300,
              child: TextFormField(
                controller: name,
                decoration: const InputDecoration(
                    labelText: "name",
                    hintText: "enter your name",
                   
                    
                    ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            SizedBox(
              width: 300,
              child: TextFormField(
                controller: email,
                decoration: const InputDecoration(
                    labelText: "email",
                    hintText: "enter your email",
                   
                    
                    ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            SizedBox(
              width: 300,
              child: TextFormField(
                controller: address,
                decoration: const InputDecoration(
                    hintText: "enter address",
                    labelText: "address",
                   
                    
                    ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            SizedBox(
              width: 300,
              child: TextFormField(
                controller: mobile,
                decoration: const InputDecoration(
                    hintText: "enter phone_number",
                    labelText: "phone_number",
                    
                    
                    ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            SizedBox(
              width: 300,
              child: TextFormField(
                controller: city,
                decoration: const InputDecoration(
                    hintText: "enter your city",
                    labelText: "city",
                    
                    
                    ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            SizedBox(
              width: 300,
              child: TextFormField(
                controller: instructions,
                decoration: const InputDecoration(
                    hintText: "enter any instructions",
                    labelText: "instructions",
                   
                    
                    ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            SafeArea(
                child: Column(
              children: [
                const Text(
                  "Choose Dog's Image",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                SafeArea(
                  child: Column(
                    children: [
                      const Row(
                        children: [
                          Padding(
                            padding: EdgeInsets.only(
                              top: 15,
                              left: 25,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          IconButton(
                              onPressed: () async {
                                pickedFile = picker
                                    .getImage(source: ImageSource.camera)
                                    .whenComplete(() => setState(() {}));
                              },
                              icon: const Icon(Icons.add)),
                          const SizedBox(
                            width: 100,
                          ),
                          IconButton(
                            onPressed: () async {
                              pickedFile = picker
                                  .getImage(
                                    source: ImageSource.gallery,
                                  )
                                  .whenComplete(() => setState(() {}));
                            },
                            icon: const Icon(Icons.photo_camera_back),
                          ),
                        ],
                      ),
                      FutureBuilder<PickedFile?>(
                        future: pickedFile,
                        builder: (context, snap) {
                          if (snap.hasData) {
                            return Container(
                              width: 100,
                              height: 100,
                              color: const Color.fromARGB(97, 228, 163, 163),
                              child: Image.file(
                                File(snap.data!.path),
                                fit: BoxFit.contain,
                              ),
                            );
                          }
                          return Container(
                            height: 150.0,
                            color: Colors.white,
                          );
                        },
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                    onPressed: () async {
                      // Save data to Firebase
                      await _saveDataToFirebase();
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text("Form submitted successfully!"),
                        duration: Duration(
                            seconds: 3), // Increase the duration to 5 seconds
                      ));

                      // Fetch updated data from Firestore
                      await fetchDataFromFirestore();
                    },
                    child: const Text(
                      "Submit",
                      style: TextStyle(fontSize: 20),
                    )),
              ],
            ))
          ],
        );
      })),
    );
  }
}
