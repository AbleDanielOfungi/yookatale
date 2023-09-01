
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../main.dart';
import '../screens/product_list.dart';
import 'forgot_password.dart';
import 'sign_up.dart';



class SignIn extends StatefulWidget {
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  bool _isObscure3 = true;
  bool visible = false;
  final _formkey = GlobalKey<FormState>();
  final TextEditingController emailController = new TextEditingController();
  final TextEditingController passwordController = new TextEditingController();

  final _auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            SingleChildScrollView(
              child: Container(

                decoration: BoxDecoration(
                  color: Colors.grey[300],


                ),
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                child: Center(
                  child: SingleChildScrollView(
                    child: Container(
                      margin: EdgeInsets.all(12),
                      child: Form(
                        key: _formkey,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(
                              height: 30,
                            ),
                            Image.asset('assets/yoo.png',
                              height: 80,),
                            SizedBox(
                              height: 30,
                            ),

                            const Text('Welcome Back',
                              style: TextStyle(
                                fontSize: 25,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const Text('Sign In with your email or password'),
                            const Text('or continue with social media'),



                            SizedBox(
                              height: 20,
                            ),
                            TextFormField(
                              controller: emailController,
                              //new decoration1 from mytextfield
                              decoration: InputDecoration(
                                floatingLabelBehavior: FloatingLabelBehavior.always,
                                contentPadding: const EdgeInsets.symmetric(
                                    horizontal: 42,
                                    vertical: 20
                                ),
                                enabledBorder: OutlineInputBorder(
                                  gapPadding: 10,
                                  borderRadius: BorderRadius.circular(20),
                                  borderSide:const BorderSide(
                                      color: Colors.black
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30),
                                  borderSide:const BorderSide(
                                      color: Colors.black
                                  ),
                                ),
                                labelText: 'Email',
                                hintText: 'Enter Email',
                                suffixIcon: const Icon(Icons.mail_lock_outlined),
                              ),
                              validator: (value) {
                                if (value!.length == 0) {
                                  return "Email cannot be empty";
                                }
                                if (!RegExp(
                                    "^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]")
                                    .hasMatch(value)) {
                                  return ("Please enter a valid email");
                                } else {
                                  return null;
                                }
                              },
                              onSaved: (value) {
                                emailController.text = value!;
                              },
                              keyboardType: TextInputType.emailAddress,
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            TextFormField(
                              controller: passwordController,
                              obscureText: _isObscure3,
                              decoration: InputDecoration(
                                floatingLabelBehavior: FloatingLabelBehavior.always,
                                contentPadding: const EdgeInsets.symmetric(
                                    horizontal: 42,
                                    vertical: 20
                                ),
                                enabledBorder: OutlineInputBorder(
                                  gapPadding: 10,
                                  borderRadius: BorderRadius.circular(20),
                                  borderSide:const BorderSide(
                                      color: Colors.black
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30),
                                  borderSide:const BorderSide(
                                      color: Colors.black
                                  ),
                                ),
                                labelText: 'Password',
                                hintText: 'Enter Password',
                                suffixIcon: IconButton(
                                    icon: Icon(_isObscure3
                                        ? Icons.visibility
                                        : Icons.visibility_off),
                                    onPressed: () {
                                      setState(() {
                                        _isObscure3 = !_isObscure3;
                                      });
                                    }),
                              ),

                              validator: (value) {
                                RegExp regex = new RegExp(r'^.{6,}$');
                                if (value!.isEmpty) {
                                  return "Password cannot be empty";
                                }
                                if (!regex.hasMatch(value)) {
                                  return ("please enter valid password min. 6 character");
                                } else {
                                  return null;
                                }
                              },
                              onSaved: (value) {
                                passwordController.text = value!;
                              },
                              keyboardType: TextInputType.emailAddress,
                            ),

                            SizedBox(
                              height: 5,
                            ),

                            //forgot password
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 25),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  GestureDetector(
                                      onTap:(){
                                        Navigator.push(context, MaterialPageRoute(builder: (context){
                                          return ForgotPassword();

                                        }));
                                      },
                                      child: Text('Forgot Password?',style: TextStyle(color: Colors.grey))),
                                ],
                              ),
                            ),


                            SizedBox(
                              height: 15,
                            ),


                            Container(
                              height: 60,
                              width: double.infinity,
                              child: MaterialButton(
                                shape: RoundedRectangleBorder(
                                    borderRadius:
                                    BorderRadius.all(Radius.circular(12.0))),
                                elevation: 5.0,
                                height: 40,
                                onPressed: () {
                                  setState(() {
                                    visible = true;
                                  });
                                  signIn(
                                      emailController.text, passwordController.text);
                                },
                                child: Text(
                                  "Login",
                                  style: TextStyle(
                                    fontSize: 20,
                                  ),
                                ),
                                color: Colors.white,
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Visibility(
                                maintainSize: true,
                                maintainAnimation: true,
                                maintainState: true,
                                visible: visible,
                                child: Container(
                                    child: CircularProgressIndicator(
                                      color: Colors.white,
                                    ))),

                            const SizedBox(
                              height: 30,
                            ),

                            Column(
                              children: [
                                const SizedBox(
                                  height: 20,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    const Text("Don't have an account?,"),
                                    GestureDetector(
                                      onTap: (){
                                        Navigator.push(context, MaterialPageRoute(builder: (context){
                                          return  SignUp();
                                        }));
                                      },
                                      child: const Text("Sign Up",
                                        style: TextStyle(
                                          color: Colors.deepOrange,
                                        ),),
                                    ),
                                  ],
                                )

                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),

          ],
        ),
      ),
    );
  }


  void route() {
    User? user = FirebaseAuth.instance.currentUser;
    var kk = FirebaseFirestore.instance
        .collection('users')
        .doc(user!.uid)
        .get()
        .then((DocumentSnapshot documentSnapshot) {
      if (documentSnapshot.exists) {
        if (documentSnapshot.get('role') == "Buyer") {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => ProductListScreen(),
            ),
          );
        }
        //new
        else if (documentSnapshot.get('role') == "Admin") {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => ImageUploadScreen(),
            ),
          );
        } else {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => ProductListScreen(),
            ),
          );
        }

      }

      else {
        print('Document does not exist on the database');
        //let user know it's successful
        showDialog(
            context: context,
            barrierDismissible: false,
            builder: (context){
              return AlertDialog(

                content: Text('Document does not exist on the database',
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

      }
    });
  }

  //not signing in
  void signIn(String email, String password) async {
    if (_formkey.currentState!.validate()) {
      try {
        UserCredential userCredential =
        await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: email,
          password: password,
        );
        route();
      } on FirebaseAuthException catch (e) {
        if (e.code == 'user-not-found') {
          print('No user found for that email.');
          showDialog(
              context: context,
              barrierDismissible: false,
              builder: (context){
                return AlertDialog(

                  content: Text('No user found for that email.',
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
        } else if (e.code == 'wrong-password') {
          print('Wrong password provided for that user.');
          showDialog(
              context: context,
              barrierDismissible: false,
              builder: (context){
                return AlertDialog(

                  content: Text('Wrong password provided for that user.',
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



        }
      }
    }
  }
}


