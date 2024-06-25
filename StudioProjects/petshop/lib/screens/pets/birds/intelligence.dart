import 'package:flutter/material.dart';
import 'package:petshop/screens/appbar/Notificationpage.dart';

class BirdIntelligencePage extends StatelessWidget {
  const BirdIntelligencePage({super.key});

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
        title: const Text("Intelligence"),
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
                "Pet Bird Intelligence",
                style: TextStyle(fontSize: 20),
              ),
              Padding(
                padding: EdgeInsets.only(top: 20, right: 150),
                child: Text(
                  "Some pet birds (macaws, African Greys, amazons, and others) can mimic speech and sounds they hear. Some species are better at mimicking than others but remember that each individual bird is different. Some soft-billed birds, such as the mynah, are good at mimicry, too.",
                  
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
