import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:petshop/screens/appbar/Notificationpage.dart';
import 'package:url_launcher/url_launcher.dart'; // Import the package
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';

class ContactPage extends StatefulWidget {
  const ContactPage({super.key});

  @override
  State<ContactPage> createState() => _ContactPageState();
}

class _ContactPageState extends State<ContactPage> {
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
        title: const Text("Contact"),
      ),
      body: Column(
        children: [
          const SizedBox(
            height: 30,
          ),
          const Column(
            children: [
              Text(
                "Get In Touch",
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 30,
          ),
          GestureDetector(
            onTap: () async {
              final smtpServer = gmail('aksageorge97@gmail.com', 'Sujageorge44*');
              final message = Message()
                ..from = const Address('aksageorge97@gmail.com', 'Aksa George')
                ..recipients.add('aksageorge97@gmail.com')
                ..subject = 'Subject'
                ..text = 'Message plain text';

              try {
                await send(message, smtpServer);
                if (kDebugMode) {
                  print('Email sent successfully');
                }
              } catch (e) {
                if (kDebugMode) {
                  print('Error sending email: $e');
                }
              }
            },
            child: const Text(
              "Email: aksageorge97@gmail.com",
              style: TextStyle(
                color: Colors.blue,
                decoration: TextDecoration.underline,
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          GestureDetector(
            onTap: () async {
              final Uri _phoneLaunchUri = Uri(
                scheme: 'tel',
                path: '+01234567890',
              );
              if (await canLaunch(_phoneLaunchUri.toString())) {
                await launch(_phoneLaunchUri.toString());
              } else {
                throw 'Could not launch phone app.';
              }
            },
            child: const Text(
              "Contact: +012 345 67890",
              style: TextStyle(
                color: Colors.blue,
                decoration: TextDecoration.underline,
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          GestureDetector(
            onTap: () async {
              final Uri _mapLaunchUri = Uri(
                scheme: 'https',
                host: 'www.google.com',
                path: 'maps/search/',
                query: 'q=Abc+street,India',
              );
              if (await canLaunch(_mapLaunchUri.toString())) {
                await launch(_mapLaunchUri.toString());
              } else {
                throw 'Could not open Google Maps.';
              }
            },
            child: const Text(
              "Address: Abc street,India",
              style: TextStyle(
                color: Colors.blue,
                decoration: TextDecoration.underline,
              ),
            ),
          ),
          const SizedBox(
            height: 50,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 55),
            child: Image.network(
              "https://seeklogo.com/images/S/simple-dog-logo-FECD742F37-seeklogo.com.png",
              fit: BoxFit.contain,
            ),
          )
        ],
      ),
    );
  }
}
