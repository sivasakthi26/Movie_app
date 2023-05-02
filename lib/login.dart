import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:movie_app/bottom_navigator.dart';
import 'forgot_password.dart';
import 'signup.dart';
import 'package:get/get.dart';

class SignInScreen extends StatelessWidget {
  late String _email, _password;
  static String? email;
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

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body:Container(
child: Form(
  key: _formkey,
  child: Column(
    children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text("SIGN IN",
              style: TextStyle(
                color: Colors.white,

                // color: Color(0xFFFFBD73),
                fontWeight: FontWeight.bold,
                fontSize: 40,
              )),
        ],
      ),
      Padding(padding: EdgeInsets.fromLTRB(20,10,20,0),

        child:
        TextFormField(

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
              return "please Enter valid email";
            }
          } ,
        ),
      ),
      Padding(padding: EdgeInsets.fromLTRB(20,10,20,0),
        child: TextFormField(
          onChanged: (value) {
            _password = value;
          },
          decoration: InputDecoration(labelText: 'Enter the password'),

          obscureText: true,
          keyboardType: TextInputType.number,

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
      Row(
        mainAxisAlignment: MainAxisAlignment.end,
        // crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ForgotPassword()));
              },
              child: Text('Forgot Password ?')),
        ],
      ),
      SizedBox(
        height: 60,
        width: 200,
        child: ElevatedButton(
          child: Text(
            'LogIn',
            style: Theme.of(context).textTheme.titleLarge,

            // style: TextStyle(
            //   color: Colors.black45,
            //   fontWeight: FontWeight.bold,
            //   fontSize: 25,
            // )
          ),

          style: ElevatedButton.styleFrom(
              shape: const StadiumBorder(),
              primary: Colors.grey),
          onPressed: () async {
            validator();
            UserCredential user = await FirebaseAuth.instance
                .signInWithEmailAndPassword(
                email: _email, password: _password);
            if (user != null) {
              email = _email;

              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) {
                  return MainPage();
                }),
              );
            } else {
              print('user does not exist');
            }

          },
        ),
      ),
      SizedBox(height: 20,),
      Padding(
        padding: const EdgeInsets.fromLTRB(0, 10, 20, 40),
        child: RichText(
          textAlign: TextAlign.center,
          text: TextSpan(children: <TextSpan>[
            const TextSpan(
                text: "Don't have an account ?",
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
                        return SignUP();
                      }),
                    );                                },
                text: " Sign Up",
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
        //       height: 50.0,
        //     ),
        //     Expanded(
        //       child: Padding(
        //         padding: const EdgeInsets.symmetric(horizontal: 16),
        //         child: Column(
        //           children: <Widget>[
        //             Row(
        //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //               children: <Widget>[
        //                 Text("SIGN IN",
        //                     style: TextStyle(
        //                       color: Colors.white,
        //
        //                       // color: Color(0xFFFFBD73),
        //                       fontWeight: FontWeight.bold,
        //                       fontSize: 40,
        //                     )),
        //               ],
        //             ),
        //             Padding(
        //               padding: const EdgeInsets.only(bottom: 40),
        //               child: Row(
        //                 crossAxisAlignment: CrossAxisAlignment.center,
        //                 children: <Widget>[
        //                   Padding(
        //                     padding: const EdgeInsets.only(right: 16),
        //                     child: Icon(
        //                       Icons.email,
        //                       color: Colors.white,
        //
        //                       // color: Color(0xFFFFBD73),
        //                     ),
        //                   ),
        //                   Expanded(
        //                     child: TextField(
        //
        //                       onChanged: (value) {
        //                         _email = value;
        //                       },
        //                       decoration: InputDecoration(
        //                         hintText: "Email Address",
        //
        //                       ),
        //                     ),
        //
        //                   ),
        //
        //                 ],
        //               ),
        //             ),
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
        //                     obscureText: true,
        //                     onChanged: (value) {
        //                       _password = value;
        //                     },
        //                     decoration: InputDecoration(
        //                       hintText: "Password",
        //                     ),
        //                   ),
        //                 ),
        //               ],
        //             ),
        //             SizedBox(
        //               height: 20,
        //             ),
        //             Row(
        //               mainAxisAlignment: MainAxisAlignment.end,
        //               // crossAxisAlignment: CrossAxisAlignment.start,
        //               children: [
        //                 TextButton(
        //                     onPressed: () {
        //                       Navigator.push(
        //                           context,
        //                           MaterialPageRoute(
        //                               builder: (context) => ForgotPassword()));
        //                     },
        //                     child: Text('Forgot Password ?')),
        //               ],
        //             ),
        //             SizedBox(
        //               height: 20,
        //             ),
        //             SizedBox(
        //               height: 60,
        //               width: 200,
        //               child: ElevatedButton(
        //                 child: Text(
        //                   'LogIn',
        //                   style: Theme.of(context).textTheme.titleLarge,
        //
        //                   // style: TextStyle(
        //                   //   color: Colors.black45,
        //                   //   fontWeight: FontWeight.bold,
        //                   //   fontSize: 25,
        //                   // )
        //                 ),
        //
        //                 style: ElevatedButton.styleFrom(
        //                     shape: const StadiumBorder(),
        //                     primary: Colors.grey),
        //                 onPressed: () async {
        //                   UserCredential user = await FirebaseAuth.instance
        //                       .signInWithEmailAndPassword(
        //                       email: _email, password: _password);
        //                   if (user != null) {
        //                     email = _email;
        //                     Navigator.push(
        //                       context,
        //                       MaterialPageRoute(builder: (context) {
        //                         return MainPage();
        //                       }),
        //                     );
        //                   } else {
        //                     print('user does not exist');
        //                   }
        //
        //                 },
        //               ),
        //             ),
        //
        //             SizedBox(height: 20,),
        //             // SizedBox(
        //             //   height: 60,
        //             //   width: 200,
        //             //   child: ElevatedButton(
        //             //     child: Text('Sign Up',
        //             //       style: Theme.of(context).textTheme.titleLarge,
        //             //
        //             //
        //             //     ),
        //             //     style: ElevatedButton.styleFrom(
        //             //         shape: const StadiumBorder(),
        //             //         primary: Colors.grey),
        //             //     onPressed: () {
        //             //       print('Pressed SignUP!');
        //             //       Navigator.push(
        //             //         context,
        //             //         MaterialPageRoute(builder: (context) {
        //             //           return SignUP();
        //             //         }),
        //             //       );
        //             //     },
        //             //   ),
        //             // ),
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
        //                               return SignUP();
        //                             }),
        //                           );                                },
        //                       text: " Sign Up",
        //                       style: const TextStyle(
        //                         fontFamily: 'Gilroy SemiBold',
        //                         fontSize: 16,
        //                         color: Colors.blue,
        //                       )),
        //                 ]),
        //               ),
        //             ),
        //           ],
        //         ),
        //       ),
        //     ),
        //   ],
        // ),
      ),
    );
  }
}

