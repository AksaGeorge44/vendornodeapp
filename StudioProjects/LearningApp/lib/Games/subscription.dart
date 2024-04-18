import 'package:flutter/material.dart';

class SubscriptionDemoPage extends StatelessWidget {
  const SubscriptionDemoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Subscription'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Choose a Subscription Plan',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold,color: Colors.blue),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    SubscriptionPlanCard(
                      duration: '30 Days',
                      price: '₹499',
                      details: 'Unlock all levels and access exclusive features for 30 days.',
                      onPressed: () {
                      },
                    ),
                    const SizedBox(height: 20),
                    SubscriptionPlanCard(
                      duration: '60 Days',
                      price: '₹899',
                      details: 'Unlock all levels and access exclusive features for 60 days.',
                      onPressed: () {
                      },
                    ),
                    SubscriptionPlanCard(
                        duration: '90 Days',
                        price: '₹1299',
                        details: 'Unlock all levels and access exclusive features for 90 days',
                        onPressed: (){

                        })
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SubscriptionPlanCard extends StatelessWidget {
  final String duration;
  final String price;
  final String details;
  final VoidCallback onPressed;

  const SubscriptionPlanCard({
    required this.duration,
    required this.price,
    required this.details,
    required this.onPressed,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Subscription for $duration',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Text(
              'Price: $price',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 10),
            Text(
              'Details:',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Text(
              details,
              style: TextStyle(fontSize: 14),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: onPressed,
              child: const Text('Subscribe Now'),
            ),
          ],
        ),
      ),
    );
  }
}
