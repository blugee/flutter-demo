class GetProductsModel {
  bool _status;
  Result _result;

  bool get status => _status;
  Result get result => _result;

  GetProductsModel({bool status, Result result}) {
    _status = status;
    _result = result;
  }

  GetProductsModel.fromJson(dynamic json) {
    _status = json['status'];
    _result = json['result'] != null ? Result.fromJson(json['result']) : null;
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map['status'] = _status;
    if (_result != null) {
      map['result'] = _result.toJson();
    }
    return map;
  }
}

class Result {
  List<MyProduct> _myProduct;
  int _page;
  int _limit;

  List<MyProduct> get myProduct => _myProduct;
  int get page => _page;
  int get limit => _limit;

  Result({List<MyProduct> myProduct, int page, int limit}) {
    _myProduct = myProduct;
    _page = page;
    _limit = limit;
  }

  Result.fromJson(dynamic json) {
    if (json['myProduct'] != null) {
      _myProduct = [];
      json['myProduct'].forEach((v) {
        _myProduct.add(MyProduct.fromJson(v));
      });
    }
    _page = json['page'];
    _limit = json['limit'];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    if (_myProduct != null) {
      map['myProduct'] = _myProduct.map((v) => v.toJson()).toList();
    }
    map['page'] = _page;
    map['limit'] = _limit;
    return map;
  }
}

class MyProduct {
  String _id;
  String _name;
  String _category;
  int _price;
  List<String> _productUrl;
  String _description;
  String _ip;
  String _userId;
  String _createdBy;
  String _updatedBy;
  int _createdOn;
  int _updatedOn;

  String get id => _id;
  String get name => _name;
  String get category => _category;
  int get price => _price;
  List<String> get productUrl => _productUrl;
  String get description => _description;
  String get ip => _ip;
  String get userId => _userId;
  String get createdBy => _createdBy;
  String get updatedBy => _updatedBy;
  int get createdOn => _createdOn;
  int get updatedOn => _updatedOn;

  MyProduct(
      {String id,
      String name,
      String category,
      int price,
      List<String> productUrl,
      String description,
      String ip,
      String userId,
      String createdBy,
      String updatedBy,
      int createdOn,
      int updatedOn}) {
    _id = id;
    _name = name;
    _category = category;
    _price = price;
    _productUrl = productUrl;
    _description = description;
    _ip = ip;
    _userId = userId;
    _createdBy = createdBy;
    _updatedBy = updatedBy;
    _createdOn = createdOn;
    _updatedOn = updatedOn;
  }

  MyProduct.fromJson(dynamic json) {
    _id = json['_id'];
    _name = json['name'];
    _category = json['category'];
    _price = json['price'];
    _productUrl =
        json['productUrl'] != null ? json['productUrl'].cast<String>() : [];
    _description = json['description'];
    _ip = json['ip'];
    _userId = json['userId'];
    _createdBy = json['createdBy'];
    _updatedBy = json['updatedBy'];
    _createdOn = json['createdOn'];
    _updatedOn = json['updatedOn'];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map['_id'] = _id;
    map['name'] = _name;
    map['category'] = _category;
    map['price'] = _price;
    map['productUrl'] = _productUrl;
    map['description'] = _description;
    map['ip'] = _ip;
    map['userId'] = _userId;
    map['createdBy'] = _createdBy;
    map['updatedBy'] = _updatedBy;
    map['createdOn'] = _createdOn;
    map['updatedOn'] = _updatedOn;
    return map;
  }
}
