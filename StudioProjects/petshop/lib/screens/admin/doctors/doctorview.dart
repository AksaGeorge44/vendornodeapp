import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class DoctorsViewPage extends StatefulWidget {
  const DoctorsViewPage({super.key});

  @override
  _DoctorsViewPageState createState() => _DoctorsViewPageState();
}

class _DoctorsViewPageState extends State<DoctorsViewPage> {
  List<Map<String, dynamic>> itemList = [];

  Future<void> fetchDataFromFirestore() async {
    try {
      QuerySnapshot querySnapshot =
          await FirebaseFirestore.instance.collection('adddoctor').get();

      if (querySnapshot.size > 0) {
        itemList.clear(); // Clear the list before adding new data

        // Loop through the query snapshot and add appointment names to the list
        for (QueryDocumentSnapshot documentSnapshot in querySnapshot.docs) {
          Map<String, dynamic> doctorData = {
            'name': documentSnapshot.get('name'),
            'email': documentSnapshot.get('email'),
            'mobile': documentSnapshot.get('mobile'),
            'date': documentSnapshot.get('date'),
            'salary': documentSnapshot.get('salary'),
            'password': documentSnapshot.get('password'),
            'proof': documentSnapshot.get('proof'),
          };
          itemList.add(doctorData);
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
        title: const Text('Doctor List'),
      ),
      body: ListView.builder(
        itemCount: itemList.length,
        itemBuilder: (context, index) {
          Map<String, dynamic> doctorData = itemList[index];
          String name = doctorData['name'];
          String email = doctorData['email'];
          String salary = doctorData['salary'];
          String mobile = doctorData['mobile'];
          String date = doctorData['date'];
          String password = doctorData['password'];
          String proof = doctorData['proof'];

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
