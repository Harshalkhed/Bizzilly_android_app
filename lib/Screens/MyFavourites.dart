import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:bizzilly/utilities/constants.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class MyFavourites extends StatefulWidget {
  @override
  _MyFavouritesState createState() => _MyFavouritesState();
}

class _MyFavouritesState extends State<MyFavourites> {
  List favorites;
  final storage = FlutterSecureStorage();
  @override
  void initState() {    
    super.initState();
    favorites = [];
    getFavorites();
  }

  getFavorites() async {
    var f = await storage?.read(key: 'favorites') ?? null;
    print(f);
    setState(() {
      if (f == null) {
        favorites = [];
      } else {
        var ff = json.decode(f);
        favorites = ff[0]['favorites'];
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        centerTitle: true,
        backgroundColor: kPrimaryColor,
        title: Text(
          "Favorites",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: favorites.length == 0
          ? Center(
              child: Text(
                "No Favorites",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
              ),
            )
          : Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              margin: EdgeInsets.only(top: 10),
              child: Column(
                children: <Widget>[
                  ListView.builder(
                      itemCount: favorites?.length ?? 0,
                      shrinkWrap: true,
                      itemBuilder: (ctx, index) => Container(
                          height: MediaQuery.of(context).size.height * 0.25,
                          margin: EdgeInsets.all(5),
                          child: Card(
                            color: Colors.deepPurple[100],
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: <Widget>[
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Container(
                                      margin: EdgeInsets.symmetric(
                                          horizontal: 10, vertical: 5),
                                      child: Text(
                                        favorites[index]['organization_name'],
                                        style: TextStyle(
                                            color: Colors.deepPurple[900],
                                            fontWeight: FontWeight.bold,
                                            fontSize: 18),
                                      ),
                                    ),                                  
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Container(
                                      margin: EdgeInsets.symmetric(
                                          horizontal: 10, vertical: 5),
                                      child: Text(
                                        favorites[index]['contact_person_name'],
                                        style: TextStyle(
                                            color: Colors.deepPurple[700],
                                            fontWeight: FontWeight.bold,
                                            fontSize: 15),
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: <Widget>[
                                    Container(
                                      margin:
                                          EdgeInsets.symmetric(horizontal: 10),
                                      child: Icon(
                                        Icons.phone,
                                        size: 17,
                                      ),
                                    ),
                                    Text(
                                      favorites[index]['contact'],
                                      style: TextStyle(),
                                    )
                                  ],
                                ),
                                Row(
                                  children: <Widget>[
                                    Container(
                                      margin:
                                          EdgeInsets.symmetric(horizontal: 10),
                                      child: Icon(
                                        Icons.email,
                                        size: 17,
                                      ),
                                    ),
                                    Text(
                                      favorites[index]['email'],
                                      style: TextStyle(),
                                    )
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: <Widget>[
                                    Container(
                                        margin: EdgeInsets.symmetric(
                                            horizontal: 10),
                                        child: Text("Address : ")),
                                    Container(
                                        child:
                                            Text(favorites[index]['address'])),
                                  ],
                                )
                              ],
                            ),
                          ))),
                ],
              ),
            ),
    );
  }
}
