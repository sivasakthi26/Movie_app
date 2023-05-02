import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:movie_app/bottom_navigator.dart';

import 'login.dart';

class SignUP extends StatelessWidget {
  final GlobalKey<FormState>_formkey=GlobalKey<FormState>();

  validator(){
    if(_formkey.currentState!=null&&_formkey.currentState!.validate())
    {
      print("validated");

    }

    else
    {
      print("not validated");
    }}
  bool passwordErrorStatus = false;
  bool errorStatus = false;
  bool mobileErrorStatus=false;
  late String _email, _password, _fullName, _mobileNumber;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:Container(
        child: Form(
          key: _formkey,

          child: Column(

            children: [
              SizedBox(height: 20,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text("SIGN UP",
                      style: TextStyle(
                        // color: Color(0xFFFFBD73),
                        fontWeight: FontWeight.bold,
                        fontSize: 40,
                      )),
                ],
              ),
              Padding(padding: EdgeInsets.fromLTRB(20,10,20,0),
                child: TextFormField(
                  onChanged: (value) {
                    _fullName = value;
                  },
                  decoration: InputDecoration(labelText: 'Enter the full name'),
                  validator: (String? value){
                    if(value==null || value.trim().length==0){
                      return "Field is require";
                    }
                    return null;
                  } ,
                ),
              ),
              Padding(padding: EdgeInsets.fromLTRB(20,10,20,0),
                child: TextFormField(
                  onChanged: (value) {
                    _mobileNumber = value;
                  },
                  decoration: InputDecoration(labelText: 'Enter the mobilenumber'),
                  keyboardType: TextInputType.number,

                  validator: (String? value) {
                    if (!RegExp(r'^[0-9]+$').hasMatch(value!)) {
                      mobileErrorStatus = true;
                      return ("Only Numbers are allowed");
                    }
                    if (value!.length < 10) {
                      return ("Please update 10 digit Mobile number");
                    } else {
                      errorStatus = false;
                      return null;
                    }
                  },
                ),),
              Padding(padding: EdgeInsets.fromLTRB(20,10,20,0),
                child: TextFormField(
                  onChanged: (value) {
                    _email = value;
                  },
                  decoration: InputDecoration(labelText: 'Enter the email'),
                  validator: (String? value){
                    if(value==null || value.trim().length==0){
                      return "Field is require";
                    }
                    if(!RegExp(r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.'
                    r'[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$').hasMatch(value)){
                      return "please entervalie meial";
                    }
                  } ,
                ),),
              Padding(padding: EdgeInsets.fromLTRB(20,10,20,0),
                child: TextFormField(
                  keyboardType: TextInputType.number,
                  onChanged: (value) {
                    _password = value;
                  },
                  decoration: InputDecoration(labelText: 'Enter the password'),

                  obscureText: true,
                  validator: (String? value) {
                    if (value!.isEmpty) {
                      passwordErrorStatus = true;
                      return ("Please Enter Your Password");
                    }
                    // reg expression for email validation
                    if (!RegExp(r'^.{7,}$').hasMatch(value)) {
                      passwordErrorStatus = true;
                      return ("Password must be at least 7 character");
                    }
                    passwordErrorStatus = false;
                    return null;
                  },
                  // validator: (String? value){
                  //   if(value==null || value.trim().length==0){
                  //     return "Field is require";
                  //   }
                  //   if(!RegExp("r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}'").hasMatch(value)){
                  //     return "please entervalie password";
                  //   }
                  // } ,

                ),),
              SizedBox(
                height: 20,
              ),
              SizedBox(
                height: 40,
                width: 200,
                child: ElevatedButton(
                  child: Text('Sign Up',
                    style: Theme.of(context).textTheme.titleLarge,

                  ),
                  style: ElevatedButton.styleFrom(
                      shape: const StadiumBorder(),
                      primary: Colors.grey),
                  onPressed: () async {
                    validator();
                    UserCredential user = await FirebaseAuth.instance
                        .createUserWithEmailAndPassword(
                        email: _email, password: _password);
                    if (user != null) {
                      await FirebaseFirestore.instance
                          .collection('Users')
                          .doc(_email)
                          .set({
                        'FullName': _fullName,
                        'MobileNumber': _mobileNumber,
                        'Email': _email,
                      });
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) {
                          return SignInScreen();
                        }),
                      );
                    } else {
                      print('user does not exist');
                    }

                  },
                  // onPressed: () async {
                  //   validator();
                  //   // Navigator.push(
                  //   //   context,
                  //   //   MaterialPageRoute(builder: (context) {
                  //   //     return SignInScreen();
                  //   //   }),
                  //   // );
                  //   UserCredential user = await FirebaseAuth.instance
                  //       .createUserWithEmailAndPassword(
                  //       email: _email, password: _password);
                  //   if (user != null) {
                  //     await FirebaseFirestore.instance
                  //         .collection('Users')
                  //         .doc(_email)
                  //         .set({
                  //       'FullName': _fullName,
                  //       'MobileNumber': _mobileNumber,
                  //       'Email': _email,
                  //     });
                  //     // Navigator.pop(context);
                  //     //
                  //     //
                  //     Navigator.push(
                  //       context,
                  //       MaterialPageRoute(builder: (context) {
                  //         return SignInScreen();
                  //       }),
                  //     );
                  //
                  //   } else {
                  //     print('user does not exist');
                  //   }
                  // },
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 10, 20, 40),
                child: RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(children: <TextSpan>[
                    const TextSpan(
                        text: "Already have an account?",
                        style: TextStyle(
                            fontFamily: 'Gilroy Light',
                            fontSize: 16,
                            color: Colors.white)),
                    TextSpan(
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) {
                                return SignInScreen();
                              }),
                            );
                          },
                        text: "Sign In",
                        style: const TextStyle(
                          fontFamily: 'Gilroy SemiBold',
                          fontSize: 16,
                          color: Colors.blue,
                        )),
                  ]),
                ),
              ),


            ],
          ),
        ),
      ),
      // Column(
      //   children: <Widget>[
      //     SizedBox(
      //       height: 60.0,
      //     ),
      //     Expanded(
      //       child: Padding(
      //         padding: const EdgeInsets.symmetric(horizontal: 19),
      //         child: Column(
      //           children: <Widget>[
      //             Row(
      //               mainAxisAlignment: MainAxisAlignment.center,
      //               children: <Widget>[
      //                 Text("SIGN UP",
      //                     style: TextStyle(
      //                       // color: Color(0xFFFFBD73),
      //                       fontWeight: FontWeight.bold,
      //                       fontSize: 40,
      //                     )),
      //               ],
      //             ),
      //             // Spacer(),
      //             SizedBox(height: 20,),
      //
      //             Row(
      //               crossAxisAlignment: CrossAxisAlignment.center,
      //               children: <Widget>[
      //                 Padding(
      //                   padding: const EdgeInsets.only(right: 16),
      //                   child: Icon(
      //                     Icons.person,
      //                     color: Colors.white,
      //
      //                     // color: Color(0xFFFFBD73),
      //                   ),
      //                 ),
      //                 Expanded(
      //                   child: TextField(
      //                     onChanged: (value) {
      //                       _fullName = value;
      //                     },
      //                     decoration: InputDecoration(
      //                       hintText: "Full Name",
      //                     ),
      //                   ),
      //                 )
      //               ],
      //             ),
      //             // Spacer(),
      //             SizedBox(height: 20,),
      //
      //             Row(
      //               crossAxisAlignment: CrossAxisAlignment.center,
      //               children: <Widget>[
      //                 Padding(
      //                   padding: const EdgeInsets.only(right: 16),
      //                   child: Icon(
      //                     Icons.phone,
      //                     color: Colors.white,
      //
      //                     // color: Color(0xFFFFBD73),
      //                   ),
      //                 ),
      //                 Expanded(
      //                   child: TextField(
      //                     onChanged: (value) {
      //                       _mobileNumber = value;
      //                     },
      //                     decoration: InputDecoration(
      //                       hintText: "Mobile Number",
      //                     ),
      //                   ),
      //                 ),
      //               ],
      //             ),
      //             // Spacer(),
      //             SizedBox(height: 20,),
      //
      //             Row(
      //               crossAxisAlignment: CrossAxisAlignment.center,
      //               children: <Widget>[
      //                 Padding(
      //                   padding: const EdgeInsets.only(right: 16),
      //                   child: Icon(
      //                     Icons.alternate_email,
      //                     color: Colors.white,
      //
      //                     // color: Color(0xFFFFBD73),
      //                   ),
      //                 ),
      //                 Expanded(
      //                   child: TextField(
      //                     onChanged: (value) {
      //                       _email = value;
      //                     },
      //                     decoration: InputDecoration(
      //                       hintText: "Email Address",
      //                     ),
      //                   ),
      //                 )
      //               ],
      //             ),
      //         SizedBox(height: 20,),
      //             Row(
      //               crossAxisAlignment: CrossAxisAlignment.center,
      //               children: <Widget>[
      //                 Padding(
      //                   padding: const EdgeInsets.only(right: 16),
      //                   child: Icon(
      //                     Icons.lock,
      //                     color: Colors.white,
      //
      //                     // color: Color(0xFFFFBD73),
      //                   ),
      //                 ),
      //                 Expanded(
      //                   child: TextField(
      //                     onChanged: (value) {
      //                       _password = value;
      //                     },
      //                     obscureText: true,
      //                     decoration: InputDecoration(
      //                       hintText: "Password",
      //                     ),
      //                   ),
      //                 )
      //               ],
      //             ),
      //             SizedBox(
      //               height: 20,
      //             ),
      //             // Spacer(),
      //             SizedBox(
      //               height: 60,
      //               width: 200,
      //               child: ElevatedButton(
      //                 child: Text('Sign Up',
      //                   style: Theme.of(context).textTheme.titleLarge,
      //
      //                 ),
      //                 style: ElevatedButton.styleFrom(
      //                     shape: const StadiumBorder(),
      //                     primary: Colors.grey),
      //                 onPressed: () async {
      //                   Navigator.push(
      //                     context,
      //                     MaterialPageRoute(builder: (context) {
      //                       return SignInScreen();
      //                     }),
      //                   );
      //                   UserCredential user = await FirebaseAuth.instance
      //                       .createUserWithEmailAndPassword(
      //                       email: _email, password: _password);
      //                   if (user != null) {
      //                     await FirebaseFirestore.instance
      //                         .collection('Users')
      //                         .doc(_email)
      //                         .set({
      //                       'FullName': _fullName,
      //                       'MobileNumber': _mobileNumber,
      //                       'Email': _email,
      //                     });
      //                     // Navigator.push(context);
      //                     //
      //                     // Navigator.push(
      //                     //   context,
      //                     //   MaterialPageRoute(builder: (context) {
      //                     //     return SignInScreen();
      //                     //   }),
      //                     // );
      //
      //                   } else {
      //                     print('user does not exist');
      //                   }
      //
      //                 },
      //               ),
      //             ),
      //             Padding(
      //               padding: const EdgeInsets.fromLTRB(0, 10, 20, 40),
      //               child: RichText(
      //                 textAlign: TextAlign.center,
      //                 text: TextSpan(children: <TextSpan>[
      //                   const TextSpan(
      //                       text: "Don't have an account ?",
      //                       style: TextStyle(
      //                           fontFamily: 'Gilroy Light',
      //                           fontSize: 16,
      //                           color: Colors.white)),
      //                   TextSpan(
      //                       recognizer: TapGestureRecognizer()
      //                         ..onTap = () {
      //                           Navigator.push(
      //                             context,
      //                             MaterialPageRoute(builder: (context) {
      //                               return SignInScreen();
      //                             }),
      //                           );
      //                           },
      //                       text: "Sign In",
      //                       style: const TextStyle(
      //                         fontFamily: 'Gilroy SemiBold',
      //                         fontSize: 16,
      //                         color: Colors.blue,
      //                       )),
      //                 ]),
      //               ),
      //             ),
      //
      //
      //           ],
      //         ),
      //       ),
      //     ),
      //   ],
      // ),
    );
  }
}
