import 'package:flutter/material.dart';
import 'package:petshop/screens/appbar/Notificationpage.dart';

class HenClean extends StatelessWidget {
  const HenClean({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          Padding(
            padding: const EdgeInsets.all(17),
            child: GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const NotificationPage()));
                },
                child: const Icon(Icons.notification_add_outlined)),
          ),
        ],
        title: const Text("General Care"),
      ),
      body: Container(
        margin: const EdgeInsets.all(10),
        child: const SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 15,
              ),
              Text(
                "Refresh the water: ",
                style: TextStyle(fontSize: 20),
              ),
              Padding(
                padding: EdgeInsets.only(top: 20, right: 150),
                child: Text(
                  "Chickens need to drink about a pint of fresh water per chicken each day. Because they don't like dirty water, they can become dehydrated quickly. Shavings, straw, and poop can get in the water throughout the day. Consuming feces from other chickens may lead to worms. Refresh the water daily, especially if you notice any debris or sliminess in the container.",
                ),
              ),
              SizedBox(
                height: 6,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
