import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';

class Receive extends StatefulWidget {
  const Receive({Key? key}) : super(key: key);

  @override
  State<Receive> createState() => _ReceiveState();
}

class _ReceiveState extends State<Receive> {

  Query dbRef = FirebaseDatabase.instance.ref().child('Messages');
  //DatabaseReference reference = FirebaseDatabase.ref().child('Messages');

  Widget listItem({required Map message}) {
    return Container(
      margin: const EdgeInsets.all(10),
      padding: const EdgeInsets.all(10),
      height: 110,
      color: Colors.pink.shade900,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Username: ${message['username']}',
            style: const TextStyle(fontSize: 8, fontWeight: FontWeight.w400, color: Colors.white),
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
              'Message: ${message['message']}',
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w400,color:Colors.white),
          ),
          // Row(
          //   mainAxisAlignment: MainAxisAlignment.end,
          //   crossAxisAlignment: CrossAxisAlignment.center,
          //   children: [
          //     GestureDetector(
          //       onTap: () {
          //         //reference.child(message['key']).remove();
          //       },
          //       child: Row(
          //         children: const [
          //           Icon(
          //             Icons.delete,
          //             color: Colors.white,
          //           ),
          //         ],
          //       ),
          //     ),
          //   ],
          // )
        ],
      ),
    );
  }



  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Receive Message',
      home: Scaffold(
        body: Container(
          height: double.infinity,
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
          child: FirebaseAnimatedList(
            query: dbRef,
            itemBuilder: (BuildContext context, DataSnapshot snapshot, Animation<double> animation, int index){
              Map message = snapshot.value as Map;
              message['key']=snapshot.key;
              return listItem(message: message);
            },
          ),
  //         Column(
  //             children: [
  //             const SizedBox(height:30),
  //         Text(
  //           "Receive Message",
  //           style: TextStyle(
  //             fontSize: 36,
  //             fontWeight: FontWeight.bold,
  //             color: Colors.pink.shade900,
  //           ),
  //         ),
  //               const SizedBox(height: 50),
  //               const Expanded(
  //                 child: Padding(
  //                   padding: EdgeInsets.all(20.0),
  //                   child: SingleChildScrollView(
  //                     child: TextField(
  //                       decoration: InputDecoration(
  //                         border: OutlineInputBorder(),
  //                         labelText: 'Message',
  //                       ),
  //                       readOnly: true,
  //                     ),
  //                   ),
  //                 ),
  //               ),
  // ],
  //         ),
    ),
    ),
      debugShowCheckedModeBanner: false,
    );
  }
}
