import 'package:flutter/material.dart';
import 'package:petshop/screens/booking/booking.dart';
import 'package:petshop/screens/homepage.dart';
import 'package:petshop/donations/donationdog.dart';
import 'package:petshop/screens/booking/mybooking.dart';

class UserPage extends StatefulWidget {
  const UserPage({super.key});

  @override
  State<UserPage> createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  

  
//mybookings
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        
        appBar: AppBar(
          
          title: const Text("PetApp"),
          actions: [
            GestureDetector(
              
              onTap: (){
                Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const HomePage()));

              },
              child: const Icon(Icons.arrow_back))
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            
            children: [
             
              const SizedBox(height: 20,),
              Card(
                child: Row(
                  children: [
                    Expanded(
                      child: TextButton(onPressed: (){
                        Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const HomePage()));
                      },
                       child: const Text("HOME")),
                    ),
                     
                     Expanded(
                       child: TextButton(onPressed: (){
                         Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const BookingPage()));
                     
                       },
                       child: const Text("BOOKINGS")),
                     ),
                     Expanded(
                       child: TextButton(onPressed: (){
                        Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const MyBookingPage()));
                     
                       },
                       child: const Text("MY BOOKINGS")),
                     ),
                     
                     Expanded(
                       child: TextButton(onPressed: (){
                        Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const DonationPage()));
                       },
                       child: const Text("DONATE DOG")),
                     ),

                  ],
                ),
              )
              
            ],
          ),
        ),
      ),
    );
  }
}
