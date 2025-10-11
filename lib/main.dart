import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:landmark_gallary/views/home_view.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'LandMark Gallery',
      debugShowCheckedModeBanner: false,
      home: const HomeView(),
    );
  }
}


