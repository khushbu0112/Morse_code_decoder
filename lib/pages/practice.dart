import 'package:flutter/material.dart';

class Practice extends StatefulWidget {
  const Practice({Key? key}) : super(key: key);

  @override
  State<Practice> createState() => _PracticeState();
}

class _PracticeState extends State<Practice> {
  final TextEditingController _morseCodeController = TextEditingController();
  final TextEditingController _decodedTextController = TextEditingController();
  String _currentCode ='';

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
        return '';
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
                "Practice",
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
              // ElevatedButton(
              //   onPressed: () {
              //     // Perform an action when Button 1 is pressed
              //   },
              //   style: ElevatedButton.styleFrom(
              //     padding: const EdgeInsets.symmetric(vertical:10,horizontal:30),
              //     shape: RoundedRectangleBorder(
              //       borderRadius: BorderRadius.circular(20),
              //     ),
              //     textStyle: const TextStyle(fontSize: 24),
              //     backgroundColor: Colors.deepPurple,
              //   ),
              //   child: const Text('Reset', style: TextStyle(color: Colors.white)),
              // ),
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
              const SizedBox(height:50),
              // GestureDetector(
              //   onTap: () {
              //     // Do something when the button is tapped.
              //   },
              //   child: Container(
              //     width: 100.0,
              //     height: 100.0,
              //     decoration: const BoxDecoration(
              //       shape: BoxShape.circle,
              //       color: Colors.blue,
              //     ),
              //     child: FloatingActionButton(
              //       onPressed: () {
              //         // Do something when the button is pressed.
              //       },
              //       backgroundColor: Colors.deepPurple,
              //       foregroundColor: Colors.white,
              //       elevation: 6.0,
              //       child: const Icon(Icons.touch_app),
              //     ),
              //   ),
              // )
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
