import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:petshop/screens/appbar/Notificationpage.dart';
import 'package:firebase_auth/firebase_auth.dart'; // Import Firebase Authentication

class QueriesPage extends StatefulWidget {
  const QueriesPage({super.key});

  @override
  State<QueriesPage> createState() => _QueriesPageState();
}

class _QueriesPageState extends State<QueriesPage> {
  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController queries = TextEditingController();

  User? loggedInUser; // User object to store logged-in user

  @override
  void initState() {
    super.initState();
    fetchLoggedInUser(); // Call the function to fetch user information
  }

  Future<void> registerUser(
      String email, String password, String username) async {
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Once user is created, update the display name
      await FirebaseAuth.instance.currentUser
          ?.updateProfile(displayName: username);

      if (kDebugMode) {
        print("User registered successfully with username: $username");
      }
    } catch (e) {
      if (kDebugMode) {
        print("Error registering user: $e");
      }
    }
  }

  Future<void> fetchLoggedInUser() async {
    loggedInUser = FirebaseAuth.instance.currentUser; // Fetch the current user
    if (loggedInUser != null) {
      name.text = loggedInUser!.displayName ?? ''; // Display name
      email.text = loggedInUser!.email ?? ''; // Email address
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          Padding(
            padding: const EdgeInsets.all(17),
            child: GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const NotificationPage()));
                },
                child: const Icon(Icons.notification_add_outlined)),
          ),
        ],
        title: const Text("Queries"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(25),
              child: Column(
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  const Text(
                    "Queries",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    width: 500,
                    child: TextFormField(
                      controller: name,
                      decoration: const InputDecoration(
                        labelText: "Your Name",
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  SizedBox(
                    width: 500,
                    child: TextFormField(
                      controller: email,
                      decoration: const InputDecoration(
                        labelText: "Your Email",
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  SizedBox(
                    width: 500,
                    child: TextFormField(
                      controller: queries,
                      maxLines: 4,
                      decoration: InputDecoration(
                          labelText: "Your Queries",
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20))),
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  ElevatedButton(onPressed: () {}, child: const Text("Submit")),
                  Padding(
                    padding: const EdgeInsets.only(left: 20),
                    child: SizedBox(
                      height: 250,
                      child: Image.network(
                        "https://images-platform.99static.com//p1K4gaifPfnIvrA6NgCxe-Kbz3c=/1032x1025:1950x1943/fit-in/590x590/99designs-contests-attachments/144/144772/attachment_144772736",
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
