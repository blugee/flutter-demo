class TokenGetterModel {
  String _accessToken;
  String _tokenType;
  int _expiresIn;

  String get accessToken => _accessToken;
  String get tokenType => _tokenType;
  int get expiresIn => _expiresIn;

  TokenGetterModel({String accessToken, String tokenType, int expiresIn}) {
    _accessToken = accessToken;
    _tokenType = tokenType;
    _expiresIn = expiresIn;
  }

  TokenGetterModel.fromJson(dynamic json) {
    _accessToken = json['access_token'];
    _tokenType = json['token_type'];
    _expiresIn = json['expires_in'];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map['access_token'] = _accessToken;
    map['token_type'] = _tokenType;
    map['expires_in'] = _expiresIn;
    return map;
  }
}
