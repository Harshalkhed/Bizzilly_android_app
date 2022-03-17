import 'package:bizzilly/Screens/AboutUs.dart';
import 'package:bizzilly/Screens/PrivacyPolicy.dart';
import 'package:bizzilly/Screens/TermsAndConditions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:store_redirect/store_redirect.dart';

// Drawer page
// Widget Type : Stateful Widget
class DrawerPage extends StatefulWidget {
  @override
  _DrawerPageState createState() => _DrawerPageState();
}

class _DrawerPageState extends State<DrawerPage> {
  var token;
  final storage = FlutterSecureStorage();

  launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(
        url,
        forceSafariVC: true,
        forceWebView: false,
      );
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.7,
      child: Drawer(
        child: Container(
            color: Colors.white,
            height: MediaQuery.of(context).size.height,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Image.asset("assets/images/Logo_Blue.png",
                    height: 140, width: 170),
                // Container(
                //   margin: EdgeInsets.only(top: 40),
                //   child: RotatedBox(
                //       quarterTurns: 1,
                //       child: Opacity(
                //         opacity: 0.75,
                //         child: new Text(
                //           "Bizzilly",
                //           style: TextStyle(
                //               shadows: <Shadow>[
                //                 Shadow(
                //                   offset: Offset(10.0, 10.0),
                //                   blurRadius: 3.0,
                //                   color: Colors.black,
                //                 ),
                //                 Shadow(
                //                   offset: Offset(10.0, 10.0),
                //                   blurRadius: 8.0,
                //                   color: Colors.black,
                //                 ),
                //               ],
                //               color: Colors.white,
                //               fontSize:
                //                   MediaQuery.of(context).size.height * 0.12),
                //         ),
                //       )),
                // ),
                Container(
                  child: Column(
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                          Navigator.push(
                            context,
                            PageRouteBuilder(
                              pageBuilder: (c, a1, a2) => AboutUs(),
                              transitionsBuilder: (c, anim, a2, child) =>
                                  FadeTransition(opacity: anim, child: child),
                              transitionDuration: Duration(milliseconds: 1300),
                            ),
                          );
                        },
                        child: ListTile(
                          leading: Icon(Icons.account_box,
                              color: Color.fromRGBO(31, 73, 125, 1.0)),
                          title: Text(
                            "About Us",
                            style: TextStyle(
                                color: Color.fromRGBO(31, 73, 125, 1.0),
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () async {
                          Navigator.pop(context);
                          final url = 'https://bizzilly.com';
                          if (await canLaunch(url)) {
                            await launch(url);
                          } else {
                            throw 'Could not launch $url';
                          }
                        },
                        child: ListTile(
                          leading: Icon(
                            Icons.business,
                            color: Color.fromRGBO(31, 73, 125, 1.0),
                          ),
                          title: Text("Visit our site",
                              style: TextStyle(
                                  color: Color.fromRGBO(31, 73, 125, 1.0),
                                  fontWeight: FontWeight.bold)),
                        ),
                      ),
                      GestureDetector(
                        onTap: () async {
                          Navigator.pop(context);
                          StoreRedirect.redirect(
                              androidAppId: "com.securetechsolutions.bizzilly");
                        },
                        child: ListTile(
                          leading: Icon(
                            Icons.star,
                            color: Color.fromRGBO(31, 73, 125, 1.0),
                          ),
                          title: Text("Rate our app",
                              style: TextStyle(
                                  color: Color.fromRGBO(31, 73, 125, 1.0),
                                  fontWeight: FontWeight.bold)),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                          Navigator.push(
                            context,
                            PageRouteBuilder(
                              pageBuilder: (c, a1, a2) => PrivacyPolicy(),
                              transitionsBuilder: (c, anim, a2, child) =>
                                  FadeTransition(opacity: anim, child: child),
                              transitionDuration: Duration(milliseconds: 1300),
                            ),
                          );
                        },
                        child: ListTile(
                          leading: Icon(
                            Icons.lock,
                            color: Color.fromRGBO(31, 73, 125, 1.0),
                          ),
                          title: Text("Privacy Policy",
                              style: TextStyle(
                                  color: Color.fromRGBO(31, 73, 125, 1.0),
                                  fontWeight: FontWeight.bold)),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                          Navigator.push(
                            context,
                            PageRouteBuilder(
                              pageBuilder: (c, a1, a2) => TermsAndConditions(),
                              transitionsBuilder: (c, anim, a2, child) =>
                                  FadeTransition(opacity: anim, child: child),
                              transitionDuration: Duration(milliseconds: 1300),
                            ),
                          );
                        },
                        child: ListTile(
                          leading: Icon(
                            Icons.content_copy,
                            color: Color.fromRGBO(31, 73, 125, 1.0),
                          ),
                          title: Text("Terms And Conditions",
                              style: TextStyle(
                                  color: Color.fromRGBO(31, 73, 125, 1.0),
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14.0)),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            )),
      ),
    );
  }
}
