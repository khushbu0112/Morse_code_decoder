import 'package:flutter/material.dart';
import 'package:project/pages/user/user_main.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: const Text('Text and Button Example'),
      // ),
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
      //margin: const EdgeInsets.all(10.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text('How it works ?',
            style: TextStyle(
                fontSize: 30.0,color: Colors.pink.shade900,
                fontWeight: FontWeight.bold),
          ),
          const Text('The dot button inputs a "." which is considered 1 unit.',
            style: TextStyle(
                fontSize: 22.0,color: Colors.pink,
                fontWeight: FontWeight.bold),
            maxLines: 5,
            overflow: TextOverflow.ellipsis,
          ),
          const Text('The dash button inputs a "-" which is considered 3 units.',
            style: TextStyle(
                fontSize: 22.0,color: Colors.pink,
                fontWeight: FontWeight.bold),
          ),
          const Text('The space button inputs a " " which is considered end of a letter.',
            style: TextStyle(
                fontSize: 22.0,color: Colors.pink,
                fontWeight: FontWeight.bold),
          ),
          const Text('The backslash button inputs a "/" which is considered end of a word.',
            style: TextStyle(fontSize: 22.0,color: Colors.pink,
                fontWeight: FontWeight.bold),
          ),
          const Text('The reset button clears both the morse code and decoded text boxes.',
            style: TextStyle(fontSize: 22.0,color: Colors.pink,
                fontWeight: FontWeight.bold),
          ),
          ElevatedButton.icon(
            onPressed: (){
            Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const UserMain()),
            );
          },
              icon: const Icon(Icons.arrow_forward_rounded,color: Colors.white),
          label:const Text(
            "Let's Start",
            style: TextStyle(fontSize: 28,color: Colors.white),
          )
          ),
        ],
      ),
    ),
    );
  }
}


