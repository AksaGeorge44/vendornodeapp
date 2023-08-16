import 'package:flutter/material.dart';
import 'package:petshop/screens/appbar/Notificationpage.dart';

class PetCare extends StatelessWidget {
  const PetCare({super.key});

  @override
  Widget build(BuildContext context) {
    TextStyle headingStyle = const TextStyle(fontSize: 17, fontWeight: FontWeight.bold);
    TextStyle paragraphStyle = const TextStyle(fontSize: 16);
   // TextStyle italicStyle = const TextStyle(fontStyle: FontStyle.italic);

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
                    builder: (context) => const NotificationPage(),
                  ),
                );
              },
              child: const Icon(Icons.notification_add_outlined),
            ),
          ),
        ],
        title: const Text("PetCare"),
      ),
      body: Container(
        margin: const EdgeInsets.all(10),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 25),
              Text(
                "PetCare",
                style: headingStyle,
              ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "Unfortunately, accidents do happen. When a medical emergency befalls our furry friends, pet parents may find it difficult to make rational decisions, especially if something occurs during the middle of the night. That’s why it’s crucial to have an emergency plan in place—before you need it.",
                  style: paragraphStyle,
                ),
              ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "Finding 24-Hour Emergency Care for Your Pet",
                  style: headingStyle,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "Talk to your veterinarian about an emergency protocol. Does your vet provide 24-hour service or does he or she work with an emergency clinic in the area? Some practices have multiple veterinarians on staff who rotate on-call services after hours. Check to see if your primary care vet has partners who might answer an emergency call. It’s also a smart idea to keep the name, number and address of your local emergency clinic tacked to the refrigerator or stored in your cell phone for easy access.",
                  style: paragraphStyle,
                ),
              ),
              const SizedBox(height: 30),
              Text(
                "Signs Your Pet May Need Emergency Care",
                style: headingStyle,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "Your dog may need emergency care because of severe trauma—caused by an accident or fall—choking, heatstroke, an insect sting, household poisoning or other life-threatening situation. Here are some signs that emergency care is needed.",
                  style: paragraphStyle,
                ),
              ),
              const SizedBox(height: 30),
              Text(
                "First Aid Treatments to Perform At Home",
                style: headingStyle,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "Most emergencies require immediate veterinary care, but first aid methods may help you stabilize your pet for transportation. If your pet is suffering from external bleeding due to trauma, try elevating and applying pressure to the wound. If your pet is choking, place your fingers in his mouth to see if you can remove the blockage. If you’re unable to remove the foreign object, perform a modified Heimlich maneuver by giving a sharp rap to his chest, which should dislodge the object.",
                  style: paragraphStyle,
                ),
              ),
              const SizedBox(height: 30),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "Performing CPR on Your Pet",
                  style: headingStyle,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "CPR may be necessary if your pet remains unconscious after you have removed the choking object. First check to see if he’s breathing. If not, place him on his side and perform artificial respiration by extending his head and neck, holding his jaws closed and blowing into his nostrils once every three seconds. (Ensure no air escapes between your mouth and the pet’s nose.) If you don’t feel a heartbeat, incorporate cardiac massage while administering artificial respiration—three quick, firm chest compressions for every respiration—until your dog resumes breathing on his own.",
                  style: paragraphStyle,
                ),
              ),
              const SizedBox(height: 30),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "What To Do If Your Pet Eats Something Poisonous?",
                  style: headingStyle,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "If you suspect your pet has ingested a toxic substance, please call your veterinarian or the ASPCA Animal Poison Control Center’s 24-hour hotline at (888) 426-4435. Trained toxicologists will consider the age and health of your pet, what and how much he ate, and then make a recommendation—such as whether to induce vomiting—based on their assessment.",
                  style: paragraphStyle,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
