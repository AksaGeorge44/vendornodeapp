import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:petshop/screens/homepage.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:petshop/screens/appbar/Notificationpage.dart';

class BillingPage extends StatefulWidget {
    final String paymentMethod;

  final double totalprice;

  const BillingPage({
    super.key,
    required this.totalprice, required this.paymentMethod,
  });

  @override
  State<BillingPage> createState() => _BillingPageState();
}

class _BillingPageState extends State<BillingPage> {
  final picker = ImagePicker();
  late Future<PickedFile?> pickedFile = Future.value(null);
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController mobile = TextEditingController();
  TextEditingController address = TextEditingController();
  TextEditingController pincode = TextEditingController();
  TextEditingController district = TextEditingController();
  TextEditingController place = TextEditingController();
  TextEditingController totalprice = TextEditingController();
  List<String> itemList = []; // List to store the fetched item names

  Future<void> fetchDataFromFirestore() async {
    try {
      // Assuming you have a collection named "items" in Firestore
      QuerySnapshot querySnapshot =
          await FirebaseFirestore.instance.collection('addbilling').get();

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

  Future<void> fetchUserDataFromFirestore() async {
    try {
      final User? user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        String userId = user.uid;

        // Fetch the user's data from Firestore
        DocumentSnapshot userSnapshot = await FirebaseFirestore.instance
            .collection('users') // Change this to your users collection
            .doc(userId)
            .get();
        if (userSnapshot.exists) {
          setState(() {
            name.text = userSnapshot.get('name');
            email.text = userSnapshot.get('email');
          });
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error fetching user data: $e');
      }
    }
  }

  //  void initState() {
  //   super.initState();
  //       print("Received total price in BillingPage: ${widget.totalprice}");

  //   totalprice.text = widget.totalprice.toStringAsFixed(2);
  //   fetchDataFromFirestore();
  //   fetchUserDataFromFirestore();
  // }

  Future<void> _saveDataToFirebase() async {
    var getname = name.text;
    var getemail = email.text;
    var getmobile = mobile.text;
    var getaddress = address.text;
    var getpincode = pincode.text;
    var getdistrict = district.text;
    var getplace = place.text;
    var gettotalprice = totalprice.text;

    // Validate that all fields are entered and not empty
    if (getname.isEmpty ||
        getemail.isEmpty ||
        getmobile.isEmpty ||
        getaddress.isEmpty ||
        getpincode.isEmpty ||
        getdistrict.isEmpty ||
        
        getplace.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("Please fill in all fields."),
        duration: Duration(seconds: 3),
      ));
      return;
    }

    // Validate the phone number format and length
    if (!isPhoneNumberValid(getmobile)) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("Please enter a valid 10-digit phone number."),
        duration: Duration(seconds: 3),
      ));
      return;
    }

    // Validate the email format
    if (!isEmailValid(getemail)) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("Please enter a valid email address."),
        duration: Duration(seconds: 3),
      ));
      return;
    }

    // Validate that name, petname, breed, and service are all strings
    if (!isString(getname) || !isString(getaddress) || !isString(getplace)) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("Please enter valid text"),
        duration: Duration(seconds: 3),
      ));
      return;
    }

    // Access the Firestore instance
    FirebaseFirestore firestore = FirebaseFirestore.instance;

    // Create a reference to your collection (replace 'donations' with your desired collection name)
    CollectionReference groomingCollection = firestore.collection('addbilling');

    // Add a new document with a generated ID
    groomingCollection.add({
      'name': getname,
      'email': getemail,
      'mobile': getmobile,
      'address': getaddress,
      'pincode': getpincode,
      'district': getdistrict,
      'place': getplace,
      'totalprice': gettotalprice,
    }).then((value) {
      // Success, data is saved to Firestore
      if (kDebugMode) {
        print("Data saved to Firebase!");
      }
      // Show success message after successful form submission
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("Ordered successfully!"),
        duration: Duration(seconds: 2),
      ));
      Future.delayed(const Duration(seconds: 2), () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const HomePage(), // Pass itemList
          ),
        );

        //  Navigator.push(context, MaterialPageRoute(builder: (context)=>const HomePage()));// Navigate back after 3 seconds
      });
    }).catchError((error) {
      // Error occurred while saving data
      if (kDebugMode) {
        print("Error saving data: $error");
      }
      // Here you can show an error message or handle the error as needed.
    });
  }

  bool isPhoneNumberValid(String value) {
    return RegExp(r'^\d{10}$').hasMatch(value);
  }

  bool isEmailValid(String value) {
    return RegExp(r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$')
        .hasMatch(value);
  }

  bool isString(String value) {
    return value.isNotEmpty && !RegExp(r'^\d+$').hasMatch(value);
  }

  Future<void> _launchCall(String phoneNumber) async {
    final phoneUrl = 'tel:$phoneNumber';
    if (await canLaunch(phoneUrl)) {
      await launch(phoneUrl);
    } else {
      throw 'Could not launch $phoneUrl';
    }
  }

  @override
  void initState() {
    super.initState();
    fetchUserDataFromFirestore();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey, // Step 2: Assign the GlobalKey to the Scaffold

      appBar: AppBar(
        actions: [
          GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const NotificationPage()));
            },
            child: const Padding(
              padding: EdgeInsets.all(15),
              child: Icon(Icons.notification_add),
            ),
          )
        ],
        title: const Text("Bills"),
      ),
      body: SingleChildScrollView(
        child: Builder(builder: (context) {
          return Column(
            children: [
              const SizedBox(
                height: 70,
              ),
              const Center(
                child: Text(
                  "Billing",
                  style: TextStyle(
                      fontSize: 23,
                      color: Colors.black,
                      fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(
                height: 25,
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
const SizedBox(height: 20),
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
                  controller: address,
                  decoration: const InputDecoration(
                    labelText: "address",
                    hintText: "enter your address",
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                width: 300,
                child: TextFormField(
                  controller: pincode,
                  decoration: const InputDecoration(
                    labelText: "pincode",
                    hintText: "enter your pincode",
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                width: 300,
                child: TextFormField(
                  controller: district,
                  decoration: const InputDecoration(
                    hintText: "enter your district",
                    labelText: "district",
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                width: 300,
                child: TextFormField(
                  controller: place,
                  decoration: const InputDecoration(
                    hintText: "enter your place",
                    labelText: "place",
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                width: 300,
                child: TextFormField(
                  initialValue: widget.totalprice
                      .toString(), // Display the passed total price
                  enabled: false, // Disable editing
                  decoration: const InputDecoration(
                    hintText: "totalprice",
                    labelText: "price",
                  ),
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
                    "Submit",
                    style: TextStyle(fontSize: 20),
                  )),
            ],
          );
        }),
      ),
    );
  }
}
