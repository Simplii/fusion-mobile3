import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

import 'src/callpop/callview.dart';
import 'src/dialpad/dialpad.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fusion Revamped',
      theme: ThemeData(
        primarySwatch: Colors.grey,
      ),
      home: MyHomePage(title: 'Fusion Revamped'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key,  this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _currentIndex = 1;
  final List<Widget> _children = [
    Text('people page'),
    CallView(),
    Text('messages page'),
  ];

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  void _openDialPad() {
    showBarModalBottomSheet(context: context, builder: (context) => DialPad());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: _children[_currentIndex],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _openDialPad,
        child: Icon(Icons.dialpad),
      ),
      bottomNavigationBar: BottomNavigationBar(
        onTap: onTabTapped,
        currentIndex: _currentIndex,
        items: [
          BottomNavigationBarItem(
            icon: new Icon(CupertinoIcons.person_2),
            label: "People",
          ),
          BottomNavigationBarItem(
            icon: new Icon(CupertinoIcons.phone_solid),
            label: "Call TEST",
          ),
          BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.chat_bubble), label: 'Messages')
        ],
      ),
    );
  }
}
