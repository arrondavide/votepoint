
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
class create  extends StatefulWidget {


  @override
  _create createState() => _create();
}

class _create extends State<create> {
  TextEditingController idc,rnamec,c1c,c2c,c3c,c4c;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    idc=TextEditingController();
    rnamec=TextEditingController();
    c1c=TextEditingController();
    c2c=TextEditingController();
    c3c=TextEditingController();
    c4c=TextEditingController();

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
                      RaisedButton(

                        onPressed: () => addData(),
                        child: const Text('Submit', style: TextStyle(fontFamily : 'Lato',fontSize: 20)),
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


                Text("Create",style: TextStyle(fontFamily : 'Lato',fontSize: 40,color: Colors.white,fontWeight: FontWeight.w800),),

                SizedBox(
                  height: 10.0,
                ),
                Text("Make Voting Online",style: TextStyle(fontFamily : 'Lato',fontSize: 15,color: Colors.white),)
              ],
          ),
            ),),
          Expanded(flex: 5
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

                          TextField(
                            controller: idc,
                            keyboardType:TextInputType.text,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8.0),
                                borderSide: BorderSide.none
                              ),
                              filled: true,
                              fillColor: Colors.grey[300],
                              hintText: "Room ID"
                            ),
                          ),
                      SizedBox(
                        height: 20.0,
                      ),
                      TextField(
                        controller: rnamec,
                        keyboardType:TextInputType.visiblePassword,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8.0),
                                borderSide: BorderSide.none
                            ),
                            filled: true,
                            fillColor: Colors.grey[300],
                            hintText: "Room Name"
                        ),
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                      Text("Enter the Candidate Name",style: TextStyle(fontFamily : 'Lato',fontSize: 20),),
                      SizedBox(
                        height: 20.0,
                      ),
                      TextField(
                        controller: c1c,
                        keyboardType:TextInputType.text,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8.0),
                                borderSide: BorderSide.none
                            ),
                            filled: true,
                            fillColor: Colors.grey[300],
                            hintText: "Candidate Name"
                        ),
                      ),
                      SizedBox(
                        height: 5.0,
                      ),
                      TextField(
                        controller: c2c,
                        keyboardType:TextInputType.text,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8.0),
                                borderSide: BorderSide.none
                            ),
                            filled: true,
                            fillColor: Colors.grey[300],
                            hintText: "Candidate Name"
                        ),
                      ),
                      SizedBox(
                        height: 5.0,
                      ),
                      TextField(
                        controller: c3c,
                        keyboardType:TextInputType.text,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8.0),
                                borderSide: BorderSide.none
                            ),
                            filled: true,
                            fillColor: Colors.grey[300],
                            hintText: "Candidate Name"
                        ),
                      ),
                      SizedBox(
                        height: 5.0,
                      ),
                      TextField(
                        controller: c4c,
                        keyboardType:TextInputType.text,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8.0),
                                borderSide: BorderSide.none
                            ),
                            filled: true,
                            fillColor: Colors.grey[300],
                            hintText: "Candidate Name"
                        ),
                      ),

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
  Future<void> addData() {


    String id=idc.text;
    String roomName=rnamec.text;
    String c1=c1c.text;
    String c2=c2c.text;
    String c3=c3c.text;
    String c4=c4c.text;
    CollectionReference voteRoom = FirebaseFirestore.instance.collection("voteRoom");
    CollectionReference result = FirebaseFirestore.instance.collection("result");

    FirebaseFirestore.instance
        .collection('voteRoom')
        .doc(id.trim())
        .get()
        .then((DocumentSnapshot documentSnapshot) {
      if (documentSnapshot.exists) {
        return showDialog<void>(
          context: context,
          barrierDismissible: false, // user must tap button!
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('oops!', style: TextStyle(fontFamily : 'Lato',fontSize: 25)),
              content: SingleChildScrollView(
                child: ListBody(
                  children: <Widget>[
                    Text('Room ID already available', style: TextStyle(fontFamily : 'Lato',fontSize: 20)),
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

      }else{
        voteRoom.doc(id.trim()).set
          ({
          'id': "id"+id.trim(),
          'Passcode': roomName,
          'c1': c1.trim() ,
          'c2': c2.trim(),
          'c3': c3.trim(),
          'c4': c4.trim(),
        })
            .then((value) => print("User Added"))
            .catchError((error) => print("Failed to add user: $error"));

        result.doc(id).set
          ({
          id : null,
          c1: null ,
          c2: null,
          c3: null,
          c4: null,
        })
            .then((value) => print("User Added"))
            .catchError((error) => print("Failed to add user: $error"));
        Navigator.pushReplacementNamed(context, '/');
      }
    });




  }

}
