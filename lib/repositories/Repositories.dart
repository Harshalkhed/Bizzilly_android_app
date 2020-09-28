import 'package:bizzilly/providers/ApiProvider.dart';

class Repositories {
  final apiProvider = ApiProvider();
  // login
  Future<String> checkLogin(email, password) =>
      apiProvider.checkLogin(email, password);

  //registration
  Future<String> registerUser(name, email, password) =>
      apiProvider.registerUSer(name, email, password);

  //change password( get user email )
  Future<String> getUserEmail(email) =>
      apiProvider.getUserEmailChangePassword(email);

  //change password( verify code )
  Future<String> verifyCode(email, code) =>
      apiProvider.verifyCodeChangePassword(email, code);

  //verify user email

  Future<String> verifyEmail(email, code) =>
      apiProvider.verifyEmail(email, code);

  //change password( get user email )
  Future<String> changePassword(email, password) =>
      apiProvider.changePassword(email, password);

  //get businesses list
  Future<List> getBusinessesList(category, latitude, longitude, community,subCategory) =>
      apiProvider.getBusinessesList(category, latitude, longitude, community,subCategory);

  Future getCommunitiesAndCategories() =>
      apiProvider.getCommunitiesAndCategories();

  Future<String> updateFavorites(id,action) => apiProvider.updateFavourites(id,action);

  Future<String> postSuggestion(name,email,message)=> apiProvider.postSuggestion(name, email, message);
}
