import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:project/pages/login.dart';
import 'package:project/pages/user/user_main.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();
  MyApp({super.key});

  final storage = const FlutterSecureStorage();

  Future<bool> checkLoginStatus() async{
    String? value = await storage.read(key:"uid");
    if(value==null){
      return false;
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _initialization,
        builder: (context, snapshot) {
          // Check for Errors
          if (snapshot.hasError) {
              print("Something Went Wrong");
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          return MaterialApp(
            title: 'Tap based Morse Code Decoder',
            theme: ThemeData(
              primarySwatch: Colors.deepPurple,
              appBarTheme: const AppBarTheme(
                iconTheme: IconThemeData(color: Colors.black),
                color: Colors.deepPurple,
              )
            ),
            debugShowCheckedModeBanner: false,
            home: FutureBuilder(future: checkLoginStatus(),
                builder:
                (BuildContext context, AsyncSnapshot<bool>
                snapshot){
              if(snapshot.data==false){
                return const Login();
              }
              if(snapshot.connectionState== ConnectionState.waiting){
                return Container(
                    color: Colors.white,
                    child: const Center(child:CircularProgressIndicator()));
              }
              return const UserMain();
                }),
          );
        });
  }
}

