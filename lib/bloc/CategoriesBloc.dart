import 'dart:convert';
import 'package:bizzilly/providers/ApiProvider.dart';
import 'package:bizzilly/repositories/Repositories.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class CategoriesBloc {
  //instance of FlutterSecureStorage
  final storage = FlutterSecureStorage();
  //instance of Repositories
  Repositories repositories = Repositories();
  //instance of ApiProvider
  ApiProvider apiProvider = ApiProvider();

  //method for getting categories
  //categories will be provided from local storage if present otherwise they will be returned from the server
  getCategories() async {
    if (await storage.read(key: 'categories') == null) {
      List list = [];
      list = json.decode(await apiProvider.getCommunitiesAndCategoriesCat());
      return list;
    } else {
      List list = [];
      list = json.decode(await storage.read(key: "categories"));
      return list;
    }
  }
}

//this instance can be accessed directly from anywhere
final categoriesBloc = CategoriesBloc();
