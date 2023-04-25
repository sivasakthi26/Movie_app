import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:movie_app/models/liked_model.dart';
import 'package:movie_app/utils.dart';

import 'bottom_navigator.dart';

void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter<LikedModel>(LikedModelAdapter());
  await Hive.openBox<LikedModel>('liked');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
          brightness: Brightness.dark,
          fontFamily: 'poppins',
        scaffoldBackgroundColor: BackgoundColor,
      ),
      debugShowCheckedModeBanner: false,
      home: const MainPage(),
    );
  }
}
