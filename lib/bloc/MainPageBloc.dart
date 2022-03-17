import 'package:bizzilly/repositories/Repositories.dart';
import 'package:rxdart/rxdart.dart';

class MainPageBloc {
  //declaring variables
  final respository = Repositories();
  final category = BehaviorSubject<String>();
  final latitude = BehaviorSubject<double>();
  final longitude = BehaviorSubject<double>();
  final community = BehaviorSubject<String>();
  final subCategory = BehaviorSubject<String>();

  // 'get' functions
  Function get getCategory => category.sink.add;
  Function get getLatitude => latitude.sink.add;
  Function get getLongitude => longitude.sink.add;
  Function get getSubCategory => subCategory.sink.add;

  Function get getCommunity => community.sink.add;

  //method for getting businesses
  Future<List> getBusinessesList() {
    return respository.getBusinessesList(category.value, latitude.value,
        longitude.value, community.value, subCategory.value);
  }

  void dispose() {
    //close instances of all the subject variables
    category.close();
    latitude.close();
    longitude.close();
    community.close();
    subCategory.close();
  }
}

//this instance can be accessed directly from anywhere
final mainPageBLoc = MainPageBloc();
