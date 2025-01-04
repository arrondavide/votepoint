import 'package:flutter/material.dart' ;

import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:charter/charter.dart';
class result extends StatefulWidget {
  const result({Key key}) : super(key: key);

  @override
  _resultState createState() => _resultState();
}

class _resultState extends State<result> {
  int _currentStep =0;
  TextEditingController idc;

  String c1,c2,c3,c4,detail;
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
                      title:'Vote Room ID',
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
                            hintText: "Enter ID"
                        ),
                      ),
                      isActive: true,
                    ),
                    getStep(
                      title:'Result',
                      child:Container(
                        child: SizedBox(
                          width: 200.0,
                          height: 300.0,
                          child: PolarAreaChart.basic(
                              grid: [10,50,100], // Scale for the whole chart
                              features: [
                                c1,
                                c2,
                                c3,
                                c4,

                              ],
                              // Features and data must be same length
                              data: [c1c,c2c,c3c,c4c],
                              featuresTextStyle: TextStyle (
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12
                              ),
                              drawSegmentDividers: true,
                              // Colours are repeated if less than data.length
                              featureColors: [
                                Colors.green,
                                Colors.blue,
                                Colors.red,
                                Colors.orange,

                              ]
                          ),

                        ),
                      ),

                      isActive: _currentStep >=1 ? true:false,
                    ),

                  ],


                  onStepContinue: (){

                    setState(() {
                      enter(context);
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
          FirebaseFirestore.instance.collection("voteRoom").doc(id.trim()).get().then((
              value) {
            //print(value.data()["c3"]);
            c1 = value.data()["c1"];
            c2 = value.data()["c2"];
            c3 = value.data()["c3"];
            c4 = value.data()["c4"];
            detail = value.data()["Passcode"];
            print(c1);
          });
          FirebaseFirestore.instance.collection("result").doc(id.trim()).get().then((
              value) {
            //print(value.data()["c3"]);
            c1c = value.data()[c1];
            c2c = value.data()[c2];
            c3c = value.data()[c2];
            c4c = value.data()[c4];
            //detail=value.data()["Passcode"];
            print(c1c);
          });

          _currentStep = _currentStep + 1 > 1 ? 1 : _currentStep + 1;
        } else {
          return showDialog<void>(
            context: context,
            barrierDismissible: false, // user must tap button!
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text('oops!'),
                content: SingleChildScrollView(
                  child: ListBody(
                    children: <Widget>[
                      Text('Room ID is Invalid'),
                    ],
                  ),
                ),
                actions: <Widget>[
                  TextButton(
                    child: Text('Try Again'),
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
