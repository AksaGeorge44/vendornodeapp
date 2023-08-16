import 'package:flutter/material.dart';

class CartItemCheckout extends StatefulWidget {
   
  const CartItemCheckout({
    super.key,
  });

  @override
  State<CartItemCheckout> createState() => _CartItemCheckoutState();
}

class _CartItemCheckoutState extends State<CartItemCheckout> {

  int groupValue = 1;

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Text(
          "Item Checkout",
          style: TextStyle(
            color: Colors.black,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 100),
        child: Column(
          //mainAxisAlignment: MainAxisAlignment.center,
          //crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 30,),
            const Text("Select Payment Option",style: TextStyle(
              color: Color.fromARGB(255, 78, 120, 141),
                    fontSize: 20,
                    fontWeight: FontWeight.bold
                  ),),
            const SizedBox(height: 60,),
            Card(
              child: TextButton(
                  onPressed: () {
                //   Navigator.push(
                //   context,
                //   MaterialPageRoute(
                //     builder: (context) =>  BillingPage(
                    
                //     ),
                //   ),
                // );

                  },
                  child: const Text("Cash on Delivery",style: TextStyle(
                    color: Colors.lightBlue,
                    fontSize: 22,
                    fontWeight: FontWeight.bold
                  ),
                  
                  )
                  
                  ),
            ),
            const SizedBox(
              height: 10,
            ),
            Card(
              child: TextButton(onPressed: () {
                  
                  
              }, child: const Text("Pay Online",
              style: TextStyle(
                    fontSize: 23,
                    fontWeight: FontWeight.bold
                  ),)
              ),
            )
            
          ],
        ),
      ),
    );
  }
}

