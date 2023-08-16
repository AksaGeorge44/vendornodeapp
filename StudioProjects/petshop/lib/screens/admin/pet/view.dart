import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class PetView extends StatefulWidget {
  const PetView({super.key});

  @override
  _PetViewState createState() => _PetViewState();
}

class _PetViewState extends State<PetView> {
  

  List<Map<String, dynamic>> itemList = [];

  Future<void> fetchDataFromFirestore() async {
    try {
      QuerySnapshot querySnapshot =
          await FirebaseFirestore.instance.collection('addpets').get();

      if (querySnapshot.size > 0) {
        itemList.clear(); // Clear the list before adding new data

        // Loop through the query snapshot and add appointment names to the list
        for (QueryDocumentSnapshot documentSnapshot in querySnapshot.docs) {
          Map<String, dynamic> petData = {
            'name': documentSnapshot.get('name'),
            'petimage': documentSnapshot.get('petimage'),
          };
          itemList.add(petData);
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
        title:  const Text('Pet List'),
      ),
      body: ListView.builder(
        itemCount: itemList.length,
        itemBuilder: (context, index) {
          Map<String, dynamic> petData = itemList[index];
          String name = petData['name'];
          String petimage = petData['petimage'];

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
                      'Petimage: $petimage',
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
