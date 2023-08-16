// ignore_for_file: use_key_in_widget_constructors

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UserListPage extends StatefulWidget {
  @override
  // ignore: library_private_types_in_public_api
  _UserListPageState createState() => _UserListPageState();
}

class _UserListPageState extends State<UserListPage> {
  List<String> userList = []; // List to store the fetched user names

  @override
  void initState() {
    super.initState();
    fetchDataFromFirestore(); // Call the function to fetch data from Firestore
  }

  Future<void> fetchDataFromFirestore() async {
    try {
      QuerySnapshot querySnapshot =
          await FirebaseFirestore.instance.collection('users').get();

      if (querySnapshot.size > 0) {
        userList.clear(); // Clear the list before adding new data

        // Loop through the query snapshot and add user names to the list
        for (QueryDocumentSnapshot documentSnapshot in querySnapshot.docs) {
          String userName = documentSnapshot.get('name');
          userList.add(userName);
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
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('User List'),
      ),
      body: ListView.builder(
        itemCount: userList.length,
        itemBuilder: (context, index) {
          String userName = userList[index];
          return ListTile(
            title: Text(userName),
          );
        },
      ),
    );
  }
}
