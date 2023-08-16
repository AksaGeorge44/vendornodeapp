import 'package:flutter/material.dart';
import 'package:petshop/screens/appbar/Notificationpage.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
         actions:  [
            Padding(
              padding: const EdgeInsets.all(17),
              child: GestureDetector(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder:(context)=>const NotificationPage()));
                },
                
                child: const Icon(Icons.notification_add_outlined)),
            ),
           
          ],
        title: const Text("About"),
      ),
      body: const SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 20),
              Text(
                "About Us",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 23,
                  
                ),
              ),
              SizedBox(height: 20),
              Text(
                "Welcome to PetApp, your one-stop destination for all things pet-related! We are a passionate team of pet lovers dedicated to providing the best care and support for your furry friends. At PetApp, we believe that pets are not just animals; they are an integral part of our families.",
              ),
              SizedBox(height: 40),
              Text(
                "Our Mission",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 23,
                  
                ),
              ),
              SizedBox(height: 20),
              Text(
                "Our mission is to foster a happy and healthy bond between pets and their owners. We strive to create a pet-friendly community where pet owners can find valuable resources, services, and products to ensure their pets' well-being and happiness.",
              ),
              SizedBox(height: 40),
              Text(
                "Why Choose PetApp?",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 23,
                ),
              ),
              SizedBox(height: 20),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "EXPERTISE: Our team comprises experienced veterinarians, pet trainers, and pet care specialists who are always ready to lend a helping hand. We understand the unique needs of different pets and offer tailored solutions to address them.",
                  ),
                  SizedBox(height: 10),
                  Text(
                    "WIDE RANGE OF SERVICES: From routine check-ups to emergency care, training sessions to grooming services, and a selection of high-quality pet products, we have everything your pet needs under one roof.",
                  ),
                  SizedBox(height: 10),
                  Text(
                    "PASSION FOR PETS: Each member of our team shares a deep passion for animals. We treat every pet as if they were our own, ensuring they receive the utmost love and care.",
                  ),
                ],
              ),
              SizedBox(height: 40),
              Text(
                "Contact Us",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 23,
                ),
              ),
              SizedBox(height: 20),
              Text(
                "Have any questions or need assistance?\n"
                "Don't hesitate to reach out to us. Our friendly customer support team is available 24/7 to address your queries and concerns.\n\n"
                "Thank you for choosing PetApp. We look forward to being a part of your pet's journey and making it a joyful one!",
              ),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
