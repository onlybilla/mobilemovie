import 'package:flutter/material.dart';
// import 'package:flutter_application_movieapp/Pages/AllMoviepage.dart';
import 'package:flutter_application_movieapp/Pages/Homepage.dart';
// import 'package:flutter_application_movieapp/Pages/AllMoviePage.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Movie App",
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: Color(0xFFF5F5F3),
      ),
      routes: {
        "/": (context) => HomePage(),
        // "/allMovies": (context) => AllMoviesPage(),
      },
    );
  }
}
