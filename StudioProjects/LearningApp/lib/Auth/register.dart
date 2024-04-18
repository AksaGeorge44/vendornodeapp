import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:learningapp/Auth/login.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {

  final _formKey = GlobalKey<FormState>();

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _unameController = TextEditingController();
  String? _selectedAgeCategory;

  Future<void> _register() async {
    if (_formKey.currentState!.validate()) {
      try {
        final existingUser = await FirebaseFirestore.instance
            .collection('users')
            .where('email', isEqualTo: _emailController.text)
            .get();
        if (existingUser.docs.isNotEmpty) {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text("Email already exists")));

        }
        final existingUsername = await FirebaseFirestore.instance
            .collection('users')
            .doc(_unameController.text)
            .get();
        if (existingUsername.exists) {
          ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text("Username already exists")));

        }

        UserCredential userCredential = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(
            email: _emailController.text,
            password: _passwordController.text);

        await FirebaseFirestore.instance
            .collection('users')
            .doc(userCredential.user!.uid)
            .set({
          'uname': _unameController.text,
          'email': _emailController.text,
          'password': _passwordController.text,
          'selectedAgeCategory': '2-3 years',
        });

        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text("Registered successfully")));
        Navigator.push(
            context, MaterialPageRoute(builder: (context) =>
            LoginPage()
        ));
      } catch (e) {
        print("error:${e}");

        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text("Error: $e")));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Register'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _emailController,
                decoration: InputDecoration(labelText: 'Email'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your email';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _unameController,
                decoration: InputDecoration(labelText: 'Username'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your username';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _passwordController,
                decoration: InputDecoration(labelText: 'Password'),
                obscureText: true,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your password';
                  }
                },
              ),
              DropdownButtonFormField<String>(
                value: _selectedAgeCategory,
                items: ['2-3 years', '4-5 years', '6-10 years']
                    .map<DropdownMenuItem<String>>(
                      (String value) => DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  ),
                )
                    .toList(),
                onChanged: (String? value) {
                  setState(() {
                    _selectedAgeCategory = value;
                  });
                },
                decoration: InputDecoration(labelText: 'Select Age Category'),
              ),

              ElevatedButton(
                onPressed: () {
                  _register();
                },
                child: Text('Register'),
              ),
            ],
          ),
        ),
      ),
    );
  }

}
