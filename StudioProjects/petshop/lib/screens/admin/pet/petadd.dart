
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class PetAdd extends StatefulWidget {
  const PetAdd({super.key});

  @override
  State<PetAdd> createState() => _PetAddState();
}

class _PetAddState extends State<PetAdd> {
   List<String> itemList = []; // List to store the fetched item names

  Future<void> fetchDataFromFirestore() async {
    try {
      // Assuming you have a collection named "items" in Firestore
      QuerySnapshot querySnapshot =
          await FirebaseFirestore.instance.collection('addpets').get();

      if (querySnapshot.size > 0) {
        // Clear the list before adding new data
        itemList.clear();

        // Loop through the query snapshot and add item names to the list
        for (QueryDocumentSnapshot documentSnapshot in querySnapshot.docs) {
          String itemName = documentSnapshot.get('name');
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
  final picker = ImagePicker();
  late Future<PickedFile?> pickedFile = Future.value(null);

  TextEditingController name = TextEditingController();
  TextEditingController petimage = TextEditingController();
  
  Future <void> _saveDataToFirebase() async{
    var getname = name.text;
    var getpetimage = petimage.text;

    
    // It seems like you're not using this field.

    // Access the Firestore instance
    FirebaseFirestore firestore = FirebaseFirestore.instance;

    // Create a reference to your collection (replace 'donations' with your desired collection name)
    CollectionReference petCollection = firestore.collection('addpets');

    // Add a new document with a generated ID
    petCollection.add({
      'name': getname,
      'petimage': getpetimage,
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

  

  Future<void> _openImagePicker(ImageSource source) async {
    PickedFile? pickedImage = await picker.getImage(source: source);
    if (pickedImage != null) {
      setState(() {
        pickedFile = Future.value(pickedImage);
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        
        title: const Text("AddPet"),
      ),
      body: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(
                height: 50,
              ),
              const Center(
                child: Text(
                  "BASIC FORM",
                  style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(
                height: 50,
              ),
              SizedBox(
                width: 300,
                child: TextField(
                  controller: name,
                  decoration: InputDecoration(
                      hintText: "choose category",
                      labelText: "Category",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                      )),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              SafeArea(
                child: Column(
                  children: [
                    SizedBox(
                      width: 300,
                      child: TextField(
                        controller: petimage,
                        decoration: InputDecoration(
                          hintText: "PetImage",
                          labelText: "petImage",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          suffixIcon: IconButton(
                            onPressed: () {
                              // Open the image picker when the button is pressed
                              showModalBottomSheet(
                                context: context,
                                builder: (BuildContext context) {
                                  return SafeArea(
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        ListTile(
                                          leading: const Icon(Icons.camera),
                                          title: const Text("Camera"),
                                          onTap: () {
                                            Navigator.pop(context);
                                            _openImagePicker(
                                                ImageSource.camera);
                                          },
                                        ),
                                        ListTile(
                                          leading: const Icon(Icons.photo),
                                          title: const Text("Gallery"),
                                          onTap: () {
                                            Navigator.pop(context);
                                            _openImagePicker(
                                                ImageSource.gallery);
                                          },
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              );
                            },
                            icon: const Icon(Icons.attach_file),
                          ),
                        ),
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    // Display selected image
                    FutureBuilder<PickedFile?>(
                      future: pickedFile,
                      builder: (context, snap) {
                        if (snap.hasData && snap.data != null) {
                          return Container(height: 150,width: 150,
                            color: const Color.fromARGB(97, 228, 163, 163),
                            child: Image.file(
                              File(snap.data!.path),
                             fit: BoxFit.contain,
                            ),
                          );
                        }
                        return Container(
                          height: 20,
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

    // Fetch updated data from Firestore
    await fetchDataFromFirestore();

  },


                  child: const Text(
                    "Register Pet",
                    style: TextStyle(fontSize: 20),
                  )),
                  const SizedBox(height: 50,),
             
            ],
          ),
        ),
      );
  }
}
