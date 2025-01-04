
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
class mainhome extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    var size =MediaQuery.of(context).size;
    String add = 'assets/images/add.svg';
    String vote = 'assets/images/vote.svg';
    String mission='assets/images/mission.svg';

    String park='assets/images/park.svg';
    var Ctextstyle = TextStyle(fontFamily: 'Lato');
    return Scaffold(


      body: Stack(

           children: <Widget>[

             Container(
               height: size.height * 0.5,
               width: MediaQuery. of(context). size. width,
               decoration: BoxDecoration(
                 image: DecorationImage(
                   alignment: Alignment.topCenter,
                   image: AssetImage('assets/images/1.png')
                 )
               ),
             ),
             SafeArea(
               child: Padding(
                 padding: const EdgeInsets.all(25.0),
                 child: Column(
                   children: <Widget>[
                     Container(

                       height: 64,
                       margin: EdgeInsets.only(bottom: 20),
                       child: Row(
                         mainAxisAlignment:  MainAxisAlignment.center,//optional aaron if you want delete it
                         crossAxisAlignment: CrossAxisAlignment.start,
                         children: <Widget>[
                           CircleAvatar(

                             backgroundColor: Colors.white,
                             radius:35,
                                backgroundImage: AssetImage('assets/images/2.png'),
                           ),
                           SizedBox(width: 16,),
                           Column(
                             mainAxisAlignment: MainAxisAlignment.center,
                             crossAxisAlignment: CrossAxisAlignment.start,
                             children: <Widget>[
                               Text('Vote Point', style: TextStyle(fontFamily : 'Lato',color: Colors.white,fontSize: 30),),
                               //Text('Voting is a Right!',style: TextStyle(fontFamily : 'Lato',color: Colors.white,fontSize: 14),)
                             ],
                           )
                         ],
                       ),
                     ),
                     Expanded(
                       child: GridView.count(

                         mainAxisSpacing: 10,
                           crossAxisSpacing: 10,
                           primary: false,
                           children: <Widget>[
                             Card(
                               child: new InkWell(
                                 onTap: () {
                                   joincreatepage(context);
                                 },
                                 child: Column(
                                   mainAxisAlignment:  MainAxisAlignment.center,
                                   children: <Widget>[
                                     SvgPicture.asset(add,height: 90),
                                     Text('Create',style: TextStyle(fontFamily : 'Lato',fontSize: 20))
                                   ],
                                 ),
                               ),
                               elevation:8,
                               shape: RoundedRectangleBorder(
                                   borderRadius: BorderRadius.circular(20)
                               ),
                             ),

                             Card(
                               child: new InkWell(
                                 onTap: () {
                                   joinpage(context);
                                 },
                                 child: Column(
                                   mainAxisAlignment:  MainAxisAlignment.center,
                                   children: <Widget>[
                                     SvgPicture.asset(vote,height: 90),
                                     Text('Join',style: TextStyle(fontFamily : 'Lato',fontSize: 20))
                                   ],
                                 ),
                               ),
                               elevation:8,
                               shape: RoundedRectangleBorder(
                                   borderRadius: BorderRadius.circular(20)
                               ),
                             ),
                             Card(
                               child: new InkWell(
                                 onTap: () {
                                   Navigator.pushReplacementNamed(context, '/result');
                                 },
                                 child: Column(
                                   mainAxisAlignment:  MainAxisAlignment.center,
                                   children: <Widget>[
                                     SvgPicture.asset(mission,height: 90),
                                     Text('Result',style: TextStyle(fontFamily : 'Lato',fontSize: 20))
                                   ],
                                 ),
                               ),
                               elevation:8,
                               shape: RoundedRectangleBorder(
                                   borderRadius: BorderRadius.circular(20)
                               ),
                             ),
                             Card(
                               child: new InkWell(
                                 onTap: () {
                                   Navigator.pushReplacementNamed(context, '/visited');
                                 },
                                 child: Column(
                                   mainAxisAlignment:  MainAxisAlignment.center,
                                   children: <Widget>[
                                     SvgPicture.asset(park,height: 90),
                                     Text('Visited',style: TextStyle(fontFamily : 'Lato',fontSize: 20))
                                   ],
                                 ),
                               ),
                               elevation:8,
                               shape: RoundedRectangleBorder(
                                   borderRadius: BorderRadius.circular(20)
                               ),
                             ),
                           ],
                           crossAxisCount: 2),
                     ),
                   ],
                 ),
               ),
             ),

           ],
      ),
    );
  }
void joinpage(BuildContext context){
  Navigator.pushReplacementNamed(context, '/joinRoom');
}
  void joincreatepage(BuildContext context){
    Navigator.pushReplacementNamed(context, '/create');
  }
}
