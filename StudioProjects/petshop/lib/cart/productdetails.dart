import 'package:badges/badges.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:petshop/firebase_helper/prodctmodel.dart';
import 'package:petshop/model/constants.dart';
import 'package:petshop/cart/cartpage.dart';
import 'package:petshop/model/provider.dart';
import 'package:petshop/model/routes.dart';
import 'package:petshop/screens/user_auth/gpay.dart';
import 'package:provider/provider.dart';
import 'package:badges/badges.dart' as badges; // Alias the badges package

class ProductDetails extends StatefulWidget {
  final ProductModel singleProduct;
  const ProductDetails({super.key, required this.singleProduct});

  @override
  State<ProductDetails> createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  int qty = 1;
  @override
  Widget build(BuildContext context) {
    AppProvider appProvider = Provider.of<AppProvider>(context);

    return Scaffold(
      appBar: AppBar(
        actions: [
          Consumer<AppProvider>(
            builder: (context, appProvider, _) => badges.Badge(
              position: BadgePosition.topEnd(top: 0, end: 19),
              badgeContent: Text(
                appProvider.getCartProductList.length.toString(),
                style: const TextStyle(color: Colors.white),
              ),
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: IconButton(
                  onPressed: () {
                    Routes.instance.push(
                      widget: const CartScreen(),
                      context: context,
                      arguments: appProvider.totalPrice(),
                    );
                  },
                  icon: const Icon(Icons.shopping_cart),
                ),
              ),
            ),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Image.network(
                    widget.singleProduct.image,
                    height: 250,
                    width: 250,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 65,
                    ),
                    child: IconButton(
                      onPressed: () {
                        setState(() {
                          widget.singleProduct.isFavourite =
                              !widget.singleProduct.isFavourite;
                        });
                        if (widget.singleProduct.isFavourite) {
                          appProvider.addFavouriteProduct(widget.singleProduct);
                        } else {
                          appProvider
                              .removeFavouriteProduct(widget.singleProduct);
                        }
                      },
                      icon: Icon(appProvider.getFavouriteProductList
                              .contains(widget.singleProduct)
                          ? Icons.favorite
                          : Icons.favorite_border),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      widget.singleProduct.name,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10),
                child: Text(
                  widget.singleProduct.description,
                  style: const TextStyle(fontSize: 15),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              Text(
                "M.R.P: ₹${widget.singleProduct.price}",
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black, // You can customize the color
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              Text(
                "Stock: ${widget.singleProduct.stock} available", // Display stock information
                style: const TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                  color: Colors.black, // You can customize the color
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              Row(
                children: [
                  CupertinoButton(
                    onPressed: () {
                      if (qty >= 1) {
                        setState(() {
                          qty--;
                        });
                      }
                    },
                    padding: EdgeInsets.zero,
                    child: const CircleAvatar(
                      child: Icon(Icons.remove),
                    ),
                  ),
                  const SizedBox(
                    width: 12.0,
                  ),
                  Text(
                    qty.toString(),
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(width: 12.0),
                  CupertinoButton(
                    onPressed: () {
                      if (qty < widget.singleProduct.stock) {
                        setState(() {
                          qty++;
                        });
                      } else {
                                                if (kDebugMode) {
                                                  print("stock limit has been reached");
                                                }

                        // You can show a message here indicating that the stock limit has been reached.
                      }
                    },
                    child: const CircleAvatar(
                      child: Icon(Icons.add),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  OutlinedButton(
                    onPressed: () {
                      // AppProvider appProvider=Provider.of<AppProvider>(context,listen: false);
                      ProductModel productModel =
                          widget.singleProduct.copyWith(qty: qty);
                      appProvider.addCartProduct(productModel);
                      showMessage("Added to Cart");
                    },
                    child: const Text("ADD TO CART"),
                  ),
                  const SizedBox(
                    width: 24,
                  ),
                  SizedBox(
                    height: 38,
                    width: 140,
                    child: ElevatedButton(
                        onPressed: () {
                          // ProductModel productModel=
                          // widget.singleProduct.copyWith(qty: qty);
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>   GPay(),
                            ),
                          );
                        },
                        child: const Text("BUY")),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
