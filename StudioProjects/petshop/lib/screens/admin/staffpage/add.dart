
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class StaffAdd extends StatefulWidget {
  const StaffAdd({super.key});

  @override
  State<StaffAdd> createState() => _StaffAddState();
}

class _StaffAddState extends State<StaffAdd> {
   List<String> itemList = []; // List to store the fetched item names

  Future<void> fetchDataFromFirestore() async {
    try {
      // Assuming you have a collection named "items" in Firestore
      QuerySnapshot querySnapshot =
          await FirebaseFirestore.instance.collection('addstaff').get();

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
  TextEditingController email = TextEditingController();
  TextEditingController address = TextEditingController();
  TextEditingController mobile = TextEditingController();
  TextEditingController department = TextEditingController();
  TextEditingController salary = TextEditingController();
  TextEditingController images = TextEditingController();
  TextEditingController date = TextEditingController();
  TextEditingController proof = TextEditingController();
  TextEditingController password = TextEditingController();
  
  Future <void> _saveDataToFirebase() async{
    var getdate = date.text;
    var getsalary = salary.text;
    var getdepartment = department.text;
    var getname = name.text;
    var getemail = email.text;
    var getaddress = address.text;
    var getmobile = mobile.text;
    var getproof = proof.text;
    var getpassword = password.text;
    var getimages = images.text;

    
    // It seems like you're not using this field.

    // Access the Firestore instance
    FirebaseFirestore firestore = FirebaseFirestore.instance;

    // Create a reference to your collection (replace 'donations' with your desired collection name)
    CollectionReference staffCollection = firestore.collection('addstaff');

    // Add a new document with a generated ID
    staffCollection.add({
      'password': getpassword,
      'date': getdate,
      'salary': getsalary,
      'name': getname,
      'email': getemail,
      'address': getaddress,
      'mobile': getmobile,
      'proof': getproof,
      'department': getdepartment,
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

  Future<void> _selectDate() async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(DateTime.now().year + 1),
    );

    if (pickedDate != null && pickedDate != date.text) {
      setState(() {
        date.text = pickedDate.toString();
      });
    }
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
        
        title: const Text("AddStaff"),
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
                      labelText: "name",
                      hintText: "enter your name",
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
                  controller: mobile,
                  decoration: InputDecoration(
                      labelText: "mobile",
                      hintText: "enter mobile number",
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
                  controller: email,
                  decoration: InputDecoration(
                      hintText: "enter email_id",
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
                  controller: department,
                  decoration: InputDecoration(
                      labelText: "department",
                      hintText: "Pet Service/Clinic",
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
                  controller: date,
                  readOnly: true,
                  onTap: _selectDate,
                  decoration: InputDecoration(
                    hintText: "Select Joining Date",
                    labelText: "Date",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                width: 300,
                child: TextField(
                  controller: salary,
                  decoration: InputDecoration(
                      labelText: "salary",
                      hintText: "enter your salary",
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
                  controller: address,
                  decoration: InputDecoration(
                      hintText: "enter address",
                      labelText: "address",
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
                  controller: password,
                  obscureText: true,
                  decoration: InputDecoration(
                      hintText: "enter your password",
                      labelText: "password",
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
                        controller: proof,
                        decoration: InputDecoration(
                          hintText: "Proof[Aadhaar/VoterId]",
                          labelText: "proof",
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

    // Navigate to the AppointmentListPage to display the fetched data
    //Navigator.push(context,MaterialPageRoute(builder: (context) => AppointmentListPage()),);
  },


                  child: const Text(
                    "Register Staff",
                    style: TextStyle(fontSize: 20),
                  )),
                  const SizedBox(height: 50,),
             
            ],
          ),
        ),
      );
  }
}
