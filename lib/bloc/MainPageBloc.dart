import 'package:bizzilly/repositories/Repositories.dart';
import 'package:rxdart/rxdart.dart';

class MainPageBloc {
  final respository = Repositories();
  final category = BehaviorSubject<String>();
  final latitude = BehaviorSubject<double>();
  final longitude = BehaviorSubject<double>();
  final community = BehaviorSubject<String>();
  final subCategory = BehaviorSubject<String>();

  Function get getCategory => category.sink.add;
  Function get getLatitude => latitude.sink.add;
  Function get getLongitude => longitude.sink.add;
  Function get getSubCategory => subCategory.sink.add;

  Function get getCommunity => community.sink.add;

  Future<List> getBusinessesList() {
    return respository.getBusinessesList(category.value, latitude.value,
        longitude.value, community.value, subCategory.value);
  }

  void dispose() {
    category.close();
    latitude.close();
    longitude.close();
    community.close();
    subCategory.close();
  }
}

final mainPageBLoc = MainPageBloc();
