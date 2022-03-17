import 'package:bizzilly/bloc/SuggestionBloc.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

// Suggestion Box screen
// Widget Type : Stateful Widget
class SuggestionBox extends StatefulWidget {
  @override
  _SuggestionBoxState createState() => _SuggestionBoxState();
}

class _SuggestionBoxState extends State<SuggestionBox> {
  final _formKey = GlobalKey<FormState>();
  var connectivityResult;
  var isConnectionActive;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  //method for checking internet connectivity
  checkInternetConnection() async {
    connectivityResult = await (Connectivity().checkConnectivity());
    setState(() {
      if (connectivityResult == ConnectivityResult.mobile ||
          connectivityResult == ConnectivityResult.wifi) {
        isConnectionActive = true;
        // getBusinesses();
      } else {
        isConnectionActive = false;
      }
    });
  }

  //method for opening a dialog
  openDialog() {
    Dialog dialog = Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
      child: Container(
        height: 100.0,
        width: 100.0,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            CircularProgressIndicator(
              backgroundColor: Colors.blue,
            )
          ],
        ),
      ),
    );
    showDialog(context: context, barrierDismissible: false, child: dialog);
  }

  @override
  Widget build(BuildContext context) {
    return isConnectionActive == false
        ? Scaffold(
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
          )
        : Scaffold(
            appBar: AppBar(
              backgroundColor: Color.fromRGBO(31, 73, 125, 1.0),
              title: Text(
                "Suggestion Box",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              elevation: 0.0,
              centerTitle: true,
            ),
            body: ListView(
              shrinkWrap: true,
              children: [
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height * 0.90,
                  child: Form(
                    key: _formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Container(
                          margin: EdgeInsets.only(left: 10.0, right: 10.0),
                          child: TextFormField(
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'This field is required';
                              }
                              return null;
                            },
                            onChanged: suggestionBloc.getName,
                            decoration: new InputDecoration(
                                enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color:
                                            Color.fromRGBO(31, 73, 125, 1.0))),
                                border: new OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Color.fromRGBO(31, 73, 125, 1.0)),
                                  borderRadius: const BorderRadius.all(
                                    const Radius.circular(10.0),
                                  ),
                                ),
                                filled: true,
                                hintStyle: new TextStyle(
                                    color: Color.fromRGBO(31, 73, 125, 1.0),
                                    fontWeight: FontWeight.bold),
                                hintText: "Full Name",
                                fillColor: Colors.white70),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(left: 10.0, right: 10.0),
                          child: TextFormField(
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'This field is required';
                              }
                              return null;
                            },
                            onChanged: suggestionBloc.getEmail,
                            decoration: new InputDecoration(
                                enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color:
                                            Color.fromRGBO(31, 73, 125, 1.0))),
                                border: new OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Color.fromRGBO(31, 73, 125, 1.0)),
                                  borderRadius: const BorderRadius.all(
                                    const Radius.circular(10.0),
                                  ),
                                ),
                                filled: true,
                                hintStyle: new TextStyle(
                                    color: Color.fromRGBO(31, 73, 125, 1.0),
                                    fontWeight: FontWeight.bold),
                                hintText: "Email",
                                fillColor: Colors.white70),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(left: 10.0, right: 10.0),
                          child: TextFormField(
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'This field is required';
                              }
                              return null;
                            },
                            onChanged: suggestionBloc.getMessage,
                            decoration: new InputDecoration(
                                enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color:
                                            Color.fromRGBO(31, 73, 125, 1.0))),
                                border: new OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Color.fromRGBO(31, 73, 125, 1.0)),
                                  borderRadius: const BorderRadius.all(
                                    const Radius.circular(10.0),
                                  ),
                                ),
                                filled: true,
                                hintStyle: new TextStyle(
                                    color: Color.fromRGBO(31, 73, 125, 1.0),
                                    fontWeight: FontWeight.bold),
                                hintText: "Message",
                                fillColor: Colors.white70),
                            maxLines: 8,
                          ),
                        ),
                        Container(
                            margin: EdgeInsets.only(left: 10.0, right: 10.0),
                            child: RaisedButton(
                              onPressed: () async {
                                checkInternetConnection();
                                if (_formKey.currentState.validate()) {
                                  openDialog();
                                  var resp =
                                      await suggestionBloc.postSuggestion();
                                  Navigator.pop(context);
                                  if (resp == "success") {
                                    Fluttertoast.showToast(
                                        msg: "Message posted !",
                                        toastLength: Toast.LENGTH_SHORT,
                                        gravity: ToastGravity.CENTER,
                                        timeInSecForIosWeb: 1,
                                        backgroundColor:
                                            Color.fromRGBO(31, 73, 125, 1.0),
                                        textColor: Colors.white,
                                        fontSize: 16.0);
                                  } else {
                                    Fluttertoast.showToast(
                                        msg: "Please try again later !",
                                        toastLength: Toast.LENGTH_LONG,
                                        gravity: ToastGravity.BOTTOM,
                                        timeInSecForIosWeb: 1,
                                        backgroundColor:
                                            Color.fromRGBO(31, 73, 125, 1.0),
                                        textColor: Colors.white,
                                        fontSize: 16.0);
                                  }
                                }
                              },
                              color: Color.fromRGBO(31, 73, 125, 1.0),
                              child: Text(
                                'Submit',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                            ))
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
  }
}
