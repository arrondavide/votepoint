

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';

class visited extends StatefulWidget {


  @override
  _visitedState createState() => _visitedState();
}

class _visitedState extends State<visited> {
  int _currentStep =0;
  TextEditingController idc;

  String c1,c2,c3,c4,detail,docname;
  final List<String> documents = List<String>();
  int c1c,c2c,c3c,c4c;
  String id;
  bool isEnabled = true ;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    idc = TextEditingController();

  }
  @override
  Widget build(BuildContext context) {
    future: Firebase.initializeApp();

    return  Container(
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
                      title:'Authentication',
                      child:
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
                            hintText: "Enter Nic"
                        ),
                      ),
                      isActive: true,
                    ),
                    getStep(
                      title:'Log',
                      child:Column(
                        children: <Widget>[
                      for  (String sName in documents)
                          Card(
                            child: Container(
                              width: MediaQuery.of(context).size.width,
                              padding: EdgeInsets.all(20),
                              child: Text(
                                sName!=null?sName:'Default Value',
                                style: TextStyle(fontFamily : 'Lato',
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
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
                      _currentStep = _currentStep + 1 > 1 ? 1 : getCloudFirestoreUsers();

                      //_currentStep=_currentStep+1 >1 ? 1:_currentStep +1;

                    });
                  },
                  onStepCancel: (){
                    setState(() {
                      documents.clear();
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


  Future getCloudFirestoreUsers() async {

    id=idc.text;
    print("getCloudFirestore");


      //assumes you have a collection called "users"
      FirebaseFirestore.instance.collection(id.trim()).get().then((querySnapshot) {
        print(querySnapshot.docs);
        print("users: results: length: " + querySnapshot.docs.length.toString());
        querySnapshot.docs.forEach((value) {
          print("users: results: value");

          documents.add(value.id);
          print(documents);
          print(documents.length);
          print(value.data());

        });
      }).catchError((onError) {
        print("getCloudFirestoreUsers: ERROR");
        print(onError);
      });

    _currentStep =  _currentStep + 1;
  }

}
