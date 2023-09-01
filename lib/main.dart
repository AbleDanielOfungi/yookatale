import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:yookatale/auth/sign_in.dart';
import 'package:yookatale/screens/onboarding.dart';
import 'dart:io';

import 'package:yookatale/screens/product_list.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Yookatale',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: OnboardingScreen(),
    );
  }
}

class ImageUploadScreen extends StatefulWidget {
  @override
  _ImageUploadScreenState createState() => _ImageUploadScreenState();
}

class _ImageUploadScreenState extends State<ImageUploadScreen> {
  final _picker = ImagePicker();
  XFile? _image;
  String _selectedCategory = 'Roughage';
  String _productName = '';
  double _productPrice = 0.0;
  String _productDetails = '';
  int _productRating = 0;
  final currentUser=FirebaseAuth.instance.currentUser!;
  final _formkey = GlobalKey<FormState>();

  Future<void> pickImage() async {
    _image = await _picker.pickImage(source: ImageSource.gallery);
    setState(() {});
  }

  Future<void> uploadImage() async {
    if (_image != null) {
      Reference storageRef =
      FirebaseStorage.instance.ref().child('$_selectedCategory/${DateTime.now()}.png');
      UploadTask uploadTask = storageRef.putFile(File(_image!.path));

      await uploadTask.whenComplete(() async {
        // Getting the download URL for the uploaded image
        String imageURL = await storageRef.getDownloadURL();

        // Creating a new document in Firestore
        FirebaseFirestore.instance.collection('products').add({
          'name': _productName,
          'price': _productPrice,
          'details': _productDetails,
          'rating': _productRating,
          'imageURL': imageURL,
          'category': _selectedCategory,
        });

        print('Image uploaded with details');


        showDialog(
            context: context,
            barrierDismissible: false,
            builder: (context){
              return AlertDialog(

                content: Text('Image uploaded with details',
                  style: TextStyle(
                    color: Colors.grey,
                  ),),
                actions: [
                  //okay button
                  IconButton(onPressed: (){

                    //pop once to remove dialog box
                    Navigator.pop(context);


                  },
                      icon: Icon(Icons.done))
                ],
              );

            });


      });
    }
  }

  Map<String, String> categoryImages = {
    'Roughage': 'assets/roughages.jpg',
    'Fruits': 'assets/fruit.jpg',
    'Root Tubers': 'assets/tubers.jpg',
    'Vegetables': 'assets/greens.jpg',
    'Grains and Flour': 'assets/grain.jpg',
    'Meats': 'assets/meat.jpg',
    'Fats and Oils': 'assets/oil.jpg',
    'Herbs and Spices': 'assets/herbs.jpg',
    'Juice and Meals': 'assets/meals.jpg'
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Column(
          children: [
            Text('Admin Product Upload'),
            Text("Email: ${currentUser.email!}",
              style: TextStyle(
                color: Colors.grey,
                fontSize: 16,
              ),),
          ],
        ),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Form(
              key: _formkey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  _image != null
                      ? Image.file(
                    File(_image!.path),
                    height: 150,
                  )
                      : Container(),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: pickImage,
                    child: Text('Pick Image'),
                  ),
                  SizedBox(height: 10),
                  Text('Product Categories'),
                  SizedBox(height: 10),
                  DropdownButton<String>(
                    value: _selectedCategory,
                    onChanged: (String? newValue) {
                      setState(() {
                        _selectedCategory = newValue!;
                      });
                    },
                    items: categoryImages.keys
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Row(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(12),
                              child: Image.asset(
                                categoryImages[value]!,
                                height: 24,
                                width: 24,
                                fit: BoxFit.cover,
                              ),
                            ),
                            SizedBox(width: 10),
                            Text(value),
                          ],
                        ),
                      );
                    }).toList(),
                  ),
                  SizedBox(height: 10),
                  TextField(
                    decoration: InputDecoration(labelText: 'Product Name'),
                    onChanged: (value) {
                      setState(() {
                        _productName = value;
                      });
                    },
                  ),
                  TextField(
                    decoration: InputDecoration(labelText: 'Product Price'),
                    keyboardType: TextInputType.number,
                    onChanged: (value) {
                      setState(() {
                        _productPrice = double.tryParse(value) ?? 0.0;
                      });
                    },
                  ),
                  TextField(
                    decoration: InputDecoration(labelText: 'Product Details'),
                    onChanged: (value) {
                      setState(() {
                        _productDetails = value;
                      });
                    },
                  ),
                  TextField(
                    decoration: InputDecoration(labelText: 'Product Rating'),
                    keyboardType: TextInputType.number,
                    onChanged: (value) {
                      setState(() {
                        _productRating = int.tryParse(value) ?? 0;
                      });
                    },
                  ),
                  SizedBox(height: 10),
                  _image != null
                      ? Column(
                    children: [
                      Text(
                        'Selected Image:',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 10),
                      Image.file(
                        File(_image!.path),
                        height: 150,
                      ),
                    ],
                  )
                      : Container(),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: uploadImage,
                    child: Text('Upload Image with Details'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      floatingActionButton: Container(
        height: 60,
        width: 150,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.blue
        ),
        child: FloatingActionButton(
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (builder) {
              return ProductListScreen();
            }));
          },
          child: Center(
            child: Text('View Products',
            style: TextStyle(fontSize: 15
            ),),
          ),
        ),
      ),
    );
  }
}
