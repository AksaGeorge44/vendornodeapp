import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:learningapp/ImageDetection/auth/register.dart';
import 'package:learningapp/ImageDetection/auth/resetpassword.dart';
import 'package:learningapp/ImageDetection/homepageI.dart';

import '../../Auth/register.dart';
import '../../Auth/resetpassword.dart';
import '../../Home/homepage.dart';

class LoginPageI extends StatefulWidget {
  const LoginPageI({Key? key});

  @override
  _LoginPageIState createState() => _LoginPageIState();
}

class _LoginPageIState extends State<LoginPageI> {
  final _formKey = GlobalKey<FormState>();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool isShowPassword=true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 20,),
                const Padding(
                  padding: EdgeInsets.only(right: 250),
                  child: Text("LOGIN",style: TextStyle(
                      fontSize: 30
                  ),),
                ),
                SizedBox(height: 20,),
                ClipOval(
                    child: Image.asset('assets/images1/loginbackg.jpg',
                      height: 200,
                      width: 200,
                      fit: BoxFit.cover,)),
                SizedBox(height: 20,),
                TextFormField(
                  controller: _emailController,
                  decoration: const InputDecoration(
                    labelText: 'Email',
                    hintText: "Enter your email",
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your email';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _passwordController,
                  obscureText: isShowPassword,
                  decoration: InputDecoration(
                    hintText: "Enter your password",
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
                    return null;
                  },
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 185),
                  child: TextButton(
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) =>  ResetPasswordPage1()));
                    },
                    child: const Text("Forgot Password ?",style: TextStyle(
                        fontSize: 16
                    ),),
                  ),
                ),
                const SizedBox(height: 20),
                SizedBox(
                  width: 250,
                  child: ElevatedButton(
                    onPressed: () {
                      _login();
                    },
                    child: const Text('Login',style: TextStyle(
                        fontSize: 20,
                        color: Colors.blue
                    ),),
                  ),
                ),
                const SizedBox(height: 15),
                const Text("OR"),
                const SizedBox(height: 15,),
                SizedBox(
                  width: 250,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>  RegisterPage1(),
                        ),
                      );
                    },
                    child: const Text("Register",style: TextStyle(
                        fontSize: 20,
                        color: Colors.blue
                    ),),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _login() async {
    if (_formKey.currentState!.validate()) {
      try {
        UserCredential userCredential = await _auth.signInWithEmailAndPassword(
          email: _emailController.text,
          password: _passwordController.text,
        );

        DocumentSnapshot userDoc = await FirebaseFirestore.instance
            .collection('users')
            .doc(userCredential.user!.uid)
            .get();

        String username = userDoc['uname'];
        String useremail = userDoc['email'];

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) =>  HomePage1(),
          ),
        );
      } catch (e) {
        print("Error during login: $e");
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Error: $e")));
      }
    }
  }
}
