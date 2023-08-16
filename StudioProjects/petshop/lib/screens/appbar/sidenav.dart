import 'package:flutter/material.dart';
import 'package:petshop/cart/favscreen.dart';
import 'package:petshop/cart/orderscreen.dart';
import 'package:petshop/screens/appbar/about.dart';
import 'package:petshop/screens/appbar/contact.dart';
import 'package:petshop/screens/appbar/faq.dart';
import 'package:petshop/screens/appbar/queries.dart';
import 'package:petshop/screens/booking/booking.dart';
import 'package:petshop/donations/donationdog.dart';
import 'package:petshop/screens/booking/mybooking.dart';
import 'package:petshop/model/provider.dart';
import 'dart:io';


import 'package:provider/provider.dart';

class MyDrawer extends StatefulWidget {

 
  const MyDrawer({super.key,});

  @override
  State<MyDrawer> createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {

    
  @override
  Widget build(BuildContext context) {
          AppProvider appProvider=Provider.of<AppProvider>(context);
            List<CartItem> cartItems = appProvider.getCartProductList.map((product) {
  
  return CartItem(
    productName: product.name,
    qty: product.qty, // Nullable int from your SingleCartItem
    totalPrice: product.price, productImage: product.image,
  );
}).toList();

    return Drawer(
      child: ListView(
        children: [
          const UserAccountsDrawerHeader(
            currentAccountPicture: CircleAvatar(
              child: Text("S"),
            ),
            decoration: BoxDecoration(color: Colors.blue),
            accountName: Text(""),
            accountEmail: Text(""),
          ),
          

          ListTile(
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const AboutPage()));
            },
            title: const Text("About"),
          ),
          const Divider(
            color: Colors.black,
          ),

          ListTile(
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const BookingPage()));
            },
            title: const Text("Bookings"),
          ),
          const Divider(
            color: Colors.black,
          ),
          ListTile(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const MyBookingPage()));
            },
            title: const Text("My Bookings"),
          ),

          const Divider(
            color: Colors.black,
          ),
          ListTile(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const DonationPage()));
            },
            title: const Text("Donate Dog"),
          ),

          const Divider(
            color: Colors.black,
          ),
          ListTile(
            onTap: () {
             Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => OrderScreens(
          totalprice: appProvider.totalPrice(),
          itemList: cartItems,
        ),
      ),
    );

            },
            title: const Text("Your Orders"),
          ),

          const Divider(
            color: Colors.black,
          ),
          ListTile(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const FavouriteScreen()));
            },
            title: const Text("Your Favourites"),
          ),

          const Divider(
            color: Colors.black,
          ),
          ListTile(
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const FAQ()));
            },
            title: const Text("FAQ"),
          ),

          const Divider(
            color: Colors.black,
          ),
          ListTile(
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const ContactPage()));
            },
            title: const Text("Contact"),
          ),
          const Divider(
            color: Colors.black,
          ),
          ListTile(
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const QueriesPage()));
            },
            title: const Text("Queries"),
          ),
          const Divider(
            color: Colors.black,
          ),
          ListTile(
            onTap: () {
              exit(0);
            },
            title: const Text("Logout"),
          ),
          const Divider(
            color: Colors.black,
          )
        ],
      ),
    );
  }
}
