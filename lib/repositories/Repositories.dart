import 'package:bizzilly/providers/ApiProvider.dart';

class Repositories {
  final apiProvider = ApiProvider();
  // Repository method for login
  Future<String> checkLogin(email, password) =>
      apiProvider.checkLogin(email, password);

  // Repository method for registration
  Future<String> registerUser(name, email, password) =>
      apiProvider.registerUSer(name, email, password);

  // Repository method for getting user email
  Future<String> getUserEmail(email) =>
      apiProvider.getUserEmailChangePassword(email);

  // Repository method for verifying change password OTP
  Future<String> verifyCode(email, code) =>
      apiProvider.verifyCodeChangePassword(email, code);

  // Repository method for verifying user email
  Future<String> verifyEmail(email, code) =>
      apiProvider.verifyEmail(email, code);

  // Repository method for change password
  Future<String> changePassword(email, password) =>
      apiProvider.changePassword(email, password);

  //Repository method for getting businesses list
  Future<List> getBusinessesList(
          category, latitude, longitude, community, subCategory) =>
      apiProvider.getBusinessesList(
          category, latitude, longitude, community, subCategory);

  //Repository method for getting communities and categories list
  Future getCommunitiesAndCategories() =>
      apiProvider.getCommunitiesAndCategories();

//Repository method for updating favourites
  Future<String> updateFavorites(id, action) =>
      apiProvider.updateFavourites(id, action);

//Repository method for posting suggestion
  Future<String> postSuggestion(name, email, message) =>
      apiProvider.postSuggestion(name, email, message);
}
