
import 'package:flutter/material.dart';
import 'package:votepoint/constraints.dart';
import 'package:votepoint/widgets/shared_widgets.dart';

class launch extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return Container(
      width: 400,
      margin: EdgeInsets.all(20),
      child: Column(

        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[

          Container(
            margin: EdgeInsets.only(top: 20),
            child: Align(

              alignment: Alignment.topCenter,
              child: RaisedButton(

                onPressed: () => back(context),
                child: const Text('Back', style: TextStyle(fontFamily : 'Lato',fontSize: 20)),
                color: Colors.black,
                textColor: Colors.white,
                elevation: 8,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)
                ),
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 100),
            child: Text(
              kAppName,
              style: TextStyle(
                fontFamily : 'Lato',
                fontSize: 40.0,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ),
          SizedBox(
            height: 200.0,
          ),
          loginbutton(
            label: 'JOIN' ,
            onPressed: () => signIn(context),
          )
        ],
      ),
    );
  }
  void signIn(BuildContext context){
    Navigator.pushReplacementNamed(context, '/joinRoom');
  }
  void back(BuildContext context){
    Navigator.pushReplacementNamed(context, '/main');
  }
}
