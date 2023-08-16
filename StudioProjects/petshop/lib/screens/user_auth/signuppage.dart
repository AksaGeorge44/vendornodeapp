import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:petshop/firebase_helper/firebase_authhelper.dart';
import 'package:petshop/screens/appbar/fonts.dart';
import 'package:petshop/model/constants.dart';
import 'package:petshop/screens/user_auth/loginpage.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  bool isShowPassword = true;

  TextEditingController uname = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  String passwordErrorMessage = "";

  bool isPasswordValid(String password) {
    // Password should have at least 8 characters, one uppercase letter, and one digit
    RegExp passwordRegex = RegExp(r'^(?=.*[A-Z])(?=.*\d).{8,}$');
    return passwordRegex.hasMatch(password);
  }

  List<String> itemList = []; // List to store the fetched item names

  Future<void> fetchDataFromFirestore() async {
    try {
      QuerySnapshot querySnapshot =
          await FirebaseFirestore.instance.collection('users').get();

      if (querySnapshot.size > 0) {
        itemList.clear();

        for (QueryDocumentSnapshot documentSnapshot in querySnapshot.docs) {
          String itemName = documentSnapshot.get('name');
          itemList.add(itemName);
        }

        setState(() {});
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error fetching data: $e');
      }
    }
  }

  @override
  void initState() {
    super.initState();
    fetchDataFromFirestore();
  }

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
                "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQrKfoaADJDS3XD_awSTudrUcBB7Zdeob6tiaQJUvXt3mTFaXzX7kRhI4KCFyG9e3QyB-8&usqp=CAU",
              ),
              fit: BoxFit.cover,
            ),
          ),
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(30),
              child: Column(
                children: [
                  const SizedBox(
                    height: 250,
                  ),
                  TextFormField(
                    controller: uname,
                    style: MyFonts.roboto(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                    decoration: const InputDecoration(
                      hintText: "Enter your username",
                      labelText: "uname",
                      prefixIcon: Icon(Icons.account_box_outlined),

                      // border: OutlineInputBorder(
                      //   borderRadius: BorderRadius.circular(20),
                      // )
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    controller: email,
                    style: MyFonts.roboto(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                    decoration: const InputDecoration(
                      hintText: "Enter your email",
                      labelText: "email",
                      prefixIcon: Icon(Icons.email_outlined),

                      // border: OutlineInputBorder(
                      //   borderRadius: BorderRadius.circular(20),
                      // )
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    controller: password,
                    obscureText: isShowPassword,
                    style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(209, 0, 0, 0)),
                    decoration: InputDecoration(
                      hintText: "Enter your password",
                      labelText: "password",
                      prefixIcon: const Icon(Icons.password_rounded),
                      suffixIcon: CupertinoButton(
                        onPressed: () {
                          setState(() {
                            isShowPassword = !isShowPassword;
                          });
                        },
                        padding: EdgeInsets.zero,
                        child: Icon(
                          isShowPassword
                              ? Icons.visibility
                              : Icons.visibility_off,
                          color: Colors.grey,
                        ),
                      ),
                      errorText: passwordErrorMessage,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextButton(
                    onPressed: () async {
                      var getuname = uname.text;
                      var getemail = email.text;
                      var getpassword = password.text;

                      if (signUpValidation(getemail, getpassword, getuname)) {
                        if (!isPasswordValid(getpassword)) {
                          setState(() {
                            passwordErrorMessage =
                                "At least 8 character,one uppercase letter,and one digit.";
                          });
                        } else if (itemList.contains(getuname)) {
                          // User already exists
                          showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                title: const Text("User already exists"),
                                content: const Text(
                                    "The entered username is already registered."),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                      // Clear input fields
                                      uname.clear();
                                      email.clear();
                                      password.clear();
                                    },
                                    child: const Text("OK"),
                                  ),
                                ],
                              );
                            },
                          );
                        } else {
                          bool isLogined = await FirebaseAuthHelper.instance
                              .signUp(getuname, getemail, getpassword, context);

                          if (isLogined) {
                            await fetchDataFromFirestore();
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const LoginPage()),
                            );
                          }
                        }
                      }
                    },
                    child: const Text(
                      "Register",
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Text("Already have an account "),
                  TextButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const LoginPage()));
                      },
                      child: const Text(
                        "Login",
                        style: TextStyle(fontSize: 20),
                      )),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
