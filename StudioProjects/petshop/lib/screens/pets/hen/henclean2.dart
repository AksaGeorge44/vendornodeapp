import 'package:flutter/material.dart';
import 'package:petshop/screens/appbar/Notificationpage.dart';

class HenClean2 extends StatelessWidget {
  const HenClean2({super.key});

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
                "Feed the Chickens",
                style: TextStyle(fontSize: 20),
              ),
              Padding(
                padding: EdgeInsets.only(top: 20, right: 150),
                child: Text(
                  "You can free-feed your chickens with a large hanging feeder, adding the chicken feed as needed. Or you can feed them a set amount each day.",
                  
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
