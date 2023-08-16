import 'package:flutter/material.dart';
import 'package:petshop/screens/admin/servicepage/add.dart';
import 'package:petshop/screens/admin/servicepage/view.dart';

class ServicePage extends StatefulWidget {
  const ServicePage({super.key});

  @override
  State<ServicePage> createState() => _ServicePageState();
}

class _ServicePageState extends State<ServicePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Service"),
      ),
      body: Column(
        children: [
          const SizedBox(height: 50,),
          const Padding(
            padding: EdgeInsets.only(left: 500),
            
            
          

          ),
          TextButton(onPressed: (){
            Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const AddService()),
          );

          }, 
          child: const Text("ADD")),
           TextButton(onPressed: (){
            Navigator.push(context,MaterialPageRoute(builder: (context) =>  const ServiceView()));
           }, 
          child: const Text("VIEW")),
        ],
      ),
        
        );
      
  }
}