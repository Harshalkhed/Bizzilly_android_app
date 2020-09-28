import 'dart:async';
import 'package:connectivity/connectivity.dart';
import 'package:bizzilly/bloc/SplashBloc.dart';
import 'package:bizzilly/utilities/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter/animation.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  Animation animation, delayedAnimation, muchDelayedAnimation;  
  AnimationController animationController;
  var screenName;
  final storage = FlutterSecureStorage();
  var respdata;
  String token, token2;
  var userDataUrl;
  var connectivityResult;
  var isConnectionActive = true;

  @override
  void initState() {
    // getToken();         
    
  // your code after page opens,splash keeps open until work is done
  Timer(
        Duration(seconds: 5),
        () => Navigator.push(
              context,
              PageRouteBuilder(
                pageBuilder: (c, a1, a2) => screenName,
                transitionsBuilder: (c, anim, a2, child) =>
                    FadeTransition(opacity: anim, child: child),
                transitionDuration: Duration(milliseconds: 1300),
              ),
            ));

    animationController =
        AnimationController(duration: Duration(seconds: 3), vsync: this);

    animation = Tween(begin: -1.0, end: 0.0).animate(CurvedAnimation(
        parent: animationController, curve: Curves.fastOutSlowIn));

    delayedAnimation = Tween(begin: 1.0, end: 0.0).animate(CurvedAnimation(
      parent: animationController,
      curve: Interval(0.5, 1.0, curve: Curves.fastOutSlowIn),
    ));

    muchDelayedAnimation = Tween(begin: -1.0, end: 0.0).animate(CurvedAnimation(
        parent: animationController,
        curve: Interval(0.8, 1.0, curve: Curves.fastOutSlowIn)));
    super.initState();
    userDataUrl = BASE_URL + 'users/get_user_data';   
    getScreenName();     
  
  }

  checkInternetConnection() async {
    connectivityResult = await (Connectivity().checkConnectivity());
    setState(() {
      if (connectivityResult == ConnectivityResult.mobile ||
          connectivityResult == ConnectivityResult.wifi) {
        isConnectionActive = true;        
      } else {
        isConnectionActive = false;
      }
    });
  }

  getScreenName() async {
    screenName = await splashBloc.getToken();
  }

  @override
  dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {    
    animationController.forward();

    return AnimatedBuilder(
        animation: animationController,
        builder: (BuildContext context, Widget child) {
          return Scaffold(            
              body: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,              
              children: <Widget>[
                Image.asset("assets/images/Logo_Blue.png",height: 140,width: 170),
                Container( 
                  child: Column(children: <Widget>[
                    Text('Powered By',style:TextStyle(color: Color.fromRGBO(31, 73, 125, 1.0),fontSize: 20.0,fontWeight: FontWeight.bold)),
                    Image.asset("assets/images/SecureTech.png",height: 150,width: 150)
                  ],),
                )
              ],
            ),
          ));
        });
  }
}
