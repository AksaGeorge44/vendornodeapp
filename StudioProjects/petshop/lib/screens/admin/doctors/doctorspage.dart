import 'package:flutter/material.dart';
import 'package:petshop/screens/admin/doctors/doctoradd.dart';
import 'package:petshop/screens/admin/doctors/doctorview.dart';
class DoctorsPage extends StatefulWidget {
  const DoctorsPage({super.key});

  @override
  State<DoctorsPage> createState() => _DoctorsPageState();
}

class _DoctorsPageState extends State<DoctorsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const Padding(
            padding: EdgeInsets.all(50),
            child: Center(child: Text("DOCTORS",style: TextStyle(
              fontSize: 30,color: Colors.black
            ),),
            
  
            ),
            
          

          ),
          TextButton(onPressed: (){
            Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const DoctorAdd()),
          );

          }, 
          child: const Text("ADD")),
           TextButton(onPressed: (){
           Navigator.push(context,MaterialPageRoute(builder: (context) => const DoctorsViewPage()));
           }, 
          child: const Text("VIEW")),
        ],
      ),
        
        );
      
  }
}