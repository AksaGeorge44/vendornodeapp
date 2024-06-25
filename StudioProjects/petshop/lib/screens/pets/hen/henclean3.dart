import 'package:flutter/material.dart';
import 'package:petshop/screens/appbar/Notificationpage.dart';

class HenClean3 extends StatelessWidget {
  const HenClean3({super.key});

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
                "Observe the Chickens",
                style: TextStyle(fontSize: 20),
              ),
              Padding(
                padding: EdgeInsets.only(top: 20, right: 150),
                child: Text(
              "Spend some time with the flock, observing the chickens to make sure they are healthy. Active, alert chickens with bright eyes and smooth feathers are a good sign.",
                  
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
