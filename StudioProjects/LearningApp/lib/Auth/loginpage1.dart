import 'package:flutter/material.dart';
import '../Home/homepage.dart';

class LoginPage1 extends StatelessWidget {
  final List<String> registeredEmails;

  LoginPage1({required this.registeredEmails});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: ListView.builder(
        itemCount: registeredEmails.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(registeredEmails[index]),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => HomePage()),
              );
            },
          );
        },
      ),
    );
  }
}
