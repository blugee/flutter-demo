class SignUpModel {
  bool _status;
  Result _result;
  String _message;
  String _version;

  bool get status => _status;
  Result get result => _result;
  String get message => _message;
  String get version => _version;

  SignUpModel({bool status, Result result, String message, String version}) {
    _status = status;
    _result = result;
    _message = message;
    _version = version;
  }

  SignUpModel.fromJson(dynamic json) {
    _status = json['status'];
    _result = json['result'] != null ? Result.fromJson(json['result']) : null;
    _message = json['message'];
    _version = json['version'];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map['status'] = _status;
    if (_result != null) {
      map['result'] = _result.toJson();
    }
    map['message'] = _message;
    map['version'] = _version;
    return map;
  }
}

class Result {
  String _token;

  String get token => _token;

  Result({String token}) {
    _token = token;
  }

  Result.fromJson(dynamic json) {
    _token = json['token'];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map['token'] = _token;
    return map;
  }
}
