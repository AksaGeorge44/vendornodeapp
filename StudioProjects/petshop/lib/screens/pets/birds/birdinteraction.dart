import 'package:flutter/material.dart';
import 'package:petshop/screens/appbar/Notificationpage.dart';

class BirdInteractionPage extends StatelessWidget {
  const BirdInteractionPage({super.key});

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
        title: const Text("Interaction"),
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
                "Pet Bird interaction and socialization",
                style: TextStyle(fontSize: 20),
              ),
              Padding(
                padding: EdgeInsets.only(top: 20, right: 150),
                child: Text(
                  "Understanding bird behavior in the wild is very important to understanding their behavior as companions. For instance, parrots are social animals in the wild. They roost, fly, and forage in flocks. Your family is the flock for a pet bird, and it wants to be part of family activities. If your family is in one room and the bird is in its cage in another, the bird may scream to get the flock's attention. Similarly, many species of parrots mate for life. So, when a parrot bonds with one person and is showing offensive behavior toward others, it is simply protecting its “mate",
                  
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
