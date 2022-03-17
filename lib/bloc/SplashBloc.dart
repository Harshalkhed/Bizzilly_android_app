import 'package:flutter/cupertino.dart';
import 'package:bizzilly/Screens/Community_Screen/community_screen.dart';
import 'package:bizzilly/Screens/Walkthrough.dart';
import 'package:bizzilly/repositories/Repositories.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SplashBloc {
  var token;
  final storage = FlutterSecureStorage();
  Repositories repositories = Repositories();
  //method for getting communities and categories
  getCommunitiesAndCategories() {
    repositories.getCommunitiesAndCategories();
  }

  //method for getting token from secure storage
  Future<Widget> getToken() async {
    token = await storage.read(key: "first_time");
    if (token == null) {
      getCommunitiesAndCategories();
      print("inhere");
      return Walkthrough();
    } else {
      getCommunitiesAndCategories();
      return CommunityScreen();
    }
  }
}

//this instance can be accessed directly from anywhere
final splashBloc = SplashBloc();
