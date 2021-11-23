import 'package:flutter/material.dart';
import 'package:project_management_app/Screens/loading.dart';

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
        brightness: Brightness.dark,
        primarySwatch: Colors.blueGrey,
        backgroundColor: const Color.fromRGBO(35, 41, 49, 1),
        iconTheme: const IconThemeData(
          color: Color.fromRGBO(78, 204, 163, 1),
        ),
        canvasColor: const Color.fromRGBO(35, 41, 49, 1),
        buttonColor: const Color.fromRGBO(78, 204, 163, 1),
        appBarTheme: const AppBarTheme(
          iconTheme: IconThemeData(
            color: Color.fromRGBO(78, 204, 163, 1),
          ),
          color: Colors.black12,
          elevation: 0,
          textTheme: TextTheme(
            headline6: TextStyle(
                fontSize: 26.0,
                fontFamily: 'Roboto',
                fontWeight: FontWeight.w800,
                color: Colors.white,
                letterSpacing: 1.5),
          ),
        ),
        fontFamily: 'Roboto',
        textTheme: const TextTheme(
          headline4: TextStyle(
            fontSize: 18.0,
            fontFamily: 'Rowdies',
            color: Color.fromRGBO(78, 204, 163, 1),
          ),
          headline6: TextStyle(
            fontSize: 24.0,
            fontFamily: 'Rowdies',
            color: Color.fromRGBO(78, 204, 163, 1),
          ),
          bodyText1: TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.w500,
            color: Color.fromRGBO(238, 238, 238, 1),
          ),
          headline5: TextStyle(
              fontSize: 22.0,
              fontWeight: FontWeight.w700,
              color: Color.fromRGBO(238, 238, 238, 1),
              letterSpacing: 1.5),
          bodyText2: TextStyle(
            fontSize: 16.0,
            color: Colors.white54,
            fontWeight: FontWeight.w500,
          ),
          caption: TextStyle(
              fontSize: 16.0,
              color: Colors.white60,
              fontWeight: FontWeight.w300),
          overline: TextStyle(
              fontSize: 16.0,
              color: Colors.white60,
              fontWeight: FontWeight.w100),
        ),
        accentColor: const Color.fromRGBO(78, 204, 163, 1),
        primaryColor: const Color.fromRGBO(57, 62, 70, 1),
      ),
      home: const LoadingScreen(),
    );
  }
}

/*
mongo "mongodb+srv://cluster0.auku1.mongodb.net/miniProject" --username Karishma
MongoDB shell version v3.6.8
Enter password:
connecting to: mongodb+srv://cluster0.auku1.mongodb.net/miniProject
* */
