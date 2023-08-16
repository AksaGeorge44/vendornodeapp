import 'package:flutter/material.dart';
import 'package:petshop/screens/appbar/Notificationpage.dart';

class DogHousingPage extends StatelessWidget {
  const DogHousingPage({super.key});

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
        title: const Text("HousingPage"),
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
                "Dog Housing",
                style: TextStyle(fontSize: 20),
              ),
             
              SizedBox(
                height: 6,
              ),
              Card(
                  child: Padding(
                padding: EdgeInsets.all(20),
                child: Text(
                  "Your pet needs a warm, quiet place to rest, away from all drafts and off the floor. A training crate or dog bed is ideal, with a clean blanket or pillow placed inside. Wash the dog's bedding often. If your dog will be spending a lot of time outdoors, be sure she has access to shade and plenty of cool water in hot weather, and a warm, dry, covered shelter when it's cold.")
              )),
              SizedBox(
                height: 40,
              ),
              // Padding(
              //   padding: EdgeInsets.only(top: 20, right: 130),
              //   child: Text("2. Which food did I get last time? "),
              // ),
              // SizedBox(
              //   height: 6,
              // ),
              // Card(
              //     child: Padding(
              //   padding: EdgeInsets.all(20),
              //   child: Text(
              //       "Many small pet specialty stores offer customer loyalty programs, and these can include helping you keep track of the foods you buy. If you have a hard time remembering what food your pet eats but don’t want to risk upset tummies due to a sudden switch, selecting a pet retailer who can help you keep track of your purchases is a great choice. Dogs and cats often benefit from rotating flavors (for example: beef one month, fish the next), but generally only when you’re sticking within the same brand for consistent quality, and comparable protein, fat, and carbohydrate levels."),
              // )),
              // SizedBox(
              //   height: 40,
              // ),
              // Padding(
              //   padding: EdgeInsets.only(top: 20, right: 130),
              //   child: Text("3. Can you recommend a good…?"),
              // ),
              // SizedBox(
              //   height: 6,
              // ),
              // Card(
              //     child: Padding(
              //   padding: EdgeInsets.all(20),
              //   child: Text(
              //       "Veterinarian? Groomer? Pet Hotel? Trainer? Dog Walker? Pet specialty stores are a perfect place to ask about related pet professionals and services. Most independent stores will keep the business cards of people or services they recommend, or else employees may have had experiences with the kinds of businesses you’re interested in."),
              // )),
            ],
          ),
        ),
      ),
    );
  }
}
