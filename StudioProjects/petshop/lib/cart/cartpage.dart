import 'package:flutter/material.dart';
import 'package:petshop/model/provider.dart';
import 'package:petshop/cart/singlecartitem.dart';
import 'package:petshop/screens/user_auth/gpay.dart';
import 'package:provider/provider.dart';

class CartScreen extends StatefulWidget {


  const CartScreen({super.key,});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
 


  @override
  Widget build(BuildContext context) {

    AppProvider appProvider=Provider.of<AppProvider>(context);

     
    return Scaffold(
      bottomNavigationBar: SizedBox(
        height: 150,
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            children: [
              const Divider(color: Colors.black,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text("TotalPrice",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
                  Text(
                    "₹${appProvider.totalPrice().toString()}",
                    style: const TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
       ElevatedButton(
  onPressed: () {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => GPay(),
      ),
    );
  },
  child: const Text("BUY"),
),



            ],
          ),
        ),
      ),

      appBar: AppBar(
      title: const Text("Cart"),
      ),

      body: appProvider.getCartProductList.isEmpty?
          const Center(
            child: Text("Empty"),
          ):

      Padding(
        padding: const EdgeInsets.all(20),
        child: ListView.builder(
            itemCount: appProvider.getCartProductList.length,
            itemBuilder: (ctx,index){
              return SingleCartItem(singleProduct: appProvider.getCartProductList[index],);

            }

        ),
      ),
    );
  }
}
