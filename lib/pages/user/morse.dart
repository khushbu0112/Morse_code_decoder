import 'package:flutter/material.dart';
import 'package:project/pages/user/user_main.dart';

class Morse extends StatefulWidget {
  const Morse({Key? key}) : super(key: key);

  @override
  State<Morse> createState() => _MorseState();
}

class _MorseState extends State<Morse> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(appBar: AppBar(
          title: const Text('Morse Code'),
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
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [Colors.blue, Colors.white],
    ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'International Morse Code',
                style: TextStyle(fontSize: 30,color: Colors.pink.shade900),
              ),
              const SizedBox(height: 20),
              const Image(
                image: AssetImage('assets/images/International_Morse_Code.png'),
                width: 500,
                height: 500,
              ),
            ],
          ),
        ),
    ),
      debugShowCheckedModeBanner: false,
    );
  }
}
