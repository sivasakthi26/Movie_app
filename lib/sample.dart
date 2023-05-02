import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'login.dart';

class FormScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return FormScreenState();
  }
}

class FormScreenState extends State<FormScreen> {
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
      appBar: AppBar(),
      body: Container(
        child: Form(
          key: _formkey,
          child: Column(
            children: [
              Padding(padding: EdgeInsets.all(8.0),
              child: TextFormField(
                decoration: InputDecoration(labelText: 'Enter the full name'),
                validator: (String? value){
                  if(value==null || value.trim().length==0){
                    return "Field is require";
                  }
                  return null;
                } ,
              ),
              ),
              Padding(padding: EdgeInsets.all(8.0),
                child: TextFormField(
                  decoration: InputDecoration(labelText: 'Enter the mobilenumber'),
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
              Padding(padding: EdgeInsets.all(8.0),
                child: TextFormField(
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
              Padding(padding: EdgeInsets.all(8.0),
                child: TextFormField(
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
              ElevatedButton(onPressed: () async {
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(builder: (context) {
                //     return SignInScreen();
                //   }),
                // );
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
                  // Navigator.push(context);
                  //
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) {
                      return SignInScreen();
                    }),
                  );

                } else {
                  print('user does not exist');
                }
                // validator();

              }, child: Text('sign up'),
              )

            ],
          ),
        ),
      ),

    );


  }
}