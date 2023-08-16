import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class AddService extends StatefulWidget {
  const AddService({super.key});

  @override
  State<AddService> createState() => _AddServiceState();
}

class _AddServiceState extends State<AddService> {
  List<String> itemList = []; // List to store the fetched item names

  Future<void> fetchDataFromFirestore() async {
    try {
      // Assuming you have a collection named "items" in Firestore
      QuerySnapshot querySnapshot =
          await FirebaseFirestore.instance.collection('addservices').get();

      if (querySnapshot.size > 0) {
        // Clear the list before adding new data
        itemList.clear();

        // Loop through the query snapshot and add item names to the list
        for (QueryDocumentSnapshot documentSnapshot in querySnapshot.docs) {
          String itemName = documentSnapshot.get('servicetype');
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

  TextEditingController servicetype = TextEditingController();
  TextEditingController servicedetails = TextEditingController();

  Future<void> _saveDataToFirebase() async {
    var getservicetype = servicetype.text;
    var getservicedetails = servicedetails.text;

    // Access the Firestore instance
    FirebaseFirestore firestore = FirebaseFirestore.instance;

    // Create a reference to your collection (replace 'donations' with your desired collection name)
    CollectionReference serviceCollection = firestore.collection('addservices');

    // Add a new document with a generated ID
    serviceCollection.add({
      'service_type': getservicetype,
      'service_details': getservicedetails,
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
        title: const Text("AddServices"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 50,
            ),
            const SizedBox(
              height: 50,
            ),
            SizedBox(
              width: 300,
              child: TextField(
                controller: servicetype,
                decoration: InputDecoration(
                    labelText: "service_type",
                    hintText: "enter service_type",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                    )),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            SizedBox(
              width: 300,
              child: TextField(
                controller: servicedetails,
                decoration: InputDecoration(
                    labelText: "service_details",
                    hintText: "enter service_details",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                    )),
              ),
            ),
            const SizedBox(
              height: 20,
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
                  "Register Services",
                  style: TextStyle(fontSize: 20),
                )),
            const SizedBox(
              height: 50,
            ),
          ],
        ),
      ),
    );
  }
}
