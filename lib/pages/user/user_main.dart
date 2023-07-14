import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:project/pages/practice.dart';
import 'package:project/pages/recieve.dart';
import 'package:project/pages/send.dart';
import 'package:project/pages/user/morse.dart';
import 'package:project/pages/user/change_password.dart';
import 'package:project/pages/user/profile.dart';

class UserMain extends StatefulWidget {
  const UserMain({Key? key}) : super(key: key);

  @override
  State<UserMain> createState() => _UserMainState();
}

class _UserMainState extends State<UserMain> {
  int _selectedIndex = 0;
  final storage = const FlutterSecureStorage();
  static final List<Widget> _widgetOptions = <Widget>[
    const Practice(),
    const Send(),
    const Receive(),
  ];
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'User Main',theme: ThemeData(
      primarySwatch: Colors.deepPurple,
    ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Welcome User'),
          actions: [
            PopupMenuButton(
              itemBuilder: (BuildContext context) => [
                const PopupMenuItem(
                  value: 1,
                  child: Text('Profile',style: TextStyle(color: Colors.deepPurple),),
                ),
                const PopupMenuItem(
                  value: 2,
                  child: Text('Morse Code',style: TextStyle(color: Colors.deepPurple),),
                ),
                const PopupMenuItem(
                  value: 3,
                  child: Text('Change Password', style: TextStyle(color: Colors.deepPurple),),
                ),
              ],
              onSelected: (value) {
                switch (value) {
                  case 1:
                    Navigator.of(context).push(MaterialPageRoute(builder: (context) => const Profile()));
                    break;
                  case 2:
                    Navigator.of(context).push(MaterialPageRoute(builder: (context) => const Morse()));
                    break;
                  case 3:
                    Navigator.of(context).push(MaterialPageRoute(builder: (context) => const ChangePassword()));
                    break;
                }
              },
            )
          ],
        ),
        body: _widgetOptions.elementAt(_selectedIndex),
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: Colors.deepPurple,
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.touch_app),
              label: 'Practice',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.send),
              label: 'Send',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.call_received),
              label: 'Receive',
            ),
          ],
          currentIndex: _selectedIndex,
          selectedItemColor: Colors.amber[500],
          onTap: _onItemTapped,
        ),
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}
