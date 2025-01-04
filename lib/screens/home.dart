import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:votepoint/screens/joinRoom.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';
import 'package:flutter/services.dart';
import 'package:imei_plugin/imei_plugin.dart';

class home extends StatefulWidget {
  final Post post;

  const home({Key key,@required this.post}) : super(key: key);

  @override
  _homeState createState() => _homeState();
}

class _homeState extends State<home> {
  int _currentStep =0;
  TextEditingController idc,nic;

  String c1,c2,c3,c4,detail;
  String id;
  bool isEnabled = true ;
  String _platformImei = 'Unknown';
  String uniqueId = "Unknown";
  bool _validate = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    idc = TextEditingController();
    nic=TextEditingController();
    initPlatformState();

  }
  Future<void> initPlatformState() async {
    String platformImei;
    String idunique;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      platformImei =
      await ImeiPlugin.getImei(shouldShowRequestPermissionRationale: false);
      List<String> multiImei = await ImeiPlugin.getImeiMulti();
      print(multiImei);
      idunique = await ImeiPlugin.getId();
    } on PlatformException {
      Navigator.pushReplacementNamed(context, '/');
      platformImei = 'Failed to get platform version.';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _platformImei = platformImei;
      uniqueId = idunique;
    });

  }
  @override
  Widget build(BuildContext context) {

    future: Firebase.initializeApp();

    return Container(
      child: Column(
        children: <Widget>[

          Expanded(
            child: Theme(
              data: ThemeData(
        accentColor: Colors.grey,
        primarySwatch: Colors.grey,
        fontFamily: 'Lato',
        colorScheme: ColorScheme.light(
            primary: Colors.black)
              ),
              child: Stepper(
                type: StepperType.horizontal,
                    currentStep: _currentStep,
                    steps: [
                      getStep(
                        title:'Vote Room ID',
                        child:
                        Column(
                          children: [ TextField(
                            controller: idc,
                            keyboardType:TextInputType.text,
                            decoration: InputDecoration(
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8.0),
                                    borderSide: BorderSide.none
                                ),
                                filled: true,
                                fillColor: Colors.grey[300],
                                hintText: "Enter Room ID"
                            ),
                          ),
                            SizedBox(
                              height: 5.0,
                            ),
                            TextField(
                              controller: nic,
                              keyboardType:TextInputType.text,
                              decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(8.0),
                                      borderSide: BorderSide.none
                                  ),
                                  filled: true,
                                  fillColor: Colors.grey[300],
                                  hintText: "Enter Nic"
                              ),
                            ),
                          ]
                        ),
                        isActive: true,
                      ),
                      getStep(
                        title:'Vote',
                        child:Column(
                          children: <Widget>[
                        Card(
                        child: Container(
                            width: MediaQuery.of(context).size.width,
                        padding: EdgeInsets.all(20),
                        child: Text(
                          detail!=null?detail:'Default Value',
                        style: TextStyle(fontFamily : 'Lato',
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                        ),
                      ),
    ),
    ),
                            Card(
                              child: InkWell(
                                onTap: () {

                                  String id=idc.text;
                                  FirebaseFirestore.instance
                                      .collection('voteRoom')
                                      .doc(id)
                                      .get()
                                      .then((DocumentSnapshot documentSnapshot) {
                                    if (documentSnapshot.exists) {
                                      FirebaseFirestore.instance.collection("voteRoom").doc(id).get().then((value){
                                        //print(value.data()["c3"]);
                                        c1=value.data()["c1"];
                                        c2=value.data()["c2"];
                                        c3=value.data()["c3"];
                                        c4=value.data()["c4"];
                                        detail=value.data()["Passcode"];
                                      });

                                      CollectionReference users = FirebaseFirestore.instance.collection('result');

                                      users
                                            .doc(id)
                                            .update({c1: FieldValue.increment(1)})
                                            .then((value) => print("User Updated"))
                                            .catchError((error) => print("Failed to update user: $error"));
                                      saveData(context);
                                      Navigator.pushReplacementNamed(context, '/result');



                                    }
                                  });
                                },
                                child: IntrinsicHeight(
                                  child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Container(
                                        constraints: BoxConstraints(minHeight: 60),
                                        width: 8,
                                        color: Colors.grey,
                                      ),
                                      Expanded(
                                        child: Container(
                                          padding: EdgeInsets.only(left: 10, right: 5),
                                          alignment: Alignment.centerLeft,
                                          child: Text(c1!=null?c1:'Default Value'
                                            ,
                                            maxLines: 5,
                                            style: TextStyle(fontFamily : 'Lato',fontSize: 22),
                                          ),

                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            Card(
                              child: InkWell(
                                onTap: () {
                                  String id=idc.text;
                                  FirebaseFirestore.instance
                                      .collection('voteRoom')
                                      .doc(id)
                                      .get()
                                      .then((DocumentSnapshot documentSnapshot) {
                                    if (documentSnapshot.exists) {
                                      FirebaseFirestore.instance.collection("voteRoom").doc(id).get().then((value){
                                        //print(value.data()["c3"]);
                                        c1=value.data()["c1"];
                                        c2=value.data()["c2"];
                                        c3=value.data()["c3"];
                                        c4=value.data()["c4"];
                                        detail=value.data()["Passcode"];
                                      });

                                      CollectionReference users = FirebaseFirestore.instance.collection('result');

                                      users
                                          .doc(id)
                                          .update({c2: FieldValue.increment(1)})
                                          .then((value) => print("User Updated"))
                                          .catchError((error) => print("Failed to update user: $error"));
                                      saveData(context);
                                      Navigator.pushReplacementNamed(context, '/result');



                                    }
                                  });
                                },
                                child: IntrinsicHeight(
                                  child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Container(
                                        constraints: BoxConstraints(minHeight: 60),
                                        width: 8,
                                        color: Colors.grey,
                                      ),
                                      Expanded(
                                        child: Container(
                                          padding: EdgeInsets.only(left: 10, right: 5),
                                          alignment: Alignment.centerLeft,
                                          child: Text(c2!=null?c2:'Default Value'
                                            ,
                                            maxLines: 5,
                                            style: TextStyle(fontFamily : 'Lato',fontSize: 22),
                                          ),

                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            Card(
                              child: InkWell(
                                onTap: () {
                                  String id=idc.text;
                                  FirebaseFirestore.instance
                                      .collection('voteRoom')
                                      .doc(id)
                                      .get()
                                      .then((DocumentSnapshot documentSnapshot) {
                                    if (documentSnapshot.exists) {
                                      FirebaseFirestore.instance.collection("voteRoom").doc(id).get().then((value){
                                        //print(value.data()["c3"]);
                                        c1=value.data()["c1"];
                                        c2=value.data()["c2"];
                                        c3=value.data()["c3"];
                                        c4=value.data()["c4"];
                                        detail=value.data()["Passcode"];
                                      });

                                      CollectionReference users = FirebaseFirestore.instance.collection('result');

                                      users
                                          .doc(id)
                                          .update({c3: FieldValue.increment(1)})
                                          .then((value) => print("User Updated"))
                                          .catchError((error) => print("Failed to update user: $error"));
                                      saveData(context);
                                      Navigator.pushReplacementNamed(context, '/result');



                                    }
                                  });
                                },
                                child: IntrinsicHeight(
                                  child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Container(
                                        constraints: BoxConstraints(minHeight: 60),
                                        width: 8,
                                        color: Colors.grey,
                                      ),
                                      Expanded(
                                        child: Container(
                                          padding: EdgeInsets.only(left: 10, right: 5),
                                          alignment: Alignment.centerLeft,
                                          child: Text(c3!=null?c3:'Default Value'
                                            ,
                                            maxLines: 5,
                                            style: TextStyle(fontFamily : 'Lato',fontSize: 22),
                                          ),

                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            Card(
                              child: InkWell(
                                onTap: () {
                                  String id=idc.text;
                                  FirebaseFirestore.instance
                                      .collection('voteRoom')
                                      .doc(id)
                                      .get()
                                      .then((DocumentSnapshot documentSnapshot) {
                                    if (documentSnapshot.exists) {
                                      FirebaseFirestore.instance.collection("voteRoom").doc(id).get().then((value){
                                        //print(value.data()["c3"]);
                                        c1=value.data()["c1"];
                                        c2=value.data()["c2"];
                                        c3=value.data()["c3"];
                                        c4=value.data()["c4"];
                                        detail=value.data()["Passcode"];
                                      });

                                      CollectionReference users = FirebaseFirestore.instance.collection('result');

                                      users
                                          .doc(id)
                                          .update({c4: FieldValue.increment(1)})
                                          .then((value) => print("User Updated"))
                                          .catchError((error) => print("Failed to update user: $error"));
                                      saveData(context);
                                      Navigator.pushReplacementNamed(context, '/result');



                                    }
                                  });
                                },
                                child: IntrinsicHeight(
                                  child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Container(
                                        constraints: BoxConstraints(minHeight: 60),
                                        width: 8,
                                        color: Colors.grey,
                                      ),
                                      Expanded(
                                        child: Container(
                                          padding: EdgeInsets.only(left: 10, right: 5),
                                          alignment: Alignment.centerLeft,
                                          child: Text(c4!=null?c4:'Default Value'
                                            ,
                                            maxLines: 5,
                                            style: TextStyle(fontFamily : 'Lato',fontSize: 22),
                                          ),

                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],

                        ),

                        isActive: _currentStep >=1 ? true:false,
                      ),

                    ],
                onStepContinue: (){
                  setState(() {

                    readData(context);
                    //_currentStep=_currentStep+1 >1 ? 1:_currentStep +1;
                  });
                },
                onStepCancel: (){
                setState(() {
                  _currentStep=(_currentStep-1)<0 ? 0:_currentStep-1;
                });
                },
              ),
            ),
          ),
        ]
      ),
    );
  }
  Step getStep({String title, Widget child, bool isActive = false})
  {
    return Step(
    title: Text(title),
  content: child,
  isActive: isActive,
    );

  }

  void enter(BuildContext context)
  {

      id=idc.text;


    FirebaseFirestore.instance
        .collection('voteRoom')
        .doc(id.trim())
        .get()
        .then((DocumentSnapshot documentSnapshot) {
      if (documentSnapshot.exists) {
        FirebaseFirestore.instance.collection("voteRoom").doc(id.trim()).get().then((value){
          //print(value.data()["c3"]);
          c1=value.data()["c1"];
          c2=value.data()["c2"];
          c3=value.data()["c3"];
          c4=value.data()["c4"];
          detail=value.data()["Passcode"];
          print(detail);
        });

        _currentStep=_currentStep+1 >1 ? 1:_currentStep +1;


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

  saveValue(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('nic', nic.text.trim());
    final counter = prefs.getString('nic') ?? 0;
    print(counter);
  }

  void saveData(BuildContext context)
  {

    CollectionReference result = FirebaseFirestore.instance.collection(nic.text.trim());
    result.doc(id.trim()).set
      ({
      'visited': _platformImei,
    })
        .then((value) => print("User Added"))
        .catchError((error) => print("Failed to add user: $error"));
    saveValue(context);
    print(_platformImei);
    print(_platformImei);

  }
  void readData(BuildContext context)
  {
    if(nic.text == '' || idc.text == '' )
    {
     showDialog<void>(
        context: context,
        barrierDismissible: false, // user must tap button!
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('oops!', style: TextStyle(fontFamily : 'Lato',fontSize: 25)),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  Text('fields are empty', style: TextStyle(fontFamily : 'Lato',fontSize: 20)),
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

    }else {
      FirebaseFirestore.instance
          .collection(nic.text.trim())
          .doc(idc.text.trim())
          .get()
          .then((DocumentSnapshot documentSnapshot) {
        if (documentSnapshot.exists) {
          return showDialog<void>(
            context: context,
            barrierDismissible: false, // user must tap button!
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text('oops!',
                    style: TextStyle(fontFamily: 'Lato', fontSize: 25)),
                content: SingleChildScrollView(
                  child: ListBody(
                    children: <Widget>[
                      Text('Already Visited', style: TextStyle(
                          fontFamily: 'Lato', fontSize: 20)),
                    ],
                  ),
                ),
                actions: <Widget>[
                  TextButton(
                    child: Text('Try Again',
                        style: TextStyle(fontFamily: 'Lato', fontSize: 20)),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              );
            },
          );
        } else {
          enter(context);
        }
      });
    }
  }
  void validate1(BuildContext context)
  {
    if(_validate){

    }else{

    }

  }
}
