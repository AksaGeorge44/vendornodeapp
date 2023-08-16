import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:petshop/firebase_helper/prodctmodel.dart';
import 'package:petshop/model/constants.dart';
import 'package:petshop/model/provider.dart';
import 'package:provider/provider.dart';

class SingleFavouriteItem extends StatefulWidget {
  final ProductModel singleProduct;
  const SingleFavouriteItem({super.key,required this.singleProduct});

  @override
  State<SingleFavouriteItem> createState() => _SingleCartItemState();
}

class _SingleCartItemState extends State<SingleFavouriteItem> {


  @override
  Widget build(BuildContext context) {
    return  SingleChildScrollView(
      child: Container(
        margin: const EdgeInsets.all(5),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.black,width: 2.5),
        ),
        child: Row(
          children: [
            Expanded(
              child: Container(
                
                color: Colors.black.withOpacity(0.2),
                child: Image.network(widget.singleProduct.image,
                
               // height: 300,
                
                width: 200,),
              ),
            ),
            const SizedBox(width: 10,),
            Expanded(
              flex: 2,
              child: SizedBox(
                height: 150,
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Stack(
                    alignment: Alignment.bottomRight,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 10),
                                child: Text(
                                  widget.singleProduct.name,
                                  style: const TextStyle(
                                    fontSize: 18,fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),

                          CupertinoButton(
                            padding: const EdgeInsets.only(left: 10),
                            onPressed: (){

                              AppProvider appProvider =Provider.of<AppProvider>(context,listen: false);
                              appProvider.removeFavouriteProduct(widget.singleProduct);


                              showMessage( "Removed from Wishlist");
                            },
                            child: const Text("Remove from Wishlist",
                              style: TextStyle(
                                color: Colors.blue,
                                fontSize: 15,fontWeight: FontWeight.bold,
                              ),),
                          ),

                           Row(crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const SizedBox(width: 15,),

                              Padding(
                                padding:  const EdgeInsets.only(right: 34),
                                child: Text("M.R.P:  ₹${widget.singleProduct.price.toString()}",
                                  style: const TextStyle(fontSize: 18,fontWeight: FontWeight.bold,),),
                              ),
                            ],
                          ),
                          // color: Colors.red.withOpacity(0.5),
                        ],
                      ),
                    ],
                  ),

                ),
              ),

            ),
          ],
        ),

      ),
    );
  }
}
