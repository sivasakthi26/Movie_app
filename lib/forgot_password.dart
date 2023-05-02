import 'dart:async';
import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'login.dart';
import 'package:get/get.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({Key? key}) : super(key: key);

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  final _emailController = TextEditingController();
  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  Future passwordReset() async {
    try {
      await FirebaseAuth.instance
          .sendPasswordResetEmail(email: _emailController.text.trim());
      showDialog(
          context: context,
          builder: (context) {
            return BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 8.0, sigmaY: 8.0),
              child: AlertDialog(
                content: Text('password reset link send ! check your email'),
                actions: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(10, 30, 10, 0),
                    child: SizedBox(
                      // width: 100,
                      height: 50,
                      child: ElevatedButton(
                        child: const Text("Log In",
                            style: TextStyle(
                                fontSize: 18, fontFamily: 'Gilroy Medium')),
                        style: ElevatedButton.styleFrom(
                            shape: const StadiumBorder(),
                            primary: Colors.black),
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => SignInScreen()));
                        },
                      ),
                    ),
                  ),
                ],
              ),
            );
          });
    } on FirebaseAuthException catch (e) {
      print(e);
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
        body: SingleChildScrollView(
      child: SafeArea(
        child: Center(
          child: Container(
            padding: EdgeInsets.only(top: 250),
            child: Column(
              children: [
                const Text(
                  'Email id Please',
                  style: TextStyle(fontFamily: 'Gilroy Medium', fontSize: 25),
                ),
                SizedBox(height: 20,),
                Padding(
                  padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 80,
                        child: TextFormField(
                          textInputAction: TextInputAction.next,
                          textAlignVertical: TextAlignVertical.center,
                          decoration: InputDecoration(
                            isDense: true,
                            errorStyle: const TextStyle(
                                fontFamily: 'Gilroy SemiBold',
                                fontSize: 16,
                                color: Color(0xffB3B3B3)),
                            hintText: 'Email id',
                            enabledBorder: const UnderlineInputBorder(

                              // borderSide: BorderSide(color: textBorderColor),
                                borderSide: BorderSide(
                                  color: Colors.blue,
                                    width: 1)),
                          ),
                          controller: _emailController,
                        ),
                      ),
                      SizedBox(
                        height: 60,
                        width: 200,
                        child: ElevatedButton(
                          child: const Text(
                            "Send",
                            style: TextStyle(
                                fontSize: 18, fontFamily: 'Gilroy Medium'),
                          ),
                          style: ElevatedButton.styleFrom(
                              shape: const StadiumBorder(),
                              primary: Colors.grey),
                          // onPressed: (){
                          //   Get.to(()=>OtpNumberScreen());
                          // },
                          onPressed: passwordReset,
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),

          ),

        ),
      ),
    ));
  }
}
