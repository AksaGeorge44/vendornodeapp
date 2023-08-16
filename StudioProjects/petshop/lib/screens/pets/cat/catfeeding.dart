import 'package:flutter/material.dart';
import 'package:petshop/screens/appbar/Notificationpage.dart';

class CatFeedingPage extends StatelessWidget {
  const CatFeedingPage({super.key});

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
        title: const Text("Feeding"),
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
                "Cat Feeding",
                style: TextStyle(fontSize: 20),
              ),
              Padding(
                padding: EdgeInsets.only(top: 20, right: 150),
                child: Text("1. What’s the best pet exercise? "),
              ),
              SizedBox(
                height: 6,
              ),
              Card(
                  child: Padding(
                padding: EdgeInsets.all(20),
                child: Text(
                  "We recommend purchasing high-quality, brand-name kitten or cat food. Your veterinarian will be able to assess your new cat or kitten and determine the best diet. Factors such as age, activity level and health make a difference in what and how much a cat should eat.""Cats require taurine, an essential amino acid,for heart and eye health. The food you choose should be balanced for the life stage of your cat or kitten. Properly balanced foods will contain taurine.""You will need to provide fresh, clean water at all times, and wash and refill your cat’s water bowls daily.""Treats should be no more than 5-10% of the diet.""Many people feed baby food to a cat or kitten who is refusing food or not feeling well  Please read labels carefully: If the baby food contains onion or garlic powder, your pet could be poisoned.""Take your pet to your veterinarian if signs of anorexia, diarrhea, vomiting or lethargy continue for more than two days.""Please visit our People Foods to Avoid Feeding Your Pets page for a list of off-limits items, as well as our Cat Nutrition Tips page for more information."

                ),
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
