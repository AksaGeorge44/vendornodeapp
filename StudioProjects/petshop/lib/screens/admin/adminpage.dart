import 'package:flutter/material.dart';
import 'package:petshop/screens/admin/doctors/doctorspage.dart';
import 'package:petshop/screens/admin/pet/petadd.dart';
import 'package:petshop/screens/admin/pet/petpage.dart';
import 'package:petshop/screens/admin/servicepage/servicepage.dart';
import 'package:petshop/screens/admin/staffpage/staffpage.dart';

class AdminPage extends StatefulWidget {
  const AdminPage({super.key});

  @override
  State<AdminPage> createState() => _AdminPageState();
}

class _AdminPageState extends State<AdminPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Admin"),
      ),
      body: Column(
        children: [
          const Padding(
            padding: EdgeInsets.all(50),
            child: Center(child: Text("MAIN",style: TextStyle(
              fontSize: 30,color: Colors.black
            ),),
            
  
            ),
            
            


          ),
          TextButton(onPressed: (){
       Navigator.push(context, MaterialPageRoute(builder: (context)=>const StaffPage()));

          }, 
          child: const Text("STAFF")),
           TextButton(onPressed: (){
                     Navigator.push(context, MaterialPageRoute(builder: (context)=>const ServicePage()));


           }, 
          child: const Text("SERVICES")),
                      TextButton(onPressed: (){

         Navigator.push(context, MaterialPageRoute(builder: (context)=> const PetPage()));

                      }, 
          child: const Text("PETS")),
                      TextButton(onPressed: (){


                      }, 
                      child: const Text("PRODUCT CATEGORY")),
                      TextButton(onPressed: (){

                                       Navigator.push(context, MaterialPageRoute(builder: (context)=>const PetAdd()));

                      }, 
          child: const Text("ALL PRODUCTS")),
                      TextButton(onPressed: (){


                      }, 




         
          child: const Text("BOOKING")),
                      TextButton(onPressed: (){
           Navigator.push(context, MaterialPageRoute(builder: (context)=>const DoctorsPage()));

                      }, 
          child: const Text("DOCTORS")),

        ],
      ),
        
        );
      
  }
}