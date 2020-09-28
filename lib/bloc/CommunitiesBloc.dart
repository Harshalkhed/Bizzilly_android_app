import 'dart:convert';
import 'package:bizzilly/providers/ApiProvider.dart';
import 'package:bizzilly/repositories/Repositories.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class CommunitiesBloc {
  final storage = FlutterSecureStorage();
  Repositories repositories = Repositories();
  ApiProvider apiProvider = ApiProvider();
  getCommunities() async {    
      if(await storage.read(key: 'communities') == null)
      {
        List list = [];
        list = json.decode(await apiProvider.getCommunitiesAndCategoriesCom());
        return list;                
      }
      else 
      {
        List list = [];
        list = json.decode(await storage.read(key: "communities"));
        return list;
      }      
    }      
}

final communitiesBloc = CommunitiesBloc();
