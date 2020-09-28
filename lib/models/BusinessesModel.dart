class BusinessesModel {
  final String id;
  final String language;

  final String organizationName;
  final String address;

  final String contact;
  final String email;
  final String latitude;
  final String longitude;
  final String rating;  
  final String contactPersonName;
  final String image;

  var category;
  var community;

  BusinessesModel(
      this.id,
      this.language,
      this.organizationName,
      this.address,
      this.contact,
      this.email,
      this.rating,      
      this.contactPersonName,
      this.image,
      this.category,
      this.community,
      this.latitude,this.longitude);

  BusinessesModel.fromJson(Map<String, dynamic> json)
      : id = json['_id'],
        language = json['language'],
        organizationName = json['organization_name'],
        address = json['address'],
        contact = json['contact'],
        latitude = json['latitude'],
        longitude = json['longitude'],
        email = json['email'],
        rating = json['rating'],        
        contactPersonName = json['contact_person_name'],
        image = json['image'],
        category = json['category'],
        community = json['community'];

  Map<String, dynamic> toJson() => {
        'id': id,
        'language': language,
        'organization_name': organizationName,
        'address': address,
        'contact': contact,
        'email': email,
        'rating': rating,        
        'longitude': longitude,
        'latitude': latitude,
        'contact_person_name': contactPersonName,
        'image': image,
        'category': category,
        'community': community
      };
}
