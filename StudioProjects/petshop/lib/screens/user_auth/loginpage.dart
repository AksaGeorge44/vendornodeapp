import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:petshop/firebase_helper/firebase_authhelper.dart';
import 'package:petshop/screens/appbar/fonts.dart';
import 'package:petshop/model/constants.dart';
import 'package:petshop/screens/homepage.dart';
import 'package:petshop/screens/user_auth/forgotpassword.dart';
import 'package:petshop/screens/user_auth/signuppage.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
      bool isShowPassword = true;

  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Container(
          height: 1000,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: NetworkImage(
                "https://files.123freevectors.com/wp-content/original/112513-pink-and-yellow-blurred-background-vector.jpg",
              ),
              fit: BoxFit.cover,
            ),
          ),
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(25.0),
              child: Column(
                children: [
                  const SizedBox(
                    height: 250,
                  ),
                  TextFormField(
                    controller: email,
                    style: MyFonts.lato(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                    decoration: const InputDecoration(
                      hintText: "Enter your email",
                      prefixIcon: Icon(Icons.email_outlined),

                      labelText: "Email",
                      // border: OutlineInputBorder(
                      //   borderRadius: BorderRadius.circular(20),
                      // ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    controller: password,
                    obscureText: isShowPassword,
                    style: MyFonts.lato(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                    decoration:  InputDecoration(
                      hintText: "Enter your password",
                      prefixIcon:  const Icon(Icons.password_rounded),
                       suffixIcon: CupertinoButton(
                    onPressed: () {
                      setState(() {
                        isShowPassword = !isShowPassword;
                      });
                    },
                    padding: EdgeInsets.zero,
                    child: const Icon(
                      Icons.visibility,
                      color: Colors.grey,
                    )),

                      labelText: "Password",
                      // border: OutlineInputBorder(
                      //   borderRadius: BorderRadius.circular(20),
                      // ),
                    ),
                  ),
                  TextButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ForgotPasswordScreen()));
                      },
                      child: const Padding(
                        padding: EdgeInsets.only(left: 180),
                        child: Text(
                          "Forgot password?",
                          style: TextStyle(fontSize: 15),
                        ),
                      )),
                  const SizedBox(
                    height: 20,
                  ),
                  TextButton(
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
                              .login(email.text, password.text, context);
                          if (isLoginied) {
                            // ignore: use_build_context_synchronously
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const HomePage()));
                          }
                        }
                      },
                      child: const Text(
                        "Login",
                        style: TextStyle(fontSize: 22),
                      )),
                  const SizedBox(
                    height: 7,
                  ),
                  const Text("OR"),
                  TextButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const SignupPage()));
                      },
                      child: const Text(
                        "SignUp",
                        style: TextStyle(fontSize: 22),
                      ))
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
