//Model class for storing favourites
class FavouritesModel {
  final String _id;
  final String language;
  final String category;
  final String organizationName;
  final String address;
  final String contact;
  final String email;
  final String rating;

  //constructor
  FavouritesModel(this._id, this.language, this.category, this.organizationName,
      this.address, this.contact, this.email, this.rating);

  //Factory method for parsing JSON
  FavouritesModel.fromJson(Map<String, dynamic> json)
      : _id = json['_id'],
        language = json['langugage'],
        category = json['category'],
        organizationName = json['organization_name'],
        address = json['address'],
        contact = json['contact'],
        email = json['email'],
        rating = json['rating'];

  //Factory method for converting to JSON
  Map<String, dynamic> toJson() => {
        '_id': _id,
        'language': language,
        'category': category,
        'organization_name': organizationName,
        'address': address,
        'contact': contact,
        'email': email,
        'rating': rating
      };
}
