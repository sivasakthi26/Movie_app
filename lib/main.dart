//
// import 'package:flutter/material.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:hive/hive.dart';
// import 'package:hive_flutter/adapters.dart';
// import 'package:movie_app/bottom_navigator.dart';
// import 'package:movie_app/pages/signup_page.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:movie_app/utils.dart';
//
// import 'models/liked_model.dart';
//
//
// final FirebaseAuth _auth = FirebaseAuth.instance;
//
// void main() async{
//   WidgetsFlutterBinding.ensureInitialized();
//   await Firebase.initializeApp();
//   await Hive.initFlutter();
//   Hive.registerAdapter<LikedModel>(LikedModelAdapter());
//   await Hive.openBox<LikedModel>('liked');
//   runApp(const MyApp());
// }
//
// class MyApp extends StatelessWidget {
//   const MyApp({Key? key}) : super(key: key);
//
//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     return
//     //   MaterialApp(
//     //   theme: ThemeData(
//     //       brightness: Brightness.dark,
//     //       fontFamily: 'poppins',
//     //     scaffoldBackgroundColor: BackgoundColor,
//     //   ),
//     //   debugShowCheckedModeBanner: false,
//     //   home: const MainPage(),
//     // );
//       MaterialApp(
//       title: 'Flutter Demo',
//       theme: ThemeData(
//
//         primarySwatch: Colors.blue,
//       ),
//       home: const MyHomePage(title: 'Flutter Demo Home Page'),
//       debugShowCheckedModeBanner: false,
//       routes: <String, WidgetBuilder>{
//         '/signup': (BuildContext context) => new SignupPage()
//       },
//     );
//   }
// }
//
// class MyHomePage extends StatefulWidget {
//   const MyHomePage({Key? key, required this.title}) : super(key: key);
//
//
//
//   final String title;
//
//   @override
//   State<MyHomePage> createState() => _MyHomePageState();
// }
//
// class _MyHomePageState extends State<MyHomePage> {
//
//   final TextEditingController _emailController = TextEditingController();
//   final TextEditingController _passwordController = TextEditingController();
//   int _success = 1;
//   String _userEmail = "";
//
//   void _singIn() async {
//     final User? user =
//         (await _auth.signInWithEmailAndPassword(
//             email: _emailController.text, password: _passwordController.text)).user;
//
//     if(user != null) {
//       setState(() {
//         _success = 2;
//         _userEmail=user.email.toString();
//         // _userEmail = user.email;
//       });
//     } else {
//       setState(() {
//         _success = 3;
//       });
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return new Scaffold(
//         body: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: <Widget>[
//             Container(
//               child: Stack(
//                 children: <Widget>[
//                   Container(
//                     padding: EdgeInsets.fromLTRB(15, 110, 0, 0),
//                     child: Text("Hello Kavit",
//                         style: TextStyle(
//                             fontSize: 40, fontWeight: FontWeight.bold
//                         )
//                     ),
//                   )
//                 ],
//               ),
//             ),
//             Container(
//               padding: EdgeInsets.only(top: 35, left: 20, right: 30),
//               child: Column(
//                 children: <Widget>[
//                   TextField(
//                     controller: _emailController,
//                     decoration: InputDecoration(
//                         labelText: 'EMAIL',
//                         labelStyle: TextStyle(
//                             fontFamily: 'Montserrat',
//                             fontWeight: FontWeight.bold,
//                             color: Colors.grey
//                         ),
//                         focusedBorder: UnderlineInputBorder(
//                           borderSide: BorderSide(color: Colors.green),
//                         )
//                     ),
//                   ),
//                   SizedBox(height: 20,),
//                   TextField(
//                     controller: _passwordController,
//                     decoration: InputDecoration(
//                         labelText: 'PASSWORD',
//                         labelStyle: TextStyle(
//                             fontFamily: 'Montserrat',
//                             fontWeight: FontWeight.bold,
//                             color: Colors.grey
//                         ),
//                         focusedBorder: UnderlineInputBorder(
//                           borderSide: BorderSide(color: Colors.green),
//                         )
//                     ),
//                     obscureText: true,
//                   ),
//                   SizedBox(height: 5.0,),
//                   Container(
//                     alignment: Alignment(1,0),
//                     padding: EdgeInsets.only(top: 15, left: 20),
//                     child: InkWell(
//                       child: Text(
//                         'Forgot Password',
//                         style: TextStyle(
//                             color: Colors.black,
//                             fontWeight: FontWeight.bold,
//                             fontFamily: 'Montserrat',
//                             decoration: TextDecoration.underline
//                         ),
//                       ),
//                     ),
//                   ),
//                   Container(
//                       alignment: Alignment.center,
//                       padding: const EdgeInsets.symmetric(horizontal: 16),
//                       child: Text(
//                         _success == 1
//                             ? ''
//                             : (
//                             _success == 2
//                                 ? 'Successfully signed in ' + _userEmail
//                                 : 'Sign in failed'),
//                         style: TextStyle(color: Colors.red),
//                       )
//                   ),
//                   SizedBox(height: 40,),
//                   Container(
//                     height: 40,
//                     child: Material(
//                       borderRadius: BorderRadius.circular(20),
//                       shadowColor: Colors.greenAccent,
//                       color: Colors.black,
//                       elevation: 7,
//                       child: GestureDetector(
//                           onTap: () async{
//                             // _singIn();
//                             MainPage();
//                           },
//                           child: Center(
//                               child: Text(
//                                   'LOGIN',
//                                   style: TextStyle(
//                                       color: Colors.white,
//                                       fontWeight: FontWeight.bold,
//                                       fontFamily: 'Montserrat'
//                                   )
//                               )
//                           )
//                       ),
//                     ),
//                   ),
//                   SizedBox(height: 15,),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: <Widget>[
//                       InkWell(
//                         onTap: () {
//                           Navigator.of(context).pushNamed('/signup');
//                         },
//                         child: Text(
//                             'Register',
//                             style: TextStyle(
//                                 color: Colors.blueGrey,
//                                 fontFamily: 'Montserrat',
//                                 fontWeight: FontWeight.bold,
//                                 decoration: TextDecoration.underline
//                             )
//                         ),
//                       )
//                     ],
//                   )
//                 ],
//               ),
//             )
//           ],
//         )
//     );
//   }
//
// }
//
//
// // import 'package:flutter/material.dart';
// // import 'package:firebase_core/firebase_core.dart';
// // import 'login/home_screen.dart';
// // import 'login/login_screen.dart';
// // import 'login/signup_screen.dart';
// // import 'welcome_screen.dart';
// //
// //
// // void main() async {
// //   WidgetsFlutterBinding.ensureInitialized();
// //   await Firebase.initializeApp();
// //   runApp(MyApp());
// // }
// //
// // class MyApp extends StatelessWidget {
// //   // This widget is the root of your application.
// //   @override
// //   Widget build(BuildContext context) {
// //     return MaterialApp(
// //       initialRoute: 'welcome_screen',
// //       routes: {
// //         'welcome_screen': (context) => WelcomeScreen(),
// //         'registration_screen': (context) => RegistrationScreen(),
// //         'login_screen': (context) => LoginScreen(),
// //         'home_screen': (context) => HomeScreen()
// //       },
// //     );
// //   }
// // }
//
//
//
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:movie_app/bottom_navigator.dart';
import 'package:movie_app/sample.dart';
import 'package:movie_app/utils.dart';
import 'package:movie_app/welcome_screen.dart';
import 'forgot_password.dart';
import 'login.dart';
import 'models/liked_model.dart';

const kBackgroundColor = Color(0xFF202020);
const kPrimaryColor = Color(0xFFFFBD73);

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await Hive.initFlutter();
  Hive.registerAdapter<LikedModel>(LikedModelAdapter());
  await Hive.openBox<LikedModel>('liked');
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        brightness: Brightness.dark,
        fontFamily: 'poppins',
        scaffoldBackgroundColor: BackgoundColor,
      ),
      // home: MainPage(),

      home: WelcomeScreen(),
      // home: FormScreen(),
    );
  }
}
