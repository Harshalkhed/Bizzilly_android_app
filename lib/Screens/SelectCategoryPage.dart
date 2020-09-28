import 'package:cached_network_image/cached_network_image.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:bizzilly/Screens/DetailsListPage.dart';
import 'package:bizzilly/bloc/CategoriesBloc.dart';

class SelectCategoryPage extends StatefulWidget {
  final community;
  final commIndex;
  SelectCategoryPage(this.commIndex,this.community);
  @override
  _SelectCategoryPageState createState() => _SelectCategoryPageState();
}

class _SelectCategoryPageState extends State<SelectCategoryPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  var connectivityResult;
  var isConnectionActive = true;
  List categories;
  List categories2;
  var isLoading = false;

  @override
  void initState() {
    super.initState();
    categories = [];
    categories2 = [];
    checkInternetConnection();
  }

  getCategories() async {
    setState(() {
      isLoading = false;
    });
    categories = await categoriesBloc.getCategories();
    setState(() {
      isLoading = true;
      categories2 = categories;
    });
  }
    checkInternetConnection() async {
    connectivityResult = await (Connectivity().checkConnectivity());
    setState(() {
      if (connectivityResult == ConnectivityResult.mobile ||
          connectivityResult == ConnectivityResult.wifi) {
        isConnectionActive = true;
        getCategories();
      } else {
        
        isConnectionActive = false;
      }
    });
  }
  selectSubcategory(list, index2) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: true, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          content: Container(
            height: MediaQuery.of(context).size.height * 0.5,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Center(
                  child: Text(
                    "Select Subcategory",
                    style: TextStyle(color: Color.fromRGBO(31, 73, 125, 1.0),fontWeight: FontWeight.bold)
                  ),
                ),
                Container(
                  width: double.maxFinite,
                  height: MediaQuery.of(context).size.height * 0.4,
                  child: ListView.builder(
                      itemCount: list.length,
                      shrinkWrap: true,
                      itemBuilder: (ctx, index) => Container(
                            child: GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  PageRouteBuilder(
                                    pageBuilder: (c, a1, a2) => DetailsListPage(
                                      widget.commIndex,
                                        categories[index2]['_id'],
                                        widget.community,
                                        list[index]['_id'],catIndex: index2,subCatIndex: index,),
                                    transitionsBuilder: (c, anim, a2, child) =>
                                        FadeTransition(
                                            opacity: anim, child: child),
                                    transitionDuration:
                                        Duration(milliseconds: 1300),
                                  ),
                                );
                              },
                              child: Container(
                                  height:
                                      MediaQuery.of(context).size.height * 0.1,
                                  child: Card(
                                    color: Color.fromRGBO(31, 73, 125, 1.0),
                                    child: Center(
                                        child: Text(
                                      list[index]['name'].toString(),
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                          fontSize: 20),
                                    )),
                                  )),
                            ),
                          )),
                )
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return isConnectionActive == false? Scaffold(
            key: _scaffoldKey,
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
          ): Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        centerTitle: true,
        elevation: 0.0,
        backgroundColor: Color.fromRGBO(31, 73, 125, 1.0),
        title: Text(
          "Select Category",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: isLoading == false
          ? Center(
              child: CircularProgressIndicator(
                backgroundColor: Color.fromRGBO(31, 73, 125, 1.0),
              ),
            )
          : SingleChildScrollView(
              child: Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                margin: EdgeInsets.only(top: 15),
                child: Column(
                  children: <Widget>[
                    Container(
                      height: MediaQuery.of(context).size.height * 0.8,
                      width: MediaQuery.of(context).size.width,
                      margin: EdgeInsets.all(10),
                      child: GridView.builder(
                          itemCount: categories.length ?? 0,
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 3,
                                  crossAxisSpacing: 10,
                                  mainAxisSpacing: 10),
                          itemBuilder: (ctx, index) {
                            return GestureDetector(
                              onTap: () {
                                if (categories[index]['subcategories'].length >
                                    0) {
                                  selectSubcategory(
                                      categories[index]['subcategories'],
                                      index);
                                } else {
                                  Navigator.push(
                                    context,
                                    PageRouteBuilder(
                                      pageBuilder: (c, a1, a2) =>
                                          DetailsListPage(
                                            widget.commIndex,
                                              categories[index]['_id'],
                                              widget.community,
                                              "",catIndex: index),
                                      transitionsBuilder:
                                          (c, anim, a2, child) =>
                                              FadeTransition(
                                                  opacity: anim, child: child),
                                      transitionDuration:
                                          Duration(milliseconds: 1300),
                                    ),
                                  );
                                }
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                    color: Color.fromRGBO(31, 73, 125, 1.0),
                                    borderRadius: BorderRadius.circular(10)),
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: <Widget>[
                                    CachedNetworkImage(
                                      placeholder: (context, url) =>
                                          Container(
                                            width:40,
                                            height:8,
                                            child: const CircularProgressIndicator(backgroundColor: Colors.white,)),
                                      imageUrl:
                                          'https://bizzilly.com/uploads/' +
                                              categories[index]['image'].toString(),
                                      height: 50,
                                    ),
                                    Text(
                                      categories[index]['name'],
                                      style: TextStyle(
                                          fontSize: 10.0, fontWeight: FontWeight.bold,color: Colors.white),
                                    )
                                  ],
                                ),
                              ),
                            );
                          }),
                    )
                  ],
                ),
              ),
            ),
    );
  }
}
