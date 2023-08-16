import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:petshop/firebase_helper/prodctmodel.dart';
import 'package:petshop/model/constants.dart';
import 'package:petshop/model/provider.dart';
import 'package:provider/provider.dart';

class SingleCartItem extends StatefulWidget {
  final ProductModel singleProduct;

  const SingleCartItem({Key? key, required this.singleProduct}) : super(key: key);

  @override
  State<SingleCartItem> createState() => _SingleCartItemState();
}

class _SingleCartItemState extends State<SingleCartItem> {
  int qty = 1;

  @override
  void initState() {
    qty = widget.singleProduct.qty ?? 1;
    setState(() {
      super.initState();
    });
  }

  @override
  Widget build(BuildContext context) {
    AppProvider appProvider = Provider.of<AppProvider>(context);

    return Container(
      margin: const EdgeInsets.all(5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.redAccent, width: 1),
      ),
      child: Row(
        children: [
          Expanded(
            child: SizedBox(
              height: 200,
              child: Image.network(widget.singleProduct.image),
            ),
          ),
          Expanded(
            flex: 2,
            child: SizedBox(
              height: 180,
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Stack(
                  alignment: Alignment.bottomRight,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.singleProduct.name,
                              style: const TextStyle(fontSize: 20),
                            ),
                            Row(
                              children: [
                                CupertinoButton(
                                  onPressed: () {
                                    if (qty > 1) {
                                      setState(() {
                                        qty--;
                                      });
                                      appProvider.updateQty(
                                          widget.singleProduct, qty);
                                    }
                                  },
                                  padding: EdgeInsets.zero,
                                  child: const CircleAvatar(
                                    maxRadius: 13,
                                    child: Icon(Icons.remove),
                                  ),
                                ),
                                Text(
                                  qty.toString(),
                                  style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                CupertinoButton(
                                   onPressed: () {
                      if (qty < widget.singleProduct.stock) {
                        setState(() {
                          qty++;
                        });
                      } else {
                        print("stock limit has been reached");
                        // You can show a message here indicating that the stock limit has been reached.
                      }
                    },
                                  // onPressed: () {
                                  //   setState(() {
                                  //     qty++;
                                  //   });
                                  //   appProvider.updateQty(
                                  //       widget.singleProduct, qty);
                                  // },
                                  child: const CircleAvatar(
                                    maxRadius: 13,
                                    child: Icon(Icons.add),
                                  ),
                                ),
                              ],
                            ),
                            CupertinoButton(
                                padding: EdgeInsets.zero,
                                onPressed: () {
                                  if (!appProvider.getFavouriteProductList
                                      .contains(widget.singleProduct)) {
                                    appProvider
                                        .addFavouriteProduct(widget.singleProduct);
                                    showMessage("Added to wishlist");
                                  } else {
                                    appProvider
                                        .removeFavouriteProduct(widget.singleProduct);
                                    showMessage("Removed from wishlist");
                                  }
                                },
                                child: Text(
                                  appProvider.getFavouriteProductList
                                          .contains(widget.singleProduct)
                                      ? "Remove from Wishlist"
                                      : "Add to Wishlist",
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold, fontSize: 15),
                                )),
                            Text(
                              "₹${(widget.singleProduct.price * qty).toString()}",
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 15),
                            ),
                          ],
                        ),
                        
                      ],
                    ),

                     CupertinoButton(
                          onPressed: () {
                            appProvider.removeCartProduct(widget.singleProduct);
                            showMessage("Removed from Cart");
                          },
                          child: const CircleAvatar(
                            child: Icon(Icons.delete),
                          ),
                        ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
