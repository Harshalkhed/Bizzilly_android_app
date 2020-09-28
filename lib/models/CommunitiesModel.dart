class CommunitiesModel {
  final String _id;
  final String name;
  final String devnagariText;
  final List categories;

  CommunitiesModel(this._id, this.name, this.devnagariText,this.categories);

  CommunitiesModel.fromJson(Map<String, dynamic> json)
      : _id = json['_id'],
        name = json['name'],
        devnagariText = json['devnagari_text'],
        categories = json['categories'];

  Map<String, dynamic> toJson() =>
      {'_id': _id, 'name': name, 'devnagari_text': devnagariText,'categories':categories};

      
}
