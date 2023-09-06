import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../popular product details/popular_product_detail.dart';



class PopularProductListScreen extends StatefulWidget {
  const PopularProductListScreen({super.key});

  @override
  State<PopularProductListScreen> createState() => _PopularProductListScreenState();
}

class _PopularProductListScreenState extends State<PopularProductListScreen> {


  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: FirebaseFirestore.instance.collection('products').snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          var products = snapshot.data!.docs;

          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5.0),
            child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, // Two columns
                mainAxisSpacing: 10.0, // Spacing between rows
                crossAxisSpacing: 10.0, // Spacing between columns
                childAspectRatio: 1.0, // Square aspect ratio
              ),
              itemCount: products.length,
              itemBuilder: (context, index) {
                var productName = products[index]['name'];
                var productImageURL = products[index]['imageURL'];
                var productPrice = products[index]['price'];
                var productQuantity = products[index]['quantity'];
                var productDtails= products[index]['details'];
                var productCategory=products[index]['category'];


                return GestureDetector(
                  onTap:(){
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => ProductDetailsScreen(
                          productName: productName,
                          productImageURL: productImageURL,
                          productPrice: productPrice,
                          productQuantity: productQuantity,
                          productDetails: productDtails,
                          productCategory:productCategory,
                        ),
                      ),
                    );
                  },
                  child: Card(
                    color: Colors.lightGreen.shade100,

                    elevation: 3,
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          Image.network(
                            productImageURL,
                            width: 80,
                            height: 80,
                            fit: BoxFit.cover,
                          ),
                          ListTile(
                            title: Text(productName),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Text('Price:'),
                                    Text('Ugx${productPrice}',style: TextStyle(
                                        fontSize: 13,
                                        fontWeight: FontWeight.bold
                                    ),),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                                  children: [
                                    Text('Quantity: $productQuantity'),
                                    Icon(Icons.shopping_cart,
                                      color: Colors.green,)
                                  ],
                                ), // Changed to quantity
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          );
        },

    );
  }
}
