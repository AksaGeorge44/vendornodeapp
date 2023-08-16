import 'package:flutter/material.dart';
import 'package:petshop/screens/admin/signuppage.dart';

class NotificationPage extends StatefulWidget {
  const NotificationPage({super.key});

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          Padding(
            padding: const EdgeInsets.all(15),
            child: GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const SignupPage()));
                },
                child: const Icon(Icons.account_box)),
          )
        ],
        title: const Text("Notification"),
      ),
      body: const Column(
        children: [
          Padding(
            padding: EdgeInsets.all(100),
            child: Center(child: Text("No New Notificatons")),
          )
        ],
      ),
    );
  }
}
