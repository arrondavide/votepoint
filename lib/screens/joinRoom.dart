

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:votepoint/models/Post.dart';
import 'package:votepoint/screens/home.dart';
import 'package:votepoint/constraints.dart';
import 'package:votepoint/widgets/shared_widgets.dart';
class joinRoom extends StatefulWidget {


  @override
  join createState() => join();

}
class Post {
  final String id;


  Post(this.id);
}

class join extends State<joinRoom> {
  TextEditingController idc;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    idc = TextEditingController();
  }
  @override
  Widget build(BuildContext context) {
    future: Firebase.initializeApp();
    return Scaffold(

      body: SingleChildScrollView(
        child: Container(

          constraints: BoxConstraints(
            maxHeight: MediaQuery.of(context).size.height,
            maxWidth: MediaQuery.of(context).size.width,
          ),
          decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.black,
                  Colors.black

                ],
                begin: Alignment.topLeft,
                end: Alignment.centerRight,
              )
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(flex: 2,

                child: Padding(

                  padding: const EdgeInsets.symmetric(vertical: 36.0,horizontal: 24.0),
                  child: Column(

                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [

                      Container(

                        alignment: FractionalOffset.center,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [

                            RaisedButton(

                              onPressed: () => back(context),
                              child: const Text('Back', style: TextStyle(fontFamily : 'Lato',fontSize: 20)),
                              color: Colors.white,
                              textColor: Colors.black,
                              elevation: 8,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20)
                              ),
                            ),

                          ],
                        ),
                      ),


                      Text("Join",style: TextStyle(fontFamily : 'Lato',fontSize: 40,color: Colors.white,fontWeight: FontWeight.w800),),

                      SizedBox(
                        height: 10.0,
                      ),
                      Text("Make Voting Online",style: TextStyle(fontFamily : 'Lato',fontSize: 15,color: Colors.white),)
                    ],
                  ),
                ),),
              Expanded(flex: 3
                  ,child: Container(

                    width: double.infinity,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(30),
                          topRight: Radius.circular(30),
                        )
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(24.0),
                      child: Column(

                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [

                          loginbutton(
                            label: 'JOIN' ,
                            onPressed: () {
                              Navigator.pushReplacementNamed(context, '/home');
                            },
                          )


                        ],
                      ),
                    ),

                  ))
            ],
          ),
        ),
      ),
    );
  }
  void back(BuildContext context){
    Navigator.pushReplacementNamed(context, '/main');
  }
  void enter(BuildContext context)
  {

    String id=idc.text;
    FirebaseFirestore.instance
        .collection('voteRoom')
        .doc(id)
        .get()
        .then((DocumentSnapshot documentSnapshot) {
      if (documentSnapshot.exists) {

        Navigator.pushReplacementNamed(context, '/home');


      }else{
        return showDialog<void>(
          context: context,
          barrierDismissible: false, // user must tap button!
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('oops!', style: TextStyle(fontFamily : 'Lato',fontSize: 25)),
              content: SingleChildScrollView(
                child: ListBody(
                  children: <Widget>[
                    Text('Room ID is Invalid', style: TextStyle(fontFamily : 'Lato',fontSize: 20)),
                  ],
                ),
              ),
              actions: <Widget>[
                TextButton(
                  child: Text('Try Again', style: TextStyle(fontFamily : 'Lato',fontSize: 20)),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          },
        );
      }
    });
  }


}

