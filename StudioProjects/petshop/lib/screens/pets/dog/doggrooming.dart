import 'package:flutter/material.dart';
import 'package:petshop/screens/appbar/Notificationpage.dart';

class DogGroomingPage extends StatelessWidget {
  const DogGroomingPage({super.key});

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
        title: const Text("GroomingPage"),
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
                "Dog Grooming",
                style: TextStyle(fontSize: 20),
              ),
             
              SizedBox(
                height: 6,
              ),
              Card(
                  child: Padding(
                padding: EdgeInsets.all(20),
                child: Text(
                  "Help keep your dog clean and reduce shedding with frequent brushing. Check for fleas and ticks daily during warm weather. Most dogs don't need to be bathed more than a few times a year. Before bathing, comb or cut out all mats from the coat. Carefully rinse all soap out of the coat, or the dirt will stick to soap residue. Please visit our Dog Grooming Tips page for more information.")
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
