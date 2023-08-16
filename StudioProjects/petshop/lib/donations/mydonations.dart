import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:petshop/donations/donationdog.dart';

class DonationListPage extends StatefulWidget {
  const DonationListPage({super.key});

  @override
  _DonationListPageState createState() => _DonationListPageState();
}

class _DonationListPageState extends State<DonationListPage> {
  List<Map<String, dynamic>> itemList = [];

  Future<void> fetchDataFromFirestore() async {
    try {
      QuerySnapshot querySnapshot =
          await FirebaseFirestore.instance.collection('donations').get();

      if (querySnapshot.size > 0) {
        itemList.clear(); // Clear the list before adding new data

        // Loop through the query snapshot and add appointment names to the list
        for (QueryDocumentSnapshot documentSnapshot in querySnapshot.docs) {
          Map<String, dynamic> donationData = {
            'name': documentSnapshot.get('name'),
            'email': documentSnapshot.get('email'),
            'address': documentSnapshot.get('address'),
            'mobile': documentSnapshot.get('mobile'),
            'city': documentSnapshot.get('city'),
            'instructions': documentSnapshot.get('instructions'),
            'images': documentSnapshot.get('images'),
            'age': documentSnapshot.get('age'),
            'issues': documentSnapshot.get('issues'),
          };
          itemList.add(donationData);
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
        actions: [
            GestureDetector(
              
              onTap: (){
                Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const DonationPage()));

              },
              child: const Icon(Icons.arrow_back))
          ],
        title: const Text('Donation List'),
      ),
      body: ListView.builder(
        itemCount: itemList.length,
        itemBuilder: (context, index) {
          Map<String, dynamic> donationData = itemList[index];
          String name = donationData['name'];
          String email = donationData['email'];
          String address = donationData['address'];
          String mobile = donationData['mobile'];
          String city = donationData['city'];
          String instructions = donationData['instructions'];
          String images = donationData['images'];
          String breed = donationData['breed'];
          String age = donationData['age'];
          String issues = donationData['issues'];

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
                      'Address: $address',
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(
                      'mobile: $mobile',
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(
                      'city: $city',
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(
                      'instructions: $instructions',
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(
                      'images: $images',
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(
                      'breed: $breed',
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(
                      'age: $age',
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(
                      'issues: $issues',
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
