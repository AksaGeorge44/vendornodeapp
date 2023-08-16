import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class GroomingListPage extends StatefulWidget {
  const GroomingListPage({super.key});

  @override
  _GroomingListPageState createState() => _GroomingListPageState();
}

class _GroomingListPageState extends State<GroomingListPage> {
  List<Map<String, dynamic>> itemList = [];

  Future<void> fetchDataFromFirestore() async {
    try {
      QuerySnapshot querySnapshot =
          await FirebaseFirestore.instance.collection('services').get();

      if (querySnapshot.size > 0) {
        itemList.clear(); // Clear the list before adding new data

        // Loop through the query snapshot and add appointment names to the list
        for (QueryDocumentSnapshot documentSnapshot in querySnapshot.docs) {
          Map<String, dynamic> groomingData = {
            'name': documentSnapshot.get('name'),
            'email': documentSnapshot.get('email'),
            'petname': documentSnapshot.get('petname'),
            'breed': documentSnapshot.get('breed'),
            'number': documentSnapshot.get('number'),
            'date': documentSnapshot.get('date'),
            'time': documentSnapshot.get('time'),
            'reason': documentSnapshot.get('reason'),
            'queries': documentSnapshot.get('queries'),
          };
          itemList.add(groomingData);
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
        title: const Text('Grooming List'),
      ),
      body: ListView.builder(
        itemCount: itemList.length,
        itemBuilder: (context, index) {
          Map<String, dynamic> groomingData = itemList[index];
          String name = groomingData['name'];
          String email = groomingData['email'];
          String petname = groomingData['petname'];
          String breed = groomingData['breed'];
          String number = groomingData['number'];
          String date = groomingData['date'];
          String time = groomingData['time'];
          String reason = groomingData['reason'];
          String queries = groomingData['queries'];

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
                      'Pet Name: $petname',
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(
                      'Breed: $breed',
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(
                      'Number: $number',
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(
                      'Date: $date',
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(
                      'Time: $time',
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(
                      'Reason: $reason',
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(
                      'Queries: $queries',
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
