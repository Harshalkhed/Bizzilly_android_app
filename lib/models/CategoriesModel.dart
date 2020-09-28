class CategoriesModel {
  final String _id;
  final String name;
  final String image;
  final List subcategories;

  CategoriesModel(this._id, this.name, this.image,this.subcategories);

  CategoriesModel.fromJson(Map<String, dynamic> json)
      : _id = json['_id'],
        name = json['name'],
        image = json['image'],
        subcategories = json['subcategories'];

  Map<String, dynamic> toJson() =>
      {'_id': _id, 'name': name, 'image': image,'subcategories':subcategories};
}
