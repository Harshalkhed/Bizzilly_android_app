import 'package:bizzilly/providers/ApiProvider.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:bizzilly/bloc/CategoriesBloc.dart';
import 'package:bizzilly/bloc/CommunitiesBloc.dart';
import 'package:bizzilly/bloc/MainPageBloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:geolocator/geolocator.dart' as ww;
import 'package:location_permissions/location_permissions.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'package:url_launcher/url_launcher.dart';
import 'DrawerPage.dart';

class DetailsListPage extends StatefulWidget {
  final category, community, subCategory, catIndex, commIndex, subCatIndex;
  DetailsListPage(
      this.commIndex, this.category, this.community, this.subCategory,
      {this.catIndex, this.subCatIndex});
  @override
  _DetailsListPageState createState() => _DetailsListPageState();
}

class _DetailsListPageState extends State<DetailsListPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final ItemScrollController itemScrollController = ItemScrollController();
  final ItemPositionsListener itemPositionsListener =
      ItemPositionsListener.create();
  final ItemScrollController itemScrollController2 = ItemScrollController();
  final ItemPositionsListener itemPositionsListener2 =
      ItemPositionsListener.create();
  final ItemScrollController itemScrollController3 = ItemScrollController();
  final ItemPositionsListener itemPositionsListener3 =
      ItemPositionsListener.create();
  var categories;
  List favIcons = [];
  var isSearching;
  int categoryListIndex;
  var _serviceEnabled;
  var searchVisibility = true;
  var categories2;
  var datafound;
  var communityVisibility, categoryVisibility;
  List subCategories;
  var subCategoryVisibility = false;
  List businesses, businesses2;
  // final _controller = ScrollController();
  var communities, communities2;
  List<bool> categoriesSelected, communitiesSelected, subCategorySelected;
  ww.Position position, position2;
  var com, cat;
  List favs;
  final storage = FlutterSecureStorage();
  List favorites;
  // bool _serviceEnabled;
  Widget appBarTitle;
  Icon actionIcon;
  List businesses3 = [];
  List searchResults = [];
  ApiProvider apiProvider;
  List duplicateItems;
  var subCat;
  var connectivityResult;
  var isConnectionActive = true;
  @override
  void initState() {
    getCategories();
    getCommunities();
    getLocation();
    datafound = false;
    super.initState();
    businesses = [];
    duplicateItems = [];
    subCategories = [];
    favs = [];
    apiProvider = ApiProvider();
    categoryVisibility = true;
    communityVisibility = true;
    appBarTitle = new Text(
      "Bizzilly",
      style: TextStyle(fontWeight: FontWeight.bold),
    );
    actionIcon = new Icon(Icons.search);
    favorites = [];
    businesses2 = [];
    communities = [];
    communities2 = [];
    categories2 = [];
    categories = [];

    communitiesSelected = [];
    categoriesSelected = [];
    subCategorySelected = [];
    checkInternetConnection();
    setState(() {
      cat = widget.category;
      com = widget.community;
      subCat = widget.subCategory;
      print("Subcategory  " + widget.subCategory);
      if (widget.subCategory == "") {
        subCategoryVisibility = false;
      } else {
        subCategoryVisibility = true;
      }
    });

    // getFavorites();
    // getCoordinates();
  }

  locationServiceHandlerDialog(text) {
    Dialog errorDialog = Dialog(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0)), //this right here
      child: Container(
        height: 200.0,
        width: 300.0,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  text.toString(),
                  style: TextStyle(
                      fontSize: 14.0,
                      color: Color.fromRGBO(31, 73, 125, 1.0),
                      fontWeight: FontWeight.bold),
                )
              ],
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  RaisedButton(
                    color: Color.fromRGBO(31, 73, 125, 1.0),
                    onPressed: () {
                      Navigator.pop(context);
                      getLocation();
                    },
                    child: Text(
                      "Refresh",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) => errorDialog);
  }

  locationPermissionHandlerDialog(text) async {
    Dialog errorDialog = Dialog(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0)), //this right here
      child: Container(
        height: 200.0,
        width: 300.0,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  text.toString(),
                  style: TextStyle(
                      fontSize: 14.0,
                      color: Color.fromRGBO(31, 73, 125, 1.0),
                      fontWeight: FontWeight.bold),
                )
              ],
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  RaisedButton(
                    color: Color.fromRGBO(31, 73, 125, 1.0),
                    onPressed: () async {
                      await LocationPermissions().openAppSettings();
                    },
                    child: Text(
                      "Open App Settings",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  RaisedButton(
                    color: Color.fromRGBO(31, 73, 125, 1.0),
                    onPressed: () {
                      Navigator.pop(context);
                      getLocation();
                    },
                    child: Text(
                      "Refresh",
                      style: TextStyle(color: Colors.white),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) => errorDialog);
  }

  openCallDialog(index, from) async {
    Dialog errorDialog = Dialog(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0)), //this right here
      child: Container(
        height: 200.0,
        width: 300.0,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  "Do you want to call ",
                  style: TextStyle(
                      fontSize: 20.0,
                      color: Color.fromRGBO(31, 73, 125, 1.0),
                      fontWeight: FontWeight.bold),
                )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                    from == "resultList"
                        ? businesses2[index].contact.toString() + "?"
                        : searchResults[index].contact.toString() + "?",
                    style: TextStyle(
                        fontSize: 20.0,
                        color: Color.fromRGBO(31, 73, 125, 1.0),
                        fontWeight: FontWeight.bold))
              ],
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  RaisedButton(
                    color: Color.fromRGBO(31, 73, 125, 1.0),
                    onPressed: () {
                      if (from == "resultList") {
                        launchCall(businesses2[index].contact.toString());
                      } else {
                        launchCall(searchResults[index].contact.toString());
                      }
                    },
                    child: Text(
                      "Call",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  RaisedButton(
                    color: Color.fromRGBO(31, 73, 125, 1.0),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text(
                      "Cancel",
                      style: TextStyle(color: Colors.white),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
    showDialog(
        context: context, builder: (BuildContext context) => errorDialog);
  }

  launchCall(var contact) async {
    var url = 'tel:+1' + contact;
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  launchLocation(String lat, String long) async {
    final url =
        'https://www.google.com/maps/search/?api=1&query=' + lat + ',' + long;
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  launchGmail(String email) async {
    final url = 'mailto:' + email;
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  getBusinessesForSearch() async {
    duplicateItems = await apiProvider.getVendorsMobile(
        position.latitude, position.longitude);
  }

  getLocation() async {
    ServiceStatus servicePermission =
        await LocationPermissions().checkServiceStatus();
    if (servicePermission == ServiceStatus.enabled) {
      PermissionStatus permissionStatus =
          await LocationPermissions().checkPermissionStatus();
      if (permissionStatus == PermissionStatus.granted) {
        getCoordinates();
      } else {
        PermissionStatus permissionRequest =
            await LocationPermissions().requestPermissions();
        if (permissionRequest == PermissionStatus.granted) {
          getCoordinates();
        } else {
          locationPermissionHandlerDialog(
              "Please enable location permission. ");
        }
      }
    } else {
      locationServiceHandlerDialog("Please enable location service. ");
    }
  }

  loader() {
    Dialog dialog = Dialog(
      elevation: 0.0,
      backgroundColor: Colors.transparent,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
      child: Container(
        height: 100.0,
        width: 100.0,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            CircularProgressIndicator(
              backgroundColor: Color.fromRGBO(31, 73, 125, 1.0),
            )
          ],
        ),
      ),
    );
    showDialog(context: context, barrierDismissible: false, child: dialog);
  }

  // _animateToIndex(i) => _controller.animateTo(MediaQuery.of(context).size.height * i, duration: Duration(seconds: 2), curve: Curves.fastOutSlowIn);
  getCoordinates() async {
    try {
      position2 = await ww.Geolocator()
          .getCurrentPosition(desiredAccuracy: ww.LocationAccuracy.high);
      setState(() {
        position = position2;
      });
      getBusinessesForSearch();
      getBusinesses();
    } catch (err) {}
  }

  // getFavorites() async {
  //   var f = await storage?.read(key: 'favorites') ?? null;
  //   print(f);
  //   setState(() {
  //     if (f == null) {
  //       favorites = [];
  //     } else {
  //       var ff = json.decode(f);
  //       // print(ff[0]['favorites']);
  //       favorites = ff[0]['favorites'];
  //       for (var i in favorites) {
  //         favs.add(i['_id']);
  //       }
  //     }
  //   });
  // }

  getCategories() async {
    categories = await categoriesBloc.getCategories();
    setState(() {
      categories2 = categories;
    });
    setState(() {
      for (var i = 0; i < categories2.length; i++) {
        categoriesSelected.add(false);
        if (categories[i]['_id'] == widget.category) {
          categoriesSelected[i] = true;
          subCategories = categories[i]['subcategories'];
          for (var j = 0; j < categories[i]['subcategories'].length; j++) {
            print("AA" + categories[i]['subcategories'].toString());
            subCategorySelected.add(false);

            if (categories[i]['subcategories'][j]['_id'] ==
                widget.subCategory) {
              subCategorySelected[j] = true;
            }
          }
        }
      }
    });
  }

  getCommunities() async {
    communities = await communitiesBloc.getCommunities();
    setState(() {
      communities2 = communities;
      for (var i = 0; i < communities2.length; i++) {
        communitiesSelected.add(false);
        if (communities[i]['_id'] == widget.community) {
          communitiesSelected[i] = true;
        }
      }
    });
  }

  getBusinesses() async {
    // loader();
    checkInternetConnection();
    setState(() {
      datafound = false;
    });
    try {
      if (widget.catIndex > 4) {
        itemScrollController.scrollTo(
            index: widget.catIndex,
            duration: Duration(seconds: 2),
            curve: Curves.easeInOutCubic);
      }
      if (widget.commIndex > 3) {
        itemScrollController2.scrollTo(
            index: widget.commIndex,
            duration: Duration(seconds: 2),
            curve: Curves.easeInOutCubic);
      }
      if (widget.subCatIndex != null) {
        itemScrollController3.scrollTo(
            index: widget.subCatIndex,
            duration: Duration(seconds: 2),
            curve: Curves.easeInOutCubic);
      }
      mainPageBLoc.latitude.value = position.latitude;
      mainPageBLoc.longitude.value = position.longitude;
      mainPageBLoc.community.value = com;

      mainPageBLoc.category.value = cat;
      mainPageBLoc.subCategory.value = subCat;

      businesses = await mainPageBLoc.getBusinessesList();
      // duplicateItems = businesses;
      setState(() {
        businesses2 = businesses;
        datafound = true;
        initFavicons();
      });
    } catch (err) {
      print(err.toString());
    }
  }

  initFavicons() {
    favIcons = [];
    print(favs.toString());

    setState(() {
      for (var i in businesses2 ?? []) {
        if (favs.contains(i.id) ?? null) {
          print("inhere2");
          favIcons.add(Icons.favorite);
        } else {
          favIcons.add(Icons.favorite_border);
        }
      }
    });
  }

  void filterSearchResults(String query) async {
    setState(() {
      searchVisibility = false;
      datafound = false;
    });

    searchResults.clear();
    if (query.isNotEmpty) {
      setState(() {
        isSearching = true;
      });

      setState(() {
        datafound = true;
      });
      duplicateItems.forEach((item) {
        print(item.organizationName);
        if (item.organizationName
                .toString()
                .toLowerCase()
                .contains(query.toLowerCase()) ||
            item.contact
                .toString()
                .toLowerCase()
                .contains(query.toLowerCase()) ||
            item.email.toString().toLowerCase().contains(query.toLowerCase())) {
          setState(() {
            searchResults.add(item);
          });
        }
      });
    } else {
      setState(() {
        isSearching = false;
        datafound = true;
        searchVisibility = true;
      });
    }
  }

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

  comSelected(selected, index) async {
    print(selected);

    if (selected == true) {
      setState(() {
        datafound = false;
        for (var i = 0; i < communities2.length; i++) {
          if (communities2[i]['name'] == communities2[index]['name']) {
            if (selected == true) {
              communitiesSelected[index] = true;
              com = communities2[index]['_id'];
            } else {
              communitiesSelected[index] = false;
            }
          } else {
            communitiesSelected[i] = false;
          }
        }
      });
      mainPageBLoc.latitude.value = position.latitude;
      mainPageBLoc.longitude.value = position.longitude;
      mainPageBLoc.community.value = com;

      mainPageBLoc.category.value = cat;
      if (subCategoryVisibility == true) {
        mainPageBLoc.subCategory.value = subCat;
      } else {
        mainPageBLoc.subCategory.value = '';
      }

      print(cat);
      print(com);
      setState(() {
        businesses2 = [];
        businesses = [];
      });
      businesses = await mainPageBLoc.getBusinessesList();
      setState(() {
        datafound = true;
        businesses2 = businesses;
        // duplicateItems = businesses2;
        initFavicons();
      });
    } else {
      return null;
    }
  }

  catSelected(selected, index) async {
    if (selected == true) {
      for (var i = 0; i < categories2.length; i++) {
        setState(() {
          mainPageBLoc.subCategory.value = '';
          if (categories2[i]['name'] == categories2[index]['name']) {
            if (selected == true) {
              categoriesSelected[index] = true;
              cat = categories2[index]['_id'];
            } else {
              categoriesSelected[index] = false;
            }
          } else {
            categoriesSelected[i] = false;
          }
        });
      }
      if (categories2[index]['subcategories'].length > 0) {
        setState(() {
          subCategories = categories2[index]['subcategories'];
          subCategorySelected.clear();
          for (var j = 0; j < categories2[index]['subcategories'].length; j++) {
            subCategorySelected.add(false);
          }

          subCategoryVisibility = true;
        });
      } else {
        setState(() {
          subCategoryVisibility = false;
          mainPageBLoc.latitude.value = position.latitude;
          mainPageBLoc.longitude.value = position.longitude;
          mainPageBLoc.community.value = com;
          mainPageBLoc.category.value = cat;
          mainPageBLoc.subCategory.value = '';
          print(cat);
          print(com);
          print("sb" + subCat);

          datafound = false;
          businesses2 = [];
          businesses = [];
        });
        businesses = await mainPageBLoc.getBusinessesList();
        setState(() {
          datafound = true;
          businesses2 = businesses;
          // duplicateItems = businesses2;
          initFavicons();
        });
      }
    } else {
      return null;
    }
  }

  subCatSelected(selected, index) async {
    if (selected == true) {
      setState(() {
        datafound = false;
        for (var i = 0; i < subCategories.length; i++) {
          if (subCategories[i]['name'] == subCategories[index]['name']) {
            if (selected == true) {
              subCategorySelected[index] = true;
              subCat = subCategories[index]['_id'];
            } else {
              subCategorySelected[index] = false;
            }
          } else {
            subCategorySelected[i] = false;
          }
        }
      });
      mainPageBLoc.latitude.value = position.latitude;
      mainPageBLoc.longitude.value = position.longitude;
      mainPageBLoc.community.value = com;
      mainPageBLoc.category.value = cat;
      mainPageBLoc.subCategory.value = subCat;
      print(cat);
      print(com);
      setState(() {
        businesses2 = [];
        businesses = [];
      });
      businesses = await mainPageBLoc.getBusinessesList();
      setState(() {
        datafound = true;
        businesses2 = businesses;
        initFavicons();
      });
    } else {
      return null;
    }
  }

  checkInternetConnection1(selected, index) async {
    connectivityResult = await (Connectivity().checkConnectivity());
    setState(() {
      if (connectivityResult == ConnectivityResult.mobile ||
          connectivityResult == ConnectivityResult.wifi) {
        isConnectionActive = true;
        comSelected(selected, index);
      } else {
        isConnectionActive = false;
      }
    });
  }

  checkInternetConnection2(selected, index) async {
    connectivityResult = await (Connectivity().checkConnectivity());
    setState(() {
      if (connectivityResult == ConnectivityResult.mobile ||
          connectivityResult == ConnectivityResult.wifi) {
        isConnectionActive = true;
        catSelected(selected, index);
      } else {
        isConnectionActive = false;
      }
    });
  }

  checkInternetConnection3(selected, index) async {
    connectivityResult = await (Connectivity().checkConnectivity());
    setState(() {
      if (connectivityResult == ConnectivityResult.mobile ||
          connectivityResult == ConnectivityResult.wifi) {
        isConnectionActive = true;
        subCatSelected(selected, index);
      } else {
        isConnectionActive = false;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return isConnectionActive == false
        ? Scaffold(
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
          )
        : Scaffold(
            key: _scaffoldKey,
            appBar: AppBar(
                centerTitle: true,
                backgroundColor: Color.fromRGBO(31, 73, 125, 1.0),
                elevation: 0.0,
                title: appBarTitle,
                actions: <Widget>[
                  new IconButton(
                    icon: actionIcon,
                    onPressed: () {
                      setState(() {
                        if (this.actionIcon.icon == Icons.search) {
                          this.actionIcon = new Icon(Icons.close);
                          this.appBarTitle = new TextField(
                            onChanged: (value) {
                              filterSearchResults(value);
                            },
                            style: new TextStyle(
                              color: Colors.white,
                            ),
                            decoration: new InputDecoration(
                                focusedBorder: UnderlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.white)),
                                enabledBorder: UnderlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.white)),
                                border: UnderlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.white)),
                                prefixIcon:
                                    new Icon(Icons.search, color: Colors.white),
                                hintText: "Find Businesses etc ",
                                hintStyle: new TextStyle(color: Colors.white)),
                          );
                        } else {
                          setState(() {
                            isSearching = false;
                            searchVisibility = true;
                          });
                          this.actionIcon = new Icon(Icons.search);
                          this.appBarTitle = new Text(
                            "Bizzilly",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          );
                        }
                      });
                    },
                  ),
                ]),
            drawer: DrawerPage(),
            body: Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: Column(
                children: <Widget>[
                  Flexible(
                    child: Container(
                      height: MediaQuery.of(context).size.height * 0.89,
                      width: MediaQuery.of(context).size.width,
                      child: Column(
                        children: <Widget>[
                          Visibility(
                            visible: searchVisibility,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: <Widget>[
                                Container(
                                  height:
                                      MediaQuery.of(context).size.height * 0.05,
                                  width: MediaQuery.of(context).size.width,
                                  margin: EdgeInsets.only(top: 10),
                                  child: ScrollablePositionedList.builder(
                                    scrollDirection: Axis.horizontal,
                                    itemPositionsListener:
                                        itemPositionsListener2,
                                    itemScrollController: itemScrollController2,
                                    itemCount: communities2.length,
                                    itemBuilder: (ctx, index) => Container(
                                      margin: EdgeInsets.only(left: 10),
                                      child: FilterChip(
                                        showCheckmark: true,
                                        selected: communitiesSelected[index],
                                        selectedColor: Colors.black,
                                        checkmarkColor: Colors.white,
                                        onSelected: (selected) async {
                                          checkInternetConnection1(
                                              selected, index);
                                        },
                                        backgroundColor:
                                            Color.fromRGBO(31, 73, 125, 1.0),
                                        label: Text(
                                          communities2[index]['name']
                                              .toString(),
                                          style: TextStyle(color: Colors.white),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                //categories
                                Container(
                                  height:
                                      MediaQuery.of(context).size.height * 0.05,
                                  width: MediaQuery.of(context).size.width,
                                  margin: EdgeInsets.only(top: 10),
                                  child: ScrollablePositionedList.builder(
                                    scrollDirection: Axis.horizontal,
                                    itemPositionsListener:
                                        itemPositionsListener,
                                    itemScrollController: itemScrollController,
                                    itemCount: categories2.length,
                                    itemBuilder: (ctx, index) => Container(
                                      margin: EdgeInsets.only(left: 10),
                                      child: FilterChip(
                                        showCheckmark: true,
                                        selected: categoriesSelected[index],
                                        selectedColor: Colors.black,
                                        checkmarkColor: Colors.white,
                                        onSelected: (selected) async {
                                          checkInternetConnection2(
                                              selected, index);
                                        },
                                        backgroundColor:
                                            Color.fromRGBO(31, 73, 125, 1.0),
                                        label: Text(
                                          categories2[index]['name'].toString(),
                                          style: TextStyle(color: Colors.white),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                //subcategory
                                Visibility(
                                  visible: subCategoryVisibility,
                                  child: Container(
                                    height: MediaQuery.of(context).size.height *
                                        0.05,
                                    width: MediaQuery.of(context).size.width,
                                    margin: EdgeInsets.only(top: 10),
                                    child: ScrollablePositionedList.builder(
                                      // controller: _controller,
                                      itemPositionsListener:
                                          itemPositionsListener3,
                                      itemScrollController:
                                          itemScrollController3,
                                      scrollDirection: Axis.horizontal,
                                      itemCount: subCategories.length,
                                      itemBuilder: (ctx, index) => Container(
                                        margin: EdgeInsets.only(left: 10),
                                        child: FilterChip(
                                          showCheckmark: true,
                                          selected: subCategorySelected[index],
                                          selectedColor: Colors.black,
                                          checkmarkColor: Colors.white,
                                          onSelected: (selected) async {
                                            checkInternetConnection3(
                                                selected, index);
                                          },
                                          backgroundColor:
                                              Color.fromRGBO(31, 73, 125, 1.0),
                                          label: Text(
                                            subCategories[index]['name']
                                                .toString(),
                                            style:
                                                TextStyle(color: Colors.white),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Expanded(
                            child: datafound == false
                                ? Center(
                                    child: CircularProgressIndicator(
                                      backgroundColor:
                                          Color.fromRGBO(31, 73, 125, 1.0),
                                    ),
                                  )
                                : isSearching == true
                                    ? searchResults.length == 0
                                        ? Center(
                                            child: Image.asset(
                                              "assets/images/NotFound.png",
                                              height: 100,
                                              width: 100,
                                            ),
                                          )
                                        : ListView.builder(
                                            itemCount:
                                                searchResults?.length ?? 0,
                                            shrinkWrap: true,
                                            itemBuilder: (ctx, index) =>
                                                Container(
                                                    height:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .height *
                                                            0.35,
                                                    margin: EdgeInsets.all(5),
                                                    child: Card(
                                                      color: Color.fromRGBO(
                                                          31, 73, 125, 1.0),
                                                      child: Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceEvenly,
                                                        children: <Widget>[
                                                          Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceBetween,
                                                            children: <Widget>[
                                                              Container(
                                                                margin: EdgeInsets
                                                                    .symmetric(
                                                                        horizontal:
                                                                            10,
                                                                        vertical:
                                                                            5),
                                                                child: Text(
                                                                  searchResults[
                                                                          index]
                                                                      .organizationName,
                                                                  style: TextStyle(
                                                                      color: Colors
                                                                          .white,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold,
                                                                      fontSize:
                                                                          18),
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                          Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceBetween,
                                                            children: <Widget>[
                                                              Container(
                                                                margin: EdgeInsets
                                                                    .symmetric(
                                                                        horizontal:
                                                                            10,
                                                                        vertical:
                                                                            5),
                                                                child: Text(
                                                                  searchResults[
                                                                          index]
                                                                      .contactPersonName,
                                                                  style: TextStyle(
                                                                      color: Colors
                                                                          .white,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold,
                                                                      fontSize:
                                                                          15),
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                          GestureDetector(
                                                            onTap: () {
                                                              openCallDialog(
                                                                  index,
                                                                  "searchList");
                                                            },
                                                            child: Row(
                                                              children: <
                                                                  Widget>[
                                                                Container(
                                                                  child: IconButton(
                                                                      icon: Icon(
                                                                          Icons
                                                                              .phone),
                                                                      onPressed:
                                                                          () =>
                                                                              {
                                                                                openCallDialog(index, "searchList")
                                                                              },
                                                                      color: Colors
                                                                          .white),
                                                                ),
                                                                Text(
                                                                  searchResults[
                                                                          index]
                                                                      .contact,
                                                                  style: TextStyle(
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold,
                                                                      color: Colors
                                                                          .white),
                                                                )
                                                              ],
                                                            ),
                                                          ),
                                                          GestureDetector(
                                                            onTap: () {
                                                              launchGmail(
                                                                  searchResults[
                                                                          index]
                                                                      .email);
                                                            },
                                                            child: Row(
                                                              children: <
                                                                  Widget>[
                                                                Container(
                                                                  child: IconButton(
                                                                      icon: Icon(
                                                                          Icons
                                                                              .email),
                                                                      onPressed:
                                                                          () =>
                                                                              {
                                                                                launchGmail(searchResults[index].email)
                                                                              },
                                                                      color: Colors
                                                                          .white),
                                                                ),
                                                                Text(
                                                                  searchResults[
                                                                          index]
                                                                      .email,
                                                                  style: TextStyle(
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold,
                                                                      color: Colors
                                                                          .white),
                                                                )
                                                              ],
                                                            ),
                                                          ),
                                                          GestureDetector(
                                                            onTap: () {
                                                              launchLocation(
                                                                  searchResults[
                                                                          index]
                                                                      .latitude,
                                                                  searchResults[
                                                                          index]
                                                                      .longitude);
                                                            },
                                                            child: Row(
                                                              children: <
                                                                  Widget>[
                                                                Container(
                                                                  child: IconButton(
                                                                      icon: Icon(
                                                                          Icons
                                                                              .location_on),
                                                                      onPressed:
                                                                          () =>
                                                                              {
                                                                                launchLocation(searchResults[index].latitude, searchResults[index].longitude)
                                                                              },
                                                                      color: Colors
                                                                          .white),
                                                                ),
                                                                Expanded(
                                                                  child: Text(
                                                                    searchResults[
                                                                            index]
                                                                        .address,
                                                                    style: TextStyle(
                                                                        fontWeight:
                                                                            FontWeight
                                                                                .bold,
                                                                        color: Colors
                                                                            .white),
                                                                  ),
                                                                )
                                                              ],
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    )))
                                    : businesses2.length == 0
                                        ? Center(
                                            child: Image.asset(
                                              "assets/images/NotFound.png",
                                              height: 100,
                                              width: 100,
                                            ),
                                          )
                                        : ListView.builder(
                                            itemCount: businesses2?.length ?? 0,
                                            shrinkWrap: true,
                                            itemBuilder: (ctx, index) =>
                                                Container(
                                                    height:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .height *
                                                            0.35,
                                                    margin: EdgeInsets.all(5),
                                                    child: Card(
                                                      color: Color.fromRGBO(
                                                          31, 73, 125, 1.0),
                                                      child: Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceEvenly,
                                                        children: <Widget>[
                                                          Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceBetween,
                                                            children: <Widget>[
                                                              Container(
                                                                margin: EdgeInsets
                                                                    .symmetric(
                                                                        horizontal:
                                                                            10,
                                                                        vertical:
                                                                            5),
                                                                child: Text(
                                                                  businesses2[
                                                                          index]
                                                                      .organizationName,
                                                                  style: TextStyle(
                                                                      color: Colors
                                                                          .white,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold,
                                                                      fontSize:
                                                                          18),
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                          Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .start,
                                                            children: <Widget>[
                                                              Container(
                                                                margin: EdgeInsets
                                                                    .symmetric(
                                                                        horizontal:
                                                                            10,
                                                                        vertical:
                                                                            5),
                                                                child: Text(
                                                                  "Contact Person : ",
                                                                  style: TextStyle(
                                                                      color: Colors
                                                                          .white,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold,
                                                                      fontSize:
                                                                          15),
                                                                ),
                                                              ),
                                                              Container(
                                                                margin: EdgeInsets
                                                                    .symmetric(
                                                                        horizontal:
                                                                            10,
                                                                        vertical:
                                                                            5),
                                                                child: Text(
                                                                  businesses2[
                                                                          index]
                                                                      .contactPersonName,
                                                                  style: TextStyle(
                                                                      color: Colors
                                                                          .white,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold,
                                                                      fontSize:
                                                                          15),
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                          GestureDetector(
                                                            onTap: () {
                                                              openCallDialog(
                                                                  index,
                                                                  "resultList");
                                                            },
                                                            child: Row(
                                                              children: <
                                                                  Widget>[
                                                                Container(
                                                                  child: IconButton(
                                                                      icon: Icon(
                                                                          Icons
                                                                              .phone),
                                                                      onPressed:
                                                                          () =>
                                                                              {
                                                                                openCallDialog(index, "resultList")
                                                                              },
                                                                      color: Colors
                                                                          .white),
                                                                ),
                                                                Text(
                                                                  businesses2[
                                                                          index]
                                                                      .contact,
                                                                  style: TextStyle(
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold,
                                                                      color: Colors
                                                                          .white),
                                                                )
                                                              ],
                                                            ),
                                                          ),
                                                          GestureDetector(
                                                            onTap: () {
                                                              launchGmail(
                                                                  businesses2[
                                                                          index]
                                                                      .email);
                                                            },
                                                            child: Row(
                                                              children: <
                                                                  Widget>[
                                                                Container(
                                                                  child: IconButton(
                                                                      icon: Icon(
                                                                          Icons
                                                                              .email),
                                                                      onPressed:
                                                                          () =>
                                                                              {
                                                                                launchGmail(businesses2[index].email)
                                                                              },
                                                                      color: Colors
                                                                          .white),
                                                                ),
                                                                Text(
                                                                  businesses2[
                                                                          index]
                                                                      .email,
                                                                  style: TextStyle(
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold,
                                                                      color: Colors
                                                                          .white),
                                                                )
                                                              ],
                                                            ),
                                                          ),
                                                          GestureDetector(
                                                            onTap: () {
                                                              launchLocation(
                                                                  businesses2[
                                                                          index]
                                                                      .latitude,
                                                                  businesses2[
                                                                          index]
                                                                      .longitude);
                                                            },
                                                            child: Row(
                                                              children: <
                                                                  Widget>[
                                                                Container(
                                                                  child: IconButton(
                                                                      icon: Icon(
                                                                          Icons
                                                                              .location_on),
                                                                      onPressed:
                                                                          () =>
                                                                              {
                                                                                launchLocation(businesses2[index].latitude, businesses2[index].longitude)
                                                                              },
                                                                      color: Colors
                                                                          .white),
                                                                ),
                                                                Expanded(
                                                                  child: Text(
                                                                    businesses2[
                                                                            index]
                                                                        .address,
                                                                    style: TextStyle(
                                                                        fontWeight:
                                                                            FontWeight
                                                                                .bold,
                                                                        color: Colors
                                                                            .white),
                                                                  ),
                                                                )
                                                              ],
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ))),
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          );
  }
}
