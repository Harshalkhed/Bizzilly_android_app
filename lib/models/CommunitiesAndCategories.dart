import 'package:bizzilly/models/CategoriesModel.dart';
import 'package:bizzilly/models/CommunitiesModel.dart';

import 'CommunitiesModel.dart';

class CommunitiesAndCategories {
  final String state;
  final List<CommunitiesModel> communities;
  final List<CategoriesModel> categories;

  CommunitiesAndCategories(this.state, this.communities, this.categories);

  CommunitiesAndCategories.fromJson(Map<String, dynamic> json)
      : state = json['state'],
        communities = json['communities'],
        categories = json['categories'];

  Map<String, dynamic> toJson() =>
      {'state': state, 'communities': communities, 'categories': categories};
}
