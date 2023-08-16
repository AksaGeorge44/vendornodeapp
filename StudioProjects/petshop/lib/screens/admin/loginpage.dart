import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:petshop/firebase_helper/firebase_authhelper.dart';
import 'package:petshop/screens/admin/adminpage.dart';
import 'package:petshop/model/constants.dart';
import 'package:petshop/screens/user_auth/forgotpassword.dart';
import 'package:petshop/screens/user_auth/signuppage.dart';

class AdminLoginPage extends StatefulWidget {
  const AdminLoginPage({super.key});

  @override
  State<AdminLoginPage> createState() => _AdminLoginPageState();
}

class _AdminLoginPageState extends State<AdminLoginPage> {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(100),
            child: Column(
              children: [
                const SizedBox(
                  height: 150,
                ),
                SizedBox(
                  width: 200,
                  child: TextField(
                    controller: email,
                    decoration: InputDecoration(
                        labelText: "enter your email",
                        hintText: "email",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                        )),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                SizedBox(
                  width: 200,
                  child: TextField(
                    
                    controller: password,
                    obscureText: true,
                    decoration: InputDecoration(
                        labelText: "enter your password",
                    
                        hintText: "password",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                        )),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                    onPressed: () async {
                      var getemail = email.text;
                      var getpassword = password.text;
                      if (kDebugMode) {
                        print(getemail);
                      }
                      if (kDebugMode) {
                        print(getpassword);
                      }

                      bool isValidated =
                          loginValidation(email.text, password.text);
                      if (isValidated) {
                        bool isLoginied = await FirebaseAuthHelper.instance
                            .adminlogin(email.text, password.text, context);
                        if (isLoginied) {
                          // ignore: use_build_context_synchronously
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const AdminPage()));
                        }
                      }
                    },
                    child: const Text(
                      "Login",
                      style: TextStyle(fontSize: 20),
                    )),
                const SizedBox(
                  height: 20,
                ),
                TextButton(
                    onPressed: () {
                       Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ForgotPasswordScreen()));

                    },
                    child: const Text(
                      "Forgot password?",
                      style: TextStyle(fontSize: 20),
                    )),
                const SizedBox(
                  height: 20,
                ),
                const Text(
                  "Don't have an account? ",
                  style: TextStyle(fontSize: 16),
                ),
                const SizedBox(
                  height: 20,
                ),
                TextButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const SignupPage()));
                    },
                    child: const Text(
                      "Signup",
                      style: TextStyle(fontSize: 25),
                    ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
