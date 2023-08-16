import 'package:flutter/material.dart';
import 'package:petshop/firebase_helper/prodctmodel.dart';

class SearchResultsPage extends StatelessWidget {
  final List<ProductModel> searchList;

  SearchResultsPage({required this.searchList});

  @override
  Widget build(BuildContext context) {
    // Build the UI to display the search results
    return Scaffold(
      appBar: AppBar(title: const Text("Search Results")),
      body: ListView.builder(
        itemCount: searchList.length,
        itemBuilder: (BuildContext context, int index) {
          final product = searchList[index];
          return ListTile(
            title: Text(product.name),
            // Other widget elements for displaying product details
          );
        },
      ),
    );
  }
}
