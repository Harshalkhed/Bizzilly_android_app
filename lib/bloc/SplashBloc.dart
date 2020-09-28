import 'package:flutter/cupertino.dart';
import 'package:bizzilly/Screens/Community_Screen/community_screen.dart';
import 'package:bizzilly/Screens/Walkthrough.dart';
import 'package:bizzilly/repositories/Repositories.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SplashBloc {
  var token;
  final storage = FlutterSecureStorage();
  Repositories repositories = Repositories();
  getCommunitiesAndCategories() {
    repositories.getCommunitiesAndCategories();
  }

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

final splashBloc = SplashBloc();
