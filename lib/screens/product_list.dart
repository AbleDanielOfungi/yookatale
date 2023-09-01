import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ProductListScreen extends StatefulWidget {
  const ProductListScreen({super.key});

  @override
  State<ProductListScreen> createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {
  final currentUser=FirebaseAuth.instance.currentUser!;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Column(
          children: [
            Text('Product List'),
            Text("Email: ${currentUser.email!}",
            style: TextStyle(
              color: Colors.grey,
              fontSize: 16,
            ),),
          ],
        ),
        centerTitle: true,
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('products').snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          var products = snapshot.data!.docs;

          List<Widget> productCards = [];

          for (var product in products) {
            var productName = product['name'];
            var productImageURL = product['imageURL'];
            var productPrice = product['price'];
            var productRating = product['rating'];

            // Create a product card widget for each product
            var productCard = Card(
              elevation: 3,
              margin: EdgeInsets.all(10),
              child: ListTile(
                leading: Image.network(
                  productImageURL,
                  width: 80,
                  height: 80,
                  fit: BoxFit.cover,
                ),
                title: Text(productName),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Price:Ugx${productPrice.toStringAsFixed(2)}'), // Format price as needed
                    Row(
                      children: [
                        Text('Rating: ${productRating.toString()}'),
                        Icon(Icons.star_border_purple500,
                          color: Colors.orange,
                        )
                      ],
                    ), // Display rating
                  ],
                ),
                // Add more details here if needed
              ),
            );

            productCards.add(productCard);
          }

          return ListView(
            children: productCards,
          );
        },
      ),
    );
  }
}
