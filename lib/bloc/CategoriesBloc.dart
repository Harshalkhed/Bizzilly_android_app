import 'dart:convert';
import 'package:bizzilly/providers/ApiProvider.dart';
import 'package:bizzilly/repositories/Repositories.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class CategoriesBloc {
  final storage = FlutterSecureStorage();
  Repositories repositories = Repositories();
  ApiProvider apiProvider = ApiProvider();
  getCategories() async {    
    if(await storage.read(key: 'categories') == null)
    {
       List list = [];
       list = json.decode(await apiProvider.getCommunitiesAndCategoriesCat());
       return list;
    }
    else 
    {
      List list = [];
      list = json.decode(await storage.read(key: "categories"));
      return list;
    }    
  }
}

final categoriesBloc = CategoriesBloc();
