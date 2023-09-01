import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';


class ForgotPassword extends StatefulWidget {

  ForgotPassword({Key? key}) : super(key: key);

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();


}

class _ForgotPasswordState extends State<ForgotPassword> {
  final emailController=TextEditingController();
  @override
  void dispoe(){
    emailController.dispose();
    //super.dispose();
  }



  Future passwordReset() async{
    try{
      await FirebaseAuth.instance.sendPasswordResetEmail(
        email: emailController.text.trim(),

      );

      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              content: Text('Password reset link sent, check your Email'),
            );

          });

    } on FirebaseAuthException catch(e){
      //print(e);
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              content: Text(e.message.toString()),
            );

          });


    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey,
        //elevation: 10,
        title: Text('Password Reset'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Enter your Email we will send you a password reset link',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 20,
              fontWeight: FontWeight.bold,
              fontStyle: FontStyle.italic),),
            SizedBox(height: 50,),
            TextField(
              controller: emailController,
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
                suffixIcon: const Icon(Icons.mail),
              ),
              obscureText: false,),
            SizedBox(height: 20,),

            Container(
              height: 60,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.grey
              ),
              child: MaterialButton(
                onPressed: passwordReset,
                child:Text('Reset Password',
                  style: TextStyle(
                      color: Colors.white
                  ),
                ),
                color: Colors.deepPurple,
                splashColor:Colors.yellow,
              ),
            ),

          ],
        ),
      ),
    );
  }

}


