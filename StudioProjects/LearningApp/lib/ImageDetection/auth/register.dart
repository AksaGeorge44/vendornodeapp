import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'login.dart';

class RegisterPage1 extends StatefulWidget {
  const RegisterPage1({Key? key});

  @override
  _RegisterPage1State createState() => _RegisterPage1State();
}

class _RegisterPage1State extends State<RegisterPage1> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _unameController = TextEditingController();
  bool isShowPassword = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Register'),
        backgroundColor: Colors.grey.shade200,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 10,),
                ClipOval(
                  child: Image.asset(
                    'assets/images1/login1.jpg',
                    width: 250,
                    height: 250,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(height: 20,),
                TextFormField(
                  controller: _unameController,
                  decoration: const InputDecoration(labelText: 'Username'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your username';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _emailController,
                  decoration: const InputDecoration(
                    labelText: "Email",
                  ),
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a valid email address.';
                    }
                    if (!RegExp(
                        r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$')
                        .hasMatch(value)) {
                      return 'Please enter a valid email address.';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _passwordController,
                  obscureText: isShowPassword,
                  decoration: InputDecoration(
                    labelText: "Password",
                    suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          isShowPassword = !isShowPassword;
                        });
                      },
                      padding: EdgeInsets.zero,
                      icon: Icon(
                        isShowPassword ? Icons.visibility : Icons.visibility_off,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a valid value.';
                    }
                    if (value.length < 8 || !RegExp(r'[0-9]').hasMatch(value) || !RegExp(r'[!@#$%^&*]').hasMatch(value)) {
                      return 'Password should contain a minimum of 8 characters, \n one number, and one special character.';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 30,),
                SizedBox(
                  width: 250,
                  child: ElevatedButton(
                    onPressed: () {
                      _register();
                    },
                    child: const Text('Register',style: TextStyle(
                        fontSize: 20
                    ),),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }


  Future<void> _register() async {
    if (_formKey.currentState!.validate()) {
      try {
        final existingUser = await FirebaseFirestore.instance
            .collection('users')
            .where('email', isEqualTo: _emailController.text)
            .get();
        if (existingUser.docs.isNotEmpty) {
          ScaffoldMessenger.of(context)
              .showSnackBar(const SnackBar(content: Text("Email already exists")));
          return;
        }
        final existingUsername = await FirebaseFirestore.instance
            .collection('users')
            .doc(
            _unameController.text) // Check if document with username exists
            .get();
        if (existingUsername.exists) {
          ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("Username already exists")));
          return;
        }

        UserCredential userCredential = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(
            email: _emailController.text,
            password: _passwordController.text);

        await FirebaseFirestore.instance
            .collection('users')
            .doc(_unameController.text)
            .set({
          'uname': _unameController.text,
          'email': _emailController.text,
          'password': _passwordController.text,
        });

        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text("Registered successfully")));
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => const LoginPageI()));
      } catch (e) {
        print("error:$e");
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text("Error: $e")));
      }
    }
  }
}
