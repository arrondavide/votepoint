import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
class loginbutton extends StatelessWidget {
  String label;
  double size;
  Function onPressed;
  loginbutton({this.label,this.size=300.0,this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Container(

      width: size ,

      height: 60.0,
      child: RaisedButton(

       onPressed: onPressed,

        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(80.0)),
        padding: EdgeInsets.all(0.0),
    child: Ink(
    decoration: BoxDecoration(
    gradient: LinearGradient(colors: [Colors.black, Colors.black54],
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
    ),
    borderRadius: BorderRadius.circular(30.0)
    ),
    child: Container(
    constraints: BoxConstraints(maxWidth: 200.0, minHeight: 50.0),
    alignment: Alignment.center,
        child: Text(
          label,
          style: TextStyle(
            fontSize: 25.0,
            color: Colors.white
          ),
        ),
        ),
      ),
      ),
    );
  }
}
