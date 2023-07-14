// ignore_for_file: use_build_context_synchronously

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:project/pages/login.dart';
import 'package:project/pages/user/user_main.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}
class _ProfileState extends State<Profile> {
  final uid = FirebaseAuth.instance.currentUser!.uid;
  final email = FirebaseAuth.instance.currentUser!.email;
  final creationTime = FirebaseAuth.instance.currentUser!.metadata.creationTime;

  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final DocumentReference documentReference = FirebaseFirestore.instance.collection('users').doc('coqjlcXsL2QYcc0byCsALDDc3DT2');

  final usernameController = TextEditingController();
  User? user = FirebaseAuth.instance.currentUser;

  FlutterSecureStorage storage = const FlutterSecureStorage();


  verifyEmail() async {
    if (user != null && !user!.emailVerified) {
      await user!.sendEmailVerification();
      //print('Verification Email has benn sent');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          backgroundColor: Colors.orangeAccent,
          content: Text(
            'Verification Email has been sent',
            style: TextStyle(fontSize: 18.0, color: Colors.black),
          ),
        ),
      );
    }
  }



  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Profile'),
          backgroundColor: Colors.deepPurple,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const UserMain(),
                ),
              );
            },
          ),
        ),
        body: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Colors.blue,
                Colors.white,
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              const SizedBox(height: 60.0,),
              const Text(
                'User ID:',
                style: TextStyle(
                  fontSize: 28.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              // FutureBuilder<DocumentSnapshot>(
              //   future: documentReference.get(),
              //   builder: (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
              //     if (snapshot.connectionState == ConnectionState.done) {
              //       if (snapshot.data!.exists) {
              //         final data = snapshot.data!['username'];
              //         return Text(data);
              //       } else {
              //         return const Text('Document does not exist');
              //       }
              //     } else {
              //       return const CircularProgressIndicator();
              //     }
              //   },
              // ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SingleChildScrollView(
                    child: TextField(
                      controller: TextEditingController(text:uid,),
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'User ID',
                      ),
                      readOnly: true,
                    ),
                  ),
                ),
              ),
              const Text(
                'Email :',
                style: TextStyle(
                  fontSize: 28.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height:20),
              Text(
                '$email',
                style: const TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 30.0),
              user!.emailVerified ?  Text(' Verified',
                  style: TextStyle(fontSize: 22.0,color: Colors.blue.shade900,))
                  :TextButton(
                  onPressed: () => {verifyEmail()},
                  child: const Text('Verify Email')),
              const SizedBox(height: 50.0),
              Text(
                'Created: $creationTime',
                style: const TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 30.0,),
              ElevatedButton(
                onPressed: () async => {
                  await FirebaseAuth.instance.signOut(),
                  await storage.delete(key:"uid"),
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const Login(),
                      ),
                          (route) => false)
                },
                style: ElevatedButton.styleFrom(backgroundColor: Colors.deepPurple,
                  textStyle: const TextStyle(fontSize: 30.0,),),
                child: const Text('Logout'),
              ),
              const SizedBox(height:100.0,),
            ],
          ),
        ),
      ),
      debugShowCheckedModeBanner: false,
    );
  }

}



