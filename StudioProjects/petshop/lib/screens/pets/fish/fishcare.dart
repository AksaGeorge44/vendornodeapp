import 'package:flutter/material.dart';
import 'package:petshop/screens/appbar/Notificationpage.dart';

class FishCare extends StatelessWidget {
  const FishCare({super.key});

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
        title: const Text("FishCare"),
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
                "General Care",
                style: TextStyle(fontSize: 20),
              ),
              Padding(
                padding: EdgeInsets.only(top: 20, right: 150),
                child: Text("Thorough research"),
              ),
              SizedBox(
                height: 6,
              ),
              Card(
                  child: Padding(
                padding: EdgeInsets.all(20),
                child: Text(
                  "Fish, like other animals, can adapt to different environments. The first step will require extensive research into the type of fish you intend to have.  The pH of the water ideal for the fish, the temperature, and the sort of food they eat are all essential points. Knowing the type of fish allows a pet owner to determine whether the fish can live with others or is happy alone. To avoid fish conflicts, more aggressive fish should be kept in their individual tanks.",
                  
                  )
              )),
              SizedBox(
                height: 40,
              ),
              Padding(
                padding: EdgeInsets.only(top: 20, right: 130),
                child: Text("Sufficient space"),
              ),
              SizedBox(
                height: 6,
              ),
              Card(
                  child: Padding(
                padding: EdgeInsets.all(20),
                child: Text("One of the most significant things to keep in mind is to provide your fish with sufficient space. It is always said, the bigger the fish tank space, the better it is. However, the size of the tank will depend on the type and the number of fish you decide to have as your pets. ",)
              )),
              SizedBox(
                height: 40,
              ),
              Padding(
                padding: EdgeInsets.only(top: 20, right: 130),
                child: Text("Decorating the tank"),
              ),
              SizedBox(
                height: 6,
              ),
              Card(
                  child: Padding(
                padding: EdgeInsets.all(20),
                child: Text(
                  "A popular tendency among pet-fish owners is to decorate the tanks with lovely, eye-catching decor that often mirrors their home design. A lot of decor, imitation plants, and decorations are even seen in larger fish tanks. Keep in mind why you purchased a bigger tank in the first place. Your fish requires more room. Ensure that you don't stuff it with needless decorations. If you know your fish likes to burrow or hide in dark spots and corners, purchasing a few shaded plants or objects for them to swim over, under, or through can be beneficial.",
              
              ))),
            ],
          ),
        ),
      ),
    );
  }
}
