import 'package:flutter/material.dart';
import 'package:votepoint/constraints.dart';
import 'package:votepoint/screens/create.dart';
import 'package:votepoint/screens/home.dart';
import 'package:votepoint/screens/joinRoom.dart';
import 'package:votepoint/screens/launch.dart';
import 'package:votepoint/screens/mainhome.dart';
import 'package:votepoint/screens/result.dart';
import 'package:votepoint/screens/splashScreen.dart';
import 'package:votepoint/screens/visted.dart';
void main() {
  runApp(Vote());
}

class  Vote extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
          fontFamily: 'Lato',
        primaryColor: Colors.black,
        accentColor: Colors.black),
      initialRoute:"/" ,
      routes: {
        "/" :(context) => Scaffold(
          body: splash(),
        ),
        "/main" :(context) => Scaffold(
          body: mainhome(),
        ),
        "/launch" :(context) => Scaffold(
          body: launch(),
        ),
        '/home' : (context) => Scaffold(
          appBar: AppBar(
            title: Text(kAppName),
            backgroundColor: Colors.black,
            leading: IconButton(
              icon: Icon(Icons.home),
              color: Colors.white,
              onPressed: (){
                Navigator.pushReplacementNamed(context, '/main');
              },
            ),
          ),
          body: home(),
        ),
        '/create' : (context) => Scaffold(

          body: create(),
        ),
        "/joinRoom" :(context) => Scaffold(
          body: joinRoom(),
        ),
        '/result' : (context) => Scaffold(
          appBar: AppBar(
            title: Text('Result'),
            leading: IconButton(
              icon: Icon(Icons.home),
              color: Colors.white,
              onPressed: (){
                Navigator.pushReplacementNamed(context, '/main');
              },
            ),
          ),
          body: result(),
        ),'/visited' : (context) => Scaffold(
          appBar: AppBar(
            title: Text('Visited'),
            leading: IconButton(
              icon: Icon(Icons.home),
              color: Colors.white,
              onPressed: (){
                Navigator.pushReplacementNamed(context, '/main');
              },
            ),
          ),
          body: visited(),
        )
      },
    );
  }
}
