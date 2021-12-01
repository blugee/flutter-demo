import 'package:equatable/equatable.dart';

class ShapewayMaterials extends Equatable {
  String _materialId;
  String _title;
  bool _supportsColorFiles;
  String _printerId;
  String _swatch;
  dynamic _restrictions;

  String get materialId => _materialId;
  String get title => _title;
  bool get supportsColorFiles => _supportsColorFiles;
  String get printerId => _printerId;
  String get swatch => _swatch;
  dynamic get restrictions => _restrictions;

  set materialId(String value) {
    _materialId = value;
  }

  ShapewayMaterials(
      {String materialId,
      String title,
      bool supportsColorFiles,
      String printerId,
      String swatch,
      dynamic restrictions}) {
    _materialId = materialId;
    _title = title;
    _supportsColorFiles = supportsColorFiles;
    _printerId = printerId;
    _swatch = swatch;
    _restrictions = restrictions;
  }

  ShapewayMaterials.fromJson(dynamic json) {
    _materialId = json['materialId'];
    _title = json['title'];
    _supportsColorFiles = json['supportsColorFiles'];
    _printerId = json['printerId'];
    _swatch = json['swatch'];
    _restrictions = json['restrictions'];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map['materialId'] = _materialId;
    map['title'] = _title;
    map['supportsColorFiles'] = _supportsColorFiles;
    map['printerId'] = _printerId;
    map['swatch'] = _swatch;
    map['restrictions'] = _restrictions;
    return map;
  }

  @override
  // TODO: implement props
  List<Object> get props =>
      [materialId, title, _supportsColorFiles, printerId, swatch, restrictions];

  set title(String value) {
    _title = value;
  }

  set restrictions(dynamic value) {
    _restrictions = value;
  }

  set swatch(String value) {
    _swatch = value;
  }

  set printerId(String value) {
    _printerId = value;
  }

  set supportsColorFiles(bool value) {
    _supportsColorFiles = value;
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      super == other &&
          other is ShapewayMaterials &&
          runtimeType == other.runtimeType &&
          _materialId == other._materialId &&
          _title == other._title &&
          _supportsColorFiles == other._supportsColorFiles &&
          _printerId == other._printerId &&
          _swatch == other._swatch &&
          _restrictions == other._restrictions;

  @override
  int get hashCode =>
      super.hashCode ^
      _materialId.hashCode ^
      _title.hashCode ^
      _supportsColorFiles.hashCode ^
      _printerId.hashCode ^
      _swatch.hashCode ^
      _restrictions.hashCode;
}
