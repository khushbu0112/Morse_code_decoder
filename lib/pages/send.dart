//import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class Send extends StatefulWidget {
  const Send({Key? key}) : super(key: key);

  @override
  State<Send> createState() => _SendState();
}

class _SendState extends State<Send> {
  final TextEditingController _morseCodeController = TextEditingController();
  final TextEditingController _decodedTextController = TextEditingController();
  String _currentCode ='';

  final FirebaseAuth _auth = FirebaseAuth.instance;
  //final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  late DatabaseReference dbRef;


  @override
  void initState(){
    super.initState();
    dbRef = FirebaseDatabase.instance.ref().child('Messages');
  }
  @override
  void dispose() {
    _morseCodeController.dispose();
    _decodedTextController.dispose();
    // _timer?.cancel();
    super.dispose();
  }

  void _onButtonPressed(String code) {
    setState(() {
      _currentCode += code;
      _morseCodeController.text = _currentCode;
      _decodeMorseCode();
      // _isButtonPressed = true;
      // if (_timer == null || !_timer!.isActive) {
      //   _startTimer();
      // }
    });
  }

  void _decodeMorseCode() {
    final morseCode = _morseCodeController.text.trim();
    final words = morseCode.split(' / ');
    final decodedText = words.map((word) {
      final letters = word.split(' ');
      return letters.map((letter) => _decodeMorseLetter(letter)).join();
    }).join(' ');
    _decodedTextController.text = decodedText;
  }

  // void send(){
  //   // ignore: deprecated_member_use
  //   DatabaseReference messageRef = FirebaseDatabase.instance.reference().child('messages');
  //   messageRef.push().set({
  //     'senderId': 'user',
  //     'message': _decodedTextController.text,
  //   });
  //   print('Message sent');
  // }

  String _decodeMorseLetter(String letter) {
    switch (letter) {
      case '.-':
        return 'a';
      case '-...':
        return 'b';
      case '-.-.':
        return 'c';
      case '-..':
        return 'd';
      case '.':
        return 'e';
      case '..-.':
        return 'f';
      case '--.':
        return 'g';
      case '....':
        return 'h';
      case '..':
        return 'i';
      case '.---':
        return 'j';
      case '-.-':
        return 'k';
      case '.-..':
        return 'l';
      case '--':
        return 'm';
      case '-.':
        return 'n';
      case '---':
        return 'o';
      case '.--.':
        return 'p';
      case '--.-':
        return 'q';
      case '.-.':
        return 'r';
      case '...':
        return 's';
      case '-':
        return 't';
      case '..-':
        return 'u';
      case '...-':
        return 'v';
      case '-..-':
        return 'x';
      case '-.--':
        return 'y';
      case '--..':
        return 'z';
      case '.----':
        return '1';
      case '..---':
        return '2';
      case '...--':
        return '3';
      case '....-':
        return '4';
      case '.....':
        return '5';
      case '-....':
        return '6';
      case '--...':
        return '7';
      case '---..':
        return '8';
      case '----.':
        return '9';
      case '-----':
        return '0';
      default:
        return '#';
    }
  }

  void sendMessage() async {

    final documentReference = FirebaseFirestore.instance.collection('users').doc(_auth.currentUser?.uid??'');

    // Fetch the document snapshot
    final snapshot = await documentReference.get();

    // Check if the document exists
    if (snapshot.exists) {
      // Get the data from the snapshot and access the specific field
      final item = snapshot.data()!['username'];
      String username = item;

      // Do something with the item
      print(item);

      Map<String, String> messages = {
        'username': username,
        'message': _decodedTextController.text,
      };
      dbRef.push().set(messages);
      setState(() {
        _currentCode = '';
        _morseCodeController.text = '';
        _decodedTextController.text = '';
      });
    } else {
      // Document doesn't exist
      print('Document does not exist!');
    }


  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Send Message',
      home: Scaffold(
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
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height:30),
              Text(
              "Send Message",
              style: TextStyle(
                fontSize: 36,
                fontWeight: FontWeight.bold,
                color: Colors.pink.shade900,
              ),
            ),
              const SizedBox(height: 50),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SingleChildScrollView(
                  child: TextField(
                    controller: _morseCodeController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Morse Code',
                    ),
                    readOnly: true,
                  ),
                ),
              ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SingleChildScrollView(
                  child: TextField(
                    controller: _decodedTextController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Decoded Text',
                    ),
                    readOnly: true,
                  ),
                ),
              ),
              ),
              const SizedBox(height: 40.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        _currentCode = '';
                        _morseCodeController.text = '';
                        _decodedTextController.text = '';
                      });
                    },
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical:10,horizontal:30),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      textStyle: const TextStyle(fontSize: 24),
                      backgroundColor: Colors.deepPurple,
                    ),
                    child: const Text('Reset'),
                  ),
                  const SizedBox(height: 20.0),
                  ElevatedButton(
                    onPressed: () => sendMessage(),
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical:10,horizontal:30),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      textStyle: const TextStyle(fontSize: 24),
                      backgroundColor: Colors.deepPurple,
                    ),
                    child: const Text('Send'),
                  ),
                ],
              ),
              const SizedBox(height:30),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: () => _onButtonPressed('.'),
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical:10,horizontal:30),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      textStyle: const TextStyle(fontSize: 24),
                      backgroundColor: Colors.deepPurple,
                    ),
                    child: const Text('.'),
                  ),
                  ElevatedButton(
                    onPressed: () => _onButtonPressed('-'),
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical:10,horizontal:30),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      textStyle: const TextStyle(fontSize: 24),
                      backgroundColor: Colors.deepPurple,
                    ),
                    child: const Text('-'),
                  ),
                  ElevatedButton(
                    onPressed: () => _onButtonPressed(' '),
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical:10,horizontal:30),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      textStyle: const TextStyle(fontSize: 24),
                      backgroundColor: Colors.deepPurple,
                    ),
                    child: const Text('Space'),
                  ),
                  ElevatedButton(
                    onPressed: () => _onButtonPressed(' / '),
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical:10,horizontal:30),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      textStyle: const TextStyle(fontSize: 24),
                      backgroundColor: Colors.deepPurple,
                    ),
                    child: const Text('/'),
                  ),
                ],
              ),
              const SizedBox(height: 50),
            ],
          ),
        ),
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}
