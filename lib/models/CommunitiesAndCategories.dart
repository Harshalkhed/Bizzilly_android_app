import 'package:bizzilly/models/CategoriesModel.dart';
import 'package:bizzilly/models/CommunitiesModel.dart';

import 'CommunitiesModel.dart';

//Model class for storing community and category data
class CommunitiesAndCategories {
  final String state;
  final List<CommunitiesModel> communities;
  final List<CategoriesModel> categories;

  //constructor
  CommunitiesAndCategories(this.state, this.communities, this.categories);

  //Factory method for parsing JSON
  CommunitiesAndCategories.fromJson(Map<String, dynamic> json)
      : state = json['state'],
        communities = json['communities'],
        categories = json['categories'];

  //Factory method for converting to JSON
  Map<String, dynamic> toJson() =>
      {'state': state, 'communities': communities, 'categories': categories};
}
