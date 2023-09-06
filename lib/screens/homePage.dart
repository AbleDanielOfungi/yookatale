
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:yookatale/screens/popular%20product/popular%20products/popular_products.dart';
import 'package:yookatale/screens/popular%20product/upload/product_upload.dart';

import 'cartPage.dart';
import 'categories/categories.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String greetings = '';

  greeting(){
    var hour = DateTime.now().hour;
    if (hour < 12) {
      setState(() {
        greetings ='Good Morning';
      });
    } else if ((hour >= 12) && (hour <= 16)) {
      setState(() {
        greetings ='Good Afternoon';
      });
    } else if ((hour > 16) && (hour < 20)) {
      setState(() {
        greetings ='Good Evening';
      });
    } else {
      setState(() {
        greetings = 'Good Evening';
      });
    }
  }


  @override
  void initState() {
    greeting();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {


    final users= FirebaseAuth.instance.currentUser;


    return Scaffold(
      backgroundColor: Colors.grey.shade300,
      appBar: AppBar(
        backgroundColor: Colors.lightGreen,
        leading:Padding(
          padding: const EdgeInsets.all(2.0),
          child: Icon(Icons.menu),
        ) ,
        title:Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(greetings, style: const TextStyle(fontSize: 14, color: Colors.green),),
            const Text("Vincent", style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.green),)
          ],
        ),
        actions: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,

            children: const [
              Icon(Icons.location_pin),
              SizedBox(width: 5,),
              Text('Home', style: TextStyle(color: Colors.green),),
              SizedBox(width: 10,),
              Icon(Icons.shopping_cart),
              SizedBox(width: 10,),
            ],
          )
        ],
        bottom:  PreferredSize(
          preferredSize: const Size.fromHeight(60),
          child:Padding(
            padding: const EdgeInsets.only(left: 10,right: 10),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Row(
                    children: [
                      Expanded(
                        child:InkWell(
                          onTap: () {
                          },
                          child: Container(

                            child:TextField(
                              enabled: false,
                              decoration: InputDecoration(
                                hintText: 'Search category',
                                prefixIcon: const Icon(Icons.search,color:Colors.grey ,),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(color: Colors.grey, width: 1.5),
                                ),
                                contentPadding: EdgeInsets.zero,
                                filled: true,
                                fillColor:Colors.white,
                                suffixIcon: IconButton(
                                    onPressed: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: ((context) => const CartPage())));
                                    },
                                    icon: const Icon(Icons.speaker,color: Colors.grey,)),
                              ),

                            ),
                          ),
                        ),
                      ),


                    ],
                  ),
                ),
                const SizedBox(height: 10,)
              ],
            ),
          ) ,
        ),

      ),

      body: Column(
        children: [
          SizedBox(
            height: 20,
          ),
          Text('Catergories',
          style: TextStyle(
            fontWeight: FontWeight.bold
          ),),
          SizedBox(
            height: 10,
          ),
          Categories(),

          SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Popular Products',style: TextStyle(
                  color: Colors.lightGreen,
                  fontWeight: FontWeight.bold
                ),),
                GestureDetector(
                  onTap: (){

                  },
                  child: Text('View more',
                    style: TextStyle(
                        color: Colors.lightGreen
                          ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Expanded(child: PopularProductListScreen()),
        ],
      ),






    );
  }
}
