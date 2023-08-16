import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class BillingViewPage extends StatefulWidget {
  const BillingViewPage({super.key});

  @override
  _BillingViewPageState createState() => _BillingViewPageState();
}

class _BillingViewPageState extends State<BillingViewPage> {
  List<Map<String, dynamic>> itemList = [];

  Future<void> fetchDataFromFirestore() async {
    try {
      QuerySnapshot querySnapshot =
          await FirebaseFirestore.instance.collection('addbilling').get();

      if (querySnapshot.size > 0) {
        itemList.clear(); // Clear the list before adding new data

        // Loop through the query snapshot and add appointment names to the list
        for (QueryDocumentSnapshot documentSnapshot in querySnapshot.docs) {
          Map<String, dynamic> billingData = {
            'name': documentSnapshot.get('name'),
            'email': documentSnapshot.get('email'),
            'mobile': documentSnapshot.get('mobile'),
            'address': documentSnapshot.get('address'),
            'pincode': documentSnapshot.get('pincode'),
            'district':documentSnapshot.get('district'),
            'place': documentSnapshot.get('place'),
            'totalprice': documentSnapshot.get('totalprice'),
          };
          itemList.add(billingData);
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
        title: const Text('Billings'),
      ),
      body: ListView.builder(
        itemCount: itemList.length,
        itemBuilder: (context, index) {
          Map<String, dynamic> billingData = itemList[index];
          String name = billingData['name'];
          String email = billingData['email'];
          String place = billingData['place'];
          String mobile = billingData['mobile'];
          String address = billingData['address'];
          String pincode = billingData['pincode'];
                    String district = billingData['district'];

          String totalprice = billingData['totalprice'];

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
                      'place: $place',
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                   
                    Text(
                      'mobile: $mobile',
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                   
                    Text(
                      'Address: $address',
                      style: const TextStyle(
                    
                        fontWeight: FontWeight.bold),
                    ),
                    Text(
                      'pincode: $pincode',
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                      Text(
                      'district: $district',
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(
                      'totalprice: $totalprice',
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
