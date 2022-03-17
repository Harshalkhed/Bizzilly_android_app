//Model class for storing community data
class CommunitiesModel {
  final String _id;
  final String name;
  final String devnagariText;
  final List categories;
  //constructor
  CommunitiesModel(this._id, this.name, this.devnagariText, this.categories);

  //Factory method for parsing JSON
  CommunitiesModel.fromJson(Map<String, dynamic> json)
      : _id = json['_id'],
        name = json['name'],
        devnagariText = json['devnagari_text'],
        categories = json['categories'];

  //Factory method for converting to JSON
  Map<String, dynamic> toJson() => {
        '_id': _id,
        'name': name,
        'devnagari_text': devnagariText,
        'categories': categories
      };
}
