import 'package:flutter/material.dart';
import 'package:petshop/screens/admin/staffpage/add.dart';
import 'package:petshop/screens/admin/staffpage/viewpage.dart';

class StaffPage extends StatefulWidget {
  const StaffPage({super.key});

  @override
  State<StaffPage> createState() => _StaffPageState();
}

class _StaffPageState extends State<StaffPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Staff"),
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
              MaterialPageRoute(builder: (context) => const StaffAdd()),
            );
          
            }, 
            child: const Text("ADD")),
          ),
           Padding(
             padding: const EdgeInsets.only(left: 150),
             child: TextButton(onPressed: (){
              Navigator.push(context,MaterialPageRoute(builder: (context) =>  const StaffViewPage()));
             }, 
                     child: const Text("VIEW")),
           ),
        ],
      ),
        
        );
      
  }
}