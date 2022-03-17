//Model class for holding cache data

class CacheModel {  
  final String data;
  final String ctx;

  //constructor
  CacheModel({this.data, this.ctx});
  
  //method for generating a map 
  Map<String, dynamic> toMap() {
    return {      
      'data': data,
      'ctx': ctx,
    };
  }
}