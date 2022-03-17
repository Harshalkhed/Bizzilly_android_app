import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:bizzilly/Screens/SelectCategoryPage.dart';
import 'package:bizzilly/bloc/CommunitiesBloc.dart';

// Community Data page
// Widget Type : Stateful Widget
class ComunityData extends StatefulWidget {
  @override
  _ComunityDataState createState() => _ComunityDataState();
}

class _ComunityDataState extends State<ComunityData> {
  List communities;
  List communities2;

  var isLoading;
  var connectivityResult;
  var isConnectionActive = true;

  @override
  void initState() {
    super.initState();
    communities = [];
    communities2 = [];
    checkInternetConnection();
    // getCommunities();
  }

  getCommunities() async {
    setState(() {
      isLoading = false;
    });
    communities2 = await communitiesBloc.getCommunities();
    setState(() {
      isLoading = true;
      communities = communities2;
    });
  }

  checkInternetConnection() async {
    connectivityResult = await (Connectivity().checkConnectivity());
    setState(() {
      if (connectivityResult == ConnectivityResult.mobile ||
          connectivityResult == ConnectivityResult.wifi) {
        isConnectionActive = true;
        getCommunities();
      } else {
        isConnectionActive = false;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return isConnectionActive == false
        ? WillPopScope(
            onWillPop: () {
              return null;
            },
            child: Scaffold(
              body: Center(
                  child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Text('No Internet Connection !',
                      style: TextStyle(
                          color: Color.fromRGBO(31, 73, 125, 1.0),
                          fontWeight: FontWeight.bold,
                          fontSize: 20)),
                  Container(
                    margin: EdgeInsets.only(top: 20.0),
                    child: RaisedButton(
                      color: Color.fromRGBO(31, 73, 125, 1.0),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          side: BorderSide(color: Colors.black)),
                      onPressed: () {
                        checkInternetConnection();
                      },
                      child: Text(
                        'Refresh',
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                    ),
                  )
                ],
              )),
            ),
          )
        : WillPopScope(
            onWillPop: () {
              return null;
            },
            child: Scaffold(
                appBar: AppBar(
                  automaticallyImplyLeading: false,
                  backgroundColor: Color.fromRGBO(31, 73, 125, 1.0),
                  centerTitle: true,
                  elevation: 0.0,
                  title: Text(
                    "Select Language",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                body: isLoading == false
                    ? Center(
                        child: CircularProgressIndicator(
                          backgroundColor: Color.fromRGBO(31, 73, 125, 1.0),
                        ),
                      )
                    : Container(
                        height: MediaQuery.of(context).size.height,
                        width: MediaQuery.of(context).size.width,
                        margin: EdgeInsets.only(top: 20),
                        child: Column(
                          children: <Widget>[
                            Container(
                              height: MediaQuery.of(context).size.height * 0.8,
                              width: MediaQuery.of(context).size.width,
                              child: GridView.builder(
                                itemCount: communities.length ?? 0,
                                gridDelegate:
                                    SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 3),
                                itemBuilder: (BuildContext context, int index) {
                                  return GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        PageRouteBuilder(
                                          pageBuilder: (c, a1, a2) =>
                                              SelectCategoryPage(index,
                                                  communities[index]['_id']),
                                          transitionsBuilder:
                                              (c, anim, a2, child) =>
                                                  FadeTransition(
                                                      opacity: anim,
                                                      child: child),
                                          transitionDuration:
                                              Duration(milliseconds: 1300),
                                        ),
                                      );
                                    },
                                    child: new Card(
                                        color: Color.fromRGBO(31, 73, 125, 1.0),
                                        child: Center(
                                            child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: <Widget>[
                                            Text(
                                              communities[index]['name']
                                                  .toString(),
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 15),
                                            ),
                                            Text(
                                              communities[index]
                                                      ['devnagari_text']
                                                  .toString(),
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 15),
                                            ),
                                          ],
                                        ))),
                                  );
                                },
                              ),
                            )
                          ],
                        ),
                      )),
          );
  }
}
