class CacheModel {  
  final String data;
  final String ctx;

  CacheModel({this.data, this.ctx});
  
  Map<String, dynamic> toMap() {
    return {      
      'data': data,
      'ctx': ctx,
    };
  }
}