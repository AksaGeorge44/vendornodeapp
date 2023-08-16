import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:petshop/firebase_helper/firebase_authhelper.dart';
import 'package:petshop/model/provider.dart';
import 'package:petshop/screens/user_auth/loginpage.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Stripe.publishableKey =
      "pk_test_51MWx8OAVMyklfe3CsjEzA1CiiY0XBTlHYbZ8jQlGtVFIwQi4aNeGv8J1HUw4rgSavMTLzTwgn0XRlwoTVRFXyu2h00mRUeWmAf";
  Stripe.instance.applySettings();
  await Firebase.initializeApp();

  runApp(const App());
}

class App extends StatefulWidget {
  const App({super.key});
  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => AppProvider(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'PetApp',
        home: StreamBuilder(
    stream: FirebaseAuthHelper.instance.getAuthChange,
    builder: (context, snapshot) {
    if (snapshot.hasData) {
    return const LoginPage();
    }
    return const LoginPage();
    },
      ),
    ),
    );
   
  }
}
