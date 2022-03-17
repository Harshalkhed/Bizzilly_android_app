//Model class for storing category data
class CategoriesModel {
  final String _id;
  final String name;
  final String image;
  final List subcategories;

  //constuctor
  CategoriesModel(this._id, this.name, this.image, this.subcategories);

  //Factory method for parsing JSON
  CategoriesModel.fromJson(Map<String, dynamic> json)
      : _id = json['_id'],
        name = json['name'],
        image = json['image'],
        subcategories = json['subcategories'];

//Factory method for converting to JSON
  Map<String, dynamic> toJson() => {
        '_id': _id,
        'name': name,
        'image': image,
        'subcategories': subcategories
      };
}
