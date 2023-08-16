import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:petshop/screens/appbar/Notificationpage.dart';

class ClinicPage extends StatefulWidget {
  const ClinicPage({super.key});

  @override
  State<ClinicPage> createState() => _ClinicPageState();
}

class _ClinicPageState extends State<ClinicPage> {
  final picker = ImagePicker();
  late Future<PickedFile?> pickedFile = Future.value(null);
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController petname = TextEditingController();
  TextEditingController breed = TextEditingController();
  TextEditingController number = TextEditingController();
  TextEditingController service = TextEditingController();
  TextEditingController queries = TextEditingController();
  String selectedService = ''; // Define the selected service here

  TextEditingController dateController = TextEditingController();
  TextEditingController timeController = TextEditingController();
  List<String> itemList = []; // List to store the fetched item names

  List<String> petGroomingServices = [
    'Bath and Haircut',
    'Nail Trim',
    'Ear Cleaning',
    'Teeth Brushing',
    // Add more services as needed
  ];

  Future<void> fetchDataFromFirestore() async {
    try {
      // Assuming you have a collection named "items" in Firestore
      QuerySnapshot querySnapshot =
          await FirebaseFirestore.instance.collection('services').get();

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
      // Get the current user's ID from Firebase Authentication
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

            // Check if the user's phone number is available in Firestore
            if (userSnapshot.get('phone_number') != null) {
              number.text = userSnapshot.get('phone_number');
            }
          });
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error fetching user data: $e');
      }
    }
  }

  Future<void> _selectDate() async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(DateTime.now().year + 1),
      selectableDayPredicate: (DateTime day) {
        // Make Sundays unavailable
        return day.weekday != DateTime.sunday;
      },
    );

    if (pickedDate != null && pickedDate != dateController.text) {
      setState(() {
        dateController.text = pickedDate.toString();

        // Clear the selected time if it's outside of the working hours
        timeController.clear();
      });
    }
  }

  Future<void> _selectTime() async {
    final TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: const TimeOfDay(hour: 9, minute: 0), // Start at 9:00 AM
      builder: (BuildContext context, Widget? child) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: false),
          child: child!,
        );
      },
      initialEntryMode: TimePickerEntryMode.input,
    );

    if (pickedTime != null) {
      if (pickedTime.hour < 9 || pickedTime.hour >= 18) {
        // Outside of working hours (9 AM to 6 PM)
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text("Please select a time between 9 AM and 6 PM."),
          duration: Duration(seconds: 5),
        ));
      } else {
        setState(() {
          timeController.text = pickedTime.format(context);
        });
      }
    }
  } 
  @override
  void initState() {
    super.initState();
    fetchDataFromFirestore();
    fetchUserDataFromFirestore();
  }

  Future<void> _saveDataToFirebase() async {
    var getname = name.text;
    var getemail = email.text;
    var getpetname = petname.text;
    var getbreed = breed.text;
    var getnumber = number.text;
    var getservice = service.text;
    var getdate = dateController.text;
    var gettime = timeController.text;
    var getqueries = queries.text;

    // Validate that all fields are entered and not empty
    if (getname.isEmpty ||
        getemail.isEmpty ||
        getnumber.isEmpty ||
        getdate.isEmpty ||
        getqueries.isEmpty ||
        gettime.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("Please fill in all fields."),
        duration: Duration(seconds: 3),
      ));
      return;
    }

    // Validate the phone number format and length
    if (!isPhoneNumberValid(getnumber)) {
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
    if (!isString(getname) ||
        !isString(getpetname) ||
        !isString(getbreed) ||
        !isString(getservice)) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("Please enter valid text"),
        duration: Duration(seconds: 3),
      ));
      return;
    }

    // Access the Firestore instance
    FirebaseFirestore firestore = FirebaseFirestore.instance;

    // Create a reference to your collection (replace 'donations' with your desired collection name)
    CollectionReference groomingCollection = firestore.collection('services');

    // Add a new document with a generated ID
    groomingCollection.add({
      'name': getname,
      'email': getemail,
      'petname': getpetname,
      'breed': getbreed,
      'number': getnumber,
      'service': getservice,
      'queries': getqueries,
      'date': getdate,
      'time': gettime,
    }).then((value) {
      // Success, data is saved to Firestore
      if (kDebugMode) {
        print("Data saved to Firebase!");
      }
      // Show success message after successful form submission
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("Form submitted successfully!"),
        duration: Duration(seconds: 3),
      ));
      Future.delayed(const Duration(seconds: 2), () {
        Navigator.pop(context); // Navigate back after 3 seconds
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
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey, // Step 2: Assign the GlobalKey to the Scaffold

      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              _launchCall(
                  '9922343456'); // Replace 'PHONE_NUMBER' with the actual phone number
            },
            icon: const Icon(Icons.call),
          ),
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
        title: const Text("Clinic"),
      ),
      body: SingleChildScrollView(
        child: Builder(builder: (context) {
          return Column(
            children: [
             
             const SizedBox(
                height: 30,
              ),
              const Center(
                child: Text(
                  "Book an Appointment",
                  style: TextStyle(
                      fontSize: 25,
                      color: Colors.black,
                      fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(
                height: 25,
              ),
              const Center(
                child: Text(
                  "We provide better services",
                  style: TextStyle(
                      fontSize: 18,
                      color: Color.fromARGB(255, 87, 170, 211),
                      fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              SizedBox(
                height: 150,
                child: Image.network(
                    "https://riverwoodveterinaryclinic.com/wp-content/uploads/2021/04/riverwood-veterinary-clinic-Wellness-Preventative-Care.png"),
              ),
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
                  controller: petname,
                  decoration: const InputDecoration(
                    hintText: "enter pet name",
                    labelText: "pet name",
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                width: 300,
                child: TextFormField(
                  controller: breed,
                  decoration: const InputDecoration(
                    labelText: "breed",
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
                  controller: number,
                  decoration: const InputDecoration(
                    labelText: "number",
                    hintText: "enter your phone_number",
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                width: 300,
                child: TextFormField(
                  controller: dateController,
                  readOnly: true,
                  onTap: _selectDate,
                  decoration: const InputDecoration(
                    hintText: "Select Date",
                    labelText: "date",
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                width: 300,
                child: TextFormField(
                  controller: timeController,
                  readOnly: true,
                  onTap: _selectTime,
                  decoration: const InputDecoration(
                    hintText: "Select Time",
                    labelText: "time",
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
//               SizedBox(
//   width: 300,
//   child: DropdownButtonFormField<String>(
//     value: selectedService,
//     onChanged: (newValue) {
//       setState(() {
//         selectedService = newValue!;
//       });
//     },
//     items: petGroomingServices.map((service) {
//       return DropdownMenuItem<String>(
//         value: service,
//         child: Text(service),
//       );
//     }).toList(),
//     decoration: const InputDecoration(
//       labelText: "Select Service",
//     ),
//   ),
// ),

              SizedBox(
                width: 300,
                child: TextFormField(
                  controller: service,
                  decoration: const InputDecoration(
                    hintText: "Vaccination,Surgery,Dental,etc....",
                    labelText: "reason",
                  ),
                ),
              ),

              const SizedBox(
                height: 20,
              ),
              SizedBox(
                width: 300,
                child: TextFormField(
                  controller: queries,
                  decoration: const InputDecoration(
                    hintText: "your queries",
                    labelText: "queries",
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
