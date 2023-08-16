import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class ServiceView extends StatefulWidget {
  const ServiceView({super.key});

  @override
  _ServiceViewState createState() => _ServiceViewState();
}

class _ServiceViewState extends State<ServiceView> {
  List<Map<String, dynamic>> itemList = [];

  Future<void> fetchDataFromFirestore() async {
    try {
      QuerySnapshot querySnapshot =
          await FirebaseFirestore.instance.collection('addservices').get();

      if (querySnapshot.size > 0) {
        itemList.clear(); // Clear the list before adding new data

        // Loop through the query snapshot and add appointment servicetypes to the list
        for (QueryDocumentSnapshot documentSnapshot in querySnapshot.docs) {
          Map<String, dynamic> serviceData = {
            'servicetype': documentSnapshot.get('servicetype'),
            'servicedetails': documentSnapshot.get('servicedetails'),
          };
          itemList.add(serviceData);
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
        title: const Text('Service List'),
      ),
      body: ListView.builder(
        itemCount: itemList.length,
        itemBuilder: (context, index) {
          Map<String, dynamic> serviceData = itemList[index];
          String servicetype = serviceData['servicetype'];
          String servicedetails = serviceData['servicedetails'];

          return Padding(
            padding: const EdgeInsets.all(20),
            child: Card(
              child: ListTile(
                title: Text(servicetype),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                      'servicedetails: $servicedetails',
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
