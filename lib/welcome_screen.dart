import 'package:flutter/material.dart';
import 'package:movie_app/utils.dart';

import 'login.dart';

class WelcomeScreen extends StatefulWidget {
  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor:BackgoundColor,
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[

                Center(
                  child: Text('MOVIE SEARCH APP',
                      style: TextStyle(
                        color: Colors.white,

                        // color: Color(0xFFFFBD73),
                        fontWeight: FontWeight.bold,
                        fontSize: 30,
                      )),
                ),
                Center(
                  child: Image.asset('assets/movie.png'),
                ),
                SizedBox(
                  height: 60,
                  width: 200,
                  child: ElevatedButton(
                    child: const Text(
                      "CLICK HERE",
                      style: TextStyle(
                          fontSize: 18, fontFamily:
                      'Gilroy Medium',color: Colors.black),
                    ),
                    style: ElevatedButton.styleFrom(
                        shape: const StadiumBorder(),
                        primary: Colors.white),
                    // onPressed: (){
                    //   Get.to(()=>OtpNumberScreen());
                    // },
                    onPressed: (){
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) {
                          return SignInScreen();
                        }),
                      );
                    },
                  ),
                ),




              ]),
        ));
  }
}
