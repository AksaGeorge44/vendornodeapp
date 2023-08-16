import 'package:flutter/material.dart';
import 'package:petshop/screens/admin/pet/petadd.dart';
import 'package:petshop/screens/admin/pet/view.dart';

class PetPage extends StatefulWidget {
  const PetPage({super.key});

  @override
  State<PetPage> createState() => _PetPageState();
}

class _PetPageState extends State<PetPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Pets"),
      ),
      body: Column(
        children: [
          const Padding(
            padding: EdgeInsets.all(50),
          
          ),
          Padding(
            padding: const EdgeInsets.only(left: 150),
            child: TextButton(onPressed: (){
              Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const PetAdd()),
            );
          
            }, 
            child: const Text("ADD")),
          ),
           Padding(
             padding: const EdgeInsets.only(left: 150),
             child: TextButton(onPressed: (){
              Navigator.push(context,MaterialPageRoute(builder: (context) =>  const PetView()));
             }, 
                     child: const Text("VIEW")),
           ),
        ],
      ),
        
        );
      
  }
}