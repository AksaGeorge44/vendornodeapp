import 'package:flutter/material.dart';
import 'package:petshop/screens/appbar/Notificationpage.dart';
import 'package:petshop/cart/singlefavitem.dart';
import 'package:petshop/model/provider.dart';
import 'package:provider/provider.dart';

class FavouriteScreen extends StatelessWidget {
  const FavouriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    AppProvider appProvider = Provider.of<AppProvider>(context);
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
        title: const Text(
          "Favourites",
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: appProvider.getFavouriteProductList.isEmpty
          ? const Center(
              child: Text("Empty"),
            )
          : Padding(
              padding: const EdgeInsets.all(15),
              child: ListView.builder(
                  itemCount: appProvider.getFavouriteProductList.length,
                  padding: const EdgeInsets.all(12),
                  itemBuilder: (ctx, index) {
                    return SingleFavouriteItem(
                      singleProduct: appProvider.getFavouriteProductList[index],
                    );
                  }),
            ),
    );
  }
}
