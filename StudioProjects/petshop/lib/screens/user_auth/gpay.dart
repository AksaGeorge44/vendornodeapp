import 'package:flutter/material.dart';
import 'package:mad_pay/mad_pay.dart';
import 'package:petshop/cart/billing.dart';
import 'package:petshop/model/provider.dart';
import 'package:provider/provider.dart';

class GPay extends StatefulWidget {
  @override
  _GPayState createState() => _GPayState();
}

class _GPayState extends State<GPay> {
  String creditCardNumber = '';
  String expiryDate = '';
  String cvv = '';
  MadPay pay = MadPay(); // Define the MadPay instance here
String result="result here";
  // Define the GoogleParameters here
  GoogleParameters googleParameters = GoogleParameters(
    gatewayName: 'example',
    gatewayMerchantId: 'example_id',
    merchantId: 'TEST',
    merchantName: 'Test',
    cardParameters: CardParameters(
      billingAddressRequired: true,
      billingAddressParameters: BillingAddressParameters(
        billingFormat: BillingFormat.full,
        phoneNumberRequired: true,
      ),
    ),
    transactionInfo: TransactionInfo(
      totalPriceLabel: 'Test',
      checkoutOption: CheckoutOption.completeImmediatePurchase,
    ),
    shippingAddressRequired: true,
    shippingAddressParameters: ShippingAddressParameters(
      phoneNumberRequired: true,
    ),
  );

  List<PaymentItem> items = <PaymentItem>[
    PaymentItem(name: 'Product 1', price: 10.0), // Example item 1
    PaymentItem(name: 'Product 2', price: 15.0), // Example item 2
    // Add more items as needed
  ];

  @override
  Widget build(BuildContext context) {
    AppProvider appProvider = Provider.of<AppProvider>(context);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          title: const Text("Payment"),
        ),
        body: Center(
          child: Column(
            children: <Widget>[
              const SizedBox(height: 50),
              const Text(
                "Please select an option",
                style: TextStyle(fontSize: 20),
              ),
              const SizedBox(height: 20),
              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => BillingPage(
                        totalprice: appProvider.totalPrice(),
                        paymentMethod: 'COD',
                      ),
                    ),
                  );
                  // Implement Cash on Delivery logic here
                },
                child: const Text(
                  'Cash on Delivery',
                  style: TextStyle(fontSize: 20),
                ),
              ),
              TextButton(
                onPressed: () {
                  // Display Credit Card Dialog
                  _showCreditCardDialog(context);
                },
                child: const Text(
                  'Credit Card',
                  style: TextStyle(fontSize: 20),
                ),
              ),
              TextButton(
                onPressed: () async {
                  try {
                    final PaymentResponse? req = await pay.processingPayment(
                      PaymentRequest.google(
                        paymentNetworks: <PaymentNetwork>[
                          PaymentNetwork.amex,
                          PaymentNetwork.discover,
                          PaymentNetwork.interac,
                          PaymentNetwork.jcb,
                          PaymentNetwork.mastercard,
                          PaymentNetwork.visa,
                          PaymentNetwork.mir,
                        ],
                        google: googleParameters,
                        currencyCode: 'USD',
                        countryCode: 'US',
                        paymentItems: items,
                      ),
                    );
                    setState(() {
                      result = 'GooglePayButton, Try to pay:\n${req?.token}';
                    });
                  } catch (e) {
                    setState(() {
                      result = 'GooglePayButton, Error:\n$e';
                    });
                  }
                },
                child: const Text('Google Pay', style: TextStyle(fontSize: 20),),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showCreditCardDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          child: Container(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextFormField(
                  decoration: const InputDecoration(labelText: 'Card Number'),
                  onChanged: (value) {
                    setState(() {
                      creditCardNumber = value;
                    });
                  },
                ),
                TextFormField(
                  decoration: const InputDecoration(labelText: 'Expiry Date'),
                  onChanged: (value) {
                    setState(() {
                      expiryDate = value;
                    });
                  },
                ),
                TextFormField(
                  decoration: const InputDecoration(labelText: 'CVV'),
                  onChanged: (value) {
                    setState(() {
                      cvv = value;
                    });
                  },
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    // Process Credit Card Payment Logic
                    // You can add validation and payment processing logic here
                    // Once payment is successful, you can close the dialog
                    Navigator.pop(context);
                  },
                  child: const Text('Pay'),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

void main() {
  runApp(MaterialApp(home: GPay()));
}
