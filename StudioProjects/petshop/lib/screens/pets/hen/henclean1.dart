import 'package:flutter/material.dart';
import 'package:petshop/screens/appbar/Notificationpage.dart';

class HenClean1 extends StatelessWidget {
  const HenClean1({super.key});

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
                "Clean water bowls and containers",
                style: TextStyle(fontSize: 20),
              ),
              Padding(
                padding: EdgeInsets.only(top: 20, right: 150),
                child: Text(
                  "Use dish soap and water for regular cleanings, and rinse well before refilling. You can also use chlorine bleach or oxygen bleach as needed to sanitize the water container, as long as you rinse it thoroughly."
                  
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
