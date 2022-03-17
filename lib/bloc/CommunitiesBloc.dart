import 'dart:convert';
import 'package:bizzilly/providers/ApiProvider.dart';
import 'package:bizzilly/repositories/Repositories.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class CommunitiesBloc {
  //instance of FlutterSecureStorage
  final storage = FlutterSecureStorage();
  //instance of Repositories
  Repositories repositories = Repositories();
  //instance of ApiProvider
  ApiProvider apiProvider = ApiProvider();
  //method for getting communities
  //if communities are present in localstorage then return from there otherwise
  getCommunities() async {
    if (await storage.read(key: 'communities') == null) {
      List list = [];
      list = json.decode(await apiProvider.getCommunitiesAndCategoriesCom());
      return list;
    } else {
      List list = [];
      list = json.decode(await storage.read(key: "communities"));
      return list;
    }
  }
}

//this instance can be accessed directly from anywhere
final communitiesBloc = CommunitiesBloc();
