import 'dart:convert';

import 'package:bizzilly/models/BusinessesModel.dart';
import 'package:bizzilly/models/CategoriesModel.dart';
import 'package:bizzilly/models/CommunitiesModel.dart';
import 'package:bizzilly/utilities/constants.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

//class for storing API functions
class ApiProvider {
  final storage = FlutterSecureStorage();

  // API function for login
  //METHOD : POST
  Future<String> checkLogin(String email, String password) async {
    var resp;
    try {
      http.Response response = await http.post(BASE_URL + "users/login",
          body: {'email': email, 'password': password});
      print(response.body);

      if (response.statusCode == 200) {
        var decRes = json.decode(response.body);
        if (decRes['state'] == 'success') {
          await storage.write(key: "token", value: decRes['token']);
          var categories = decRes['categories']
              .map((val) => CategoriesModel.fromJson(val))
              .toList();
          var communities = decRes['communities']
              .map((val) => CommunitiesModel.fromJson(val))
              .toList();
          print(categories);
          print(communities);
          await storage.write(
              key: 'categories', value: json.encode(categories));
          await storage.write(
              key: 'favorites', value: json.encode(decRes['favorites']));
          await storage.write(
              key: 'communities', value: json.encode(communities));
          resp = decRes['state'];
        } else {
          resp = decRes['msg'];
        }
        return resp;
      } else {
        //return 'fail';
      }
    } catch (err) {
      print(err.toString());
    }
    return resp;
  }

  //API function for registering user
  //METHOD : POST
  Future<String> registerUSer(
      String name, String email, String password) async {
    var msg;
    try {
      print(name);
      print(email);
      print(password);

      http.Response response = await http.post(BASE_URL + "users/register",
          body: {'name': name, 'email': email, 'password': password});
      print(response.body);
      if (response.statusCode == 200) {
        var decRes = json.decode(response.body);
        if (decRes['state'] == 'success') {
          return 'success';
        } else {
          msg = decRes['msg'];
        }
      } else {
        msg = '';
      }
    } catch (err) {
      print(err.toString());
    }
    return msg;
  }

  //API function for getting communities and categories
  //METHOD : GET
  Future getCommunitiesAndCategories() async {
    try {
      print("inhere com and cat");

      // var token = await storage.read(key: "token");
      // print(token);
      http.Response response = await http.get(
        BASE_URL + "users/get_communities_and_categories",
        // headers: {'Authorization': 'Bearer ' + token}
      );
      print(response.body);
      if (response.statusCode == 200) {
        final decRes = json.decode(response.body);
        if (decRes['state'] == 'success') {
          var categories = decRes['categories']
              .map((val) => CategoriesModel.fromJson(val))
              .toList();
          var communities = decRes['communities']
              .map((val) => CommunitiesModel.fromJson(val))
              .toList();
          print(categories);
          print(communities);
          await storage.write(
              key: 'categories', value: json.encode(categories));
          await storage.write(
              key: 'favorites', value: json.encode(decRes['favorites']));
          await storage.write(
              key: 'communities', value: json.encode(communities));
        } else {}
      } else {}
    } catch (err) {
      print(err.toString());
    }
  }

  //Alternative API function for getting communities and categories
  //METHOD : GET
  Future<String> getCommunitiesAndCategoriesCom() async {
    var resp;
    try {
      print("inhere com and cat");

      // var token = await storage.read(key: "token");
      // print(token);
      http.Response response = await http.get(
        BASE_URL + "users/get_communities_and_categories",
        // headers: {'Authorization': 'Bearer ' + token}
      );
      print(response.body);
      if (response.statusCode == 200) {
        final decRes = json.decode(response.body);
        if (decRes['state'] == 'success') {
          var categories = decRes['categories']
              .map((val) => CategoriesModel.fromJson(val))
              .toList();
          var communities = decRes['communities']
              .map((val) => CommunitiesModel.fromJson(val))
              .toList();
          print(categories);
          print(communities);
          await storage.write(
              key: 'categories', value: json.encode(categories));
          await storage.write(
              key: 'favorites', value: json.encode(decRes['favorites']));
          await storage.write(
              key: 'communities', value: json.encode(communities));
          resp = json.encode(communities);
        } else {
          resp = "";
        }
      } else {}
    } catch (err) {
      print(err.toString());
    }
    return resp;
  }

  //Alternative API function for getting communities and categories
  //METHOD : GET
  Future<String> getCommunitiesAndCategoriesCat() async {
    var resp;
    try {
      print("inhere com and cat");

      // var token = await storage.read(key: "token");
      // print(token);
      http.Response response = await http.get(
        BASE_URL + "users/get_communities_and_categories",
        // headers: {'Authorization': 'Bearer ' + token}
      );
      print(response.body);
      if (response.statusCode == 200) {
        final decRes = json.decode(response.body);
        if (decRes['state'] == 'success') {
          var categories = decRes['categories']
              .map((val) => CategoriesModel.fromJson(val))
              .toList();
          var communities = decRes['communities']
              .map((val) => CommunitiesModel.fromJson(val))
              .toList();
          print(categories);
          print(communities);
          await storage.write(
              key: 'categories', value: json.encode(categories));
          await storage.write(
              key: 'favorites', value: json.encode(decRes['favorites']));
          await storage.write(
              key: 'communities', value: json.encode(communities));
          resp = json.encode(categories);
        } else {
          resp = "";
        }
      } else {}
    } catch (err) {
      print(err.toString());
    }
    return resp;
  }

  //API method for changing password ( get user email )
  //METHOD : POST
  Future<String> getUserEmailChangePassword(String email) async {
    var resp;
    try {
      print(email);
      http.Response response = await http.post(
          BASE_URL + "users/get_email_change_password",
          body: {'email': email});
      print(response.body);
      if (response.statusCode == 200) {
        var decRes = json.decode(response.body);
        if (decRes['state'] == 'success') {
          return 'success';
        } else {
          resp = decRes['msg'];
        }
      } else {
        resp = 'fail';
      }
    } catch (err) {
      print(err.toString());
    }
    return resp;
  }

  //API function for changing password ( verify code )
  //METHOD : POST
  Future<String> verifyCodeChangePassword(String email, String code) async {
    var resp;
    try {
      http.Response response = await http.post(
          BASE_URL + "users/verify_otp_forgot_password",
          body: {'email': email, 'otp': code});
      print(response.body);
      if (response.statusCode == 200) {
        var decRes = json.decode(response.body);
        if (decRes['state'] == 'success') {
          return 'success';
        } else {
          resp = decRes['msg'];
        }
      } else {
        resp = 'fail';
      }
    } catch (err) {
      print(err.toString());
    }
    return resp;
  }

  //API function for changing password ( get user email )
  //METHOD : POST
  Future<String> changePassword(String email, String password) async {
    var resp;
    try {
      http.Response response = await http.post(
          BASE_URL + "users/change_password",
          body: {'email': email, 'password': password});
      print(response.body);
      if (response.statusCode == 200) {
        var decRes = json.decode(response.body);
        if (decRes['state'] == 'success') {
          return 'success';
        } else {
          resp = decRes['msg'];
        }
      } else {
        resp = 'fail';
      }
    } catch (err) {
      print(err.toString());
    }
    return resp;
  }

  //API function for getting businesses in the near by location
  //METHOD : POST
  Future<List> getBusinessesList(
      category, latitude, longitude, community, subCategory) async {
    var resp;
    try {
      print("Category" + category);
      print("Community" + community);
      print("Subcategory" + subCategory);
      print("latitude" + latitude.toString());
      print("longitude" + longitude.toString());
      http.Response response =
          await http.post(BASE_URL + "users/get_businesses", body: {
        'category': category,
        'latitude': latitude.toString(),
        'longitude': longitude.toString(),
        'community': community,
        'subCategory': subCategory
      });
      print(response.body);
      if (response.statusCode == 200) {
        var decRes = json.decode(response.body);
        if (decRes['state'] == 'success') {
          if (decRes['data'].length == 0) {
            resp = [];
          } else {
            var list = decRes['data']
                .map((val) => BusinessesModel.fromJson(val))
                .toList();
            resp = list;
          }
        } else {
          resp = [];
        }
      } else {}
    } catch (err) {
      print(err.toString());
    }
    return resp;
  }

  //API function for getting vendors list
  //METHOD : POST
  Future<List> getVendorsMobile(latitude, longitude) async {
    var resp;
    try {
      http.Response response = await http
          .post(BASE_URL + 'vendors/get_vendors_mobile', body: {
        'latitude': latitude.toString(),
        'longitude': longitude.toString()
      });
      print(response.body);
      if (response.statusCode == 200) {
        var decodedResponse = json.decode(response.body);
        if (decodedResponse['state'] == 'success') {
          if (decodedResponse['data'].length == 0) {
            resp = [];
          } else {
            var list = decodedResponse['data']
                .map((val) => BusinessesModel.fromJson(val))
                .toList();
            resp = list;
          }
        } else {
          resp = [];
        }
      }
    } catch (err) {
      print(err.toString());
    }
    return resp;
  }

  //API function for verifying email
  //METHOD : POST
  Future<String> verifyEmail(email, code) async {
    var resp;
    try {
      print(email);
      print(code);
      http.Response response = await http.post(BASE_URL + 'users/verify_user',
          body: {'email': email, 'code': code});
      print(response.body);
      if (response.statusCode == 200) {
        var decRes = json.decode(response.body);
        if (decRes['state'] == 'success') {
          resp = 'success';
        } else {
          resp = decRes['msg'];
        }
      } else {
        resp = 'fail';
      }
    } catch (err) {
      print(err.toString());
    }
    return resp;
  }

  //API function for updating favourites
  //METHOD : POST
  Future<String> updateFavourites(id, action) async {
    var resp;
    try {
      final storage = FlutterSecureStorage();
      var token = await storage.read(key: 'token');
      http.Response response = await http.post(
          BASE_URL + "users/update_favorites",
          body: {'id': id, 'action': action},
          headers: {'Authorization': 'Bearer ' + token});
      print(response.body);
      if (response.statusCode == 200) {
        var decRes = json.decode(response.body);

        await storage.write(
            key: 'favorites', value: json.encode(decRes['data']));
        resp = 'success';
      } else {
        resp = 'fail';
      }
    } catch (err) {
      print(err.toString());
    }
    return resp;
  }

  //API function for getting only communities
  //METHOD : GET
  Future<List> getCommunities() async {
    var resp;
    try {
      http.Response response =
          await http.get(BASE_URL + "communities/get_communities");
      print(response.body);
      if (response.statusCode == 200) {
        var decRes = json.decode(response.body);
        if (decRes['state'] == 'success') {
          resp = decRes['data'];
        } else {
          resp = [];
        }
      } else {
        resp = 'fail';
      }
    } catch (err) {
      print(err.toString());
    }
    return resp;
  }

  //API function for posting suggestions
  //METHOD : POST
  Future<String> postSuggestion(name, email, message) async {
    try {
      http.Response response = await http.post(
          BASE_URL + 'users/post_suggestion',
          body: {'email': email, 'name': name, 'message': message});
      var decodedResponse = json.decode(response.body);
      if (response.statusCode == 200) {
        if (decodedResponse['state'] == 'success') {
          return 'success';
        } else {
          return 'fail';
        }
      } else {
        return 'fail';
      }
    } catch (err) {
      print(err.toString());
    }
  }
}
