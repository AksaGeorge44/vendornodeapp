import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class StaffViewPage extends StatefulWidget {
  const StaffViewPage({super.key});

  @override
  _StaffViewPageState createState() => _StaffViewPageState();
}

class _StaffViewPageState extends State<StaffViewPage> {
  List<Map<String, dynamic>> itemList = [];

  Future<void> fetchDataFromFirestore() async {
    try {
      QuerySnapshot querySnapshot =
          await FirebaseFirestore.instance.collection('addstaff').get();

      if (querySnapshot.size > 0) {
        itemList.clear(); // Clear the list before adding new data

        // Loop through the query snapshot and add appointment names to the list
        for (QueryDocumentSnapshot documentSnapshot in querySnapshot.docs) {
          Map<String, dynamic> staffData = {
            'name': documentSnapshot.get('name'),
            'email': documentSnapshot.get('email'),
            'mobile': documentSnapshot.get('mobile'),
            'department': documentSnapshot.get('department'),
            'date': documentSnapshot.get('date'),
            'salary': documentSnapshot.get('salary'),
            'address': documentSnapshot.get('address'),
            'password': documentSnapshot.get('password'),
            'proof': documentSnapshot.get('proof'),
          };
          itemList.add(staffData);
        }

        // Refresh the UI to display the fetched data
        setState(() {});
      }
    } catch (e) {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Staff List'),
      ),
      body: ListView.builder(
        itemCount: itemList.length,
        itemBuilder: (context, index) {
          Map<String, dynamic> staffData = itemList[index];
          String name = staffData['name'];
          String email = staffData['email'];
          String department = staffData['department'];
          String salary = staffData['salary'];
          String mobile = staffData['mobile'];
          String date = staffData['date'];
          String address = staffData['address'];
          String password = staffData['password'];
          String proof = staffData['proof'];

          return Padding(
            padding: const EdgeInsets.all(20),
            child: Card(
              child: ListTile(
                title: Text(name),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                      'Email: $email',
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(
                      'Department: $department',
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(
                      'Salary: $salary',
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(
                      'mobile: $mobile',
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(
                      'Date: $date',
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(
                      'Address: $address',
                      style: const TextStyle(
                    
                        fontWeight: FontWeight.bold),
                    ),
                    Text(
                      'Password: $password',
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(
                      'Proof: $proof',
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
