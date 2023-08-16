import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AppointmentListPage extends StatefulWidget {
  const AppointmentListPage({super.key});

  @override
  _AppointmentListPageState createState() => _AppointmentListPageState();
}

class _AppointmentListPageState extends State<AppointmentListPage> {
  List<Map<String, dynamic>> itemList = [];

  Future<void> fetchDataFromFirestore() async {
    try {
      QuerySnapshot querySnapshot =
          await FirebaseFirestore.instance.collection('appoinments').get();

      if (querySnapshot.size > 0) {
        itemList.clear(); // Clear the list before adding new data

        // Loop through the query snapshot and add appointment names to the list
        for (QueryDocumentSnapshot documentSnapshot in querySnapshot.docs) {
          Map<String, dynamic> appointmentData = {
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
          itemList.add(appointmentData);
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
        title: const Text('Appointment List'),
      ),
      body: ListView.builder(
        itemCount: itemList.length,
        itemBuilder: (context, index) {
          Map<String, dynamic> appointmentData = itemList[index];
          String name = appointmentData['name'];
          String email = appointmentData['email'];
          String petname = appointmentData['petname'];
          String breed = appointmentData['breed'];
          String number = appointmentData['number'];
          String date = appointmentData['date'];
          String time = appointmentData['time'];
          String reason = appointmentData['reason'];
          String queries = appointmentData['queries'];

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
