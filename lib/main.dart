import 'package:flutter/material.dart';
import 'package:flutter_ebook_app/audio_page.dart';
import 'package:flutter_ebook_app/homepage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSwatch().copyWith(
          secondary: Colors.deepPurple, // Example customization of color scheme
        ),
        // If you're using Material3, set useMaterial3: true
        // useMaterial3: true,
      ),
      home: const Homepage(),
    );
  }
}
