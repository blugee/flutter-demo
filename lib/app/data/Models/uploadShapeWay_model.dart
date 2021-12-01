class UploadModel {
  String result;
  int modelId;
  int modelVersion;
  String title;
  String fileName;
  int contentLength;
  String fileMd5Checksum;
  String description;
  bool isPublic;
  bool isClaimable;
  bool isForSale;
  bool isDownloadable;
  String secretKey;
  String claimKey;
  String defaultMaterialId;
  Urls urls;
  String spin;
  String defaultImage;
  String printable;
  NextActionSuggestions nextActionSuggestions;

  UploadModel(
      {this.result,
      this.modelId,
      this.modelVersion,
      this.title,
      this.fileName,
      this.contentLength,
      this.fileMd5Checksum,
      this.description,
      this.isPublic,
      this.isClaimable,
      this.isForSale,
      this.isDownloadable,
      this.secretKey,
      this.claimKey,
      this.defaultMaterialId,
      this.urls,
      this.spin,
      this.defaultImage,
      this.printable,
      this.nextActionSuggestions});

  UploadModel.fromJson(Map<String, dynamic> json) {
    result = json['result'];
    modelId = json['modelId'];
    modelVersion = json['modelVersion'];
    title = json['title'];
    fileName = json['fileName'];
    contentLength = json['contentLength'];
    fileMd5Checksum = json['fileMd5Checksum'];
    description = json['description'];
    isPublic = json['isPublic'];
    isClaimable = json['isClaimable'];
    isForSale = json['isForSale'];
    isDownloadable = json['isDownloadable'];
    secretKey = json['secretKey'];
    claimKey = json['claimKey'];
    defaultMaterialId = json['defaultMaterialId'];
    urls = json['urls'] != null ? new Urls.fromJson(json['urls']) : null;
    spin = json['spin'];
    defaultImage = json['defaultImage'];
    printable = json['printable'];
    nextActionSuggestions = json['nextActionSuggestions'] != null
        ? new NextActionSuggestions.fromJson(json['nextActionSuggestions'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['result'] = this.result;
    data['modelId'] = this.modelId;
    data['modelVersion'] = this.modelVersion;
    data['title'] = this.title;
    data['fileName'] = this.fileName;
    data['contentLength'] = this.contentLength;
    data['fileMd5Checksum'] = this.fileMd5Checksum;
    data['description'] = this.description;
    data['isPublic'] = this.isPublic;
    data['isClaimable'] = this.isClaimable;
    data['isForSale'] = this.isForSale;
    data['isDownloadable'] = this.isDownloadable;
    data['secretKey'] = this.secretKey;
    data['claimKey'] = this.claimKey;
    data['defaultMaterialId'] = this.defaultMaterialId;
    if (this.urls != null) {
      data['urls'] = this.urls.toJson();
    }
    data['spin'] = this.spin;
    data['defaultImage'] = this.defaultImage;
    data['printable'] = this.printable;
    if (this.nextActionSuggestions != null) {
      data['nextActionSuggestions'] = this.nextActionSuggestions.toJson();
    }
    return data;
  }
}

class Urls {
  PrivateProductUrl privateProductUrl;
  PrivateProductUrl publicProductUrl;
  PrivateProductUrl editModelUrl;
  PrivateProductUrl editProductDetailsUrl;

  Urls(
      {this.privateProductUrl,
      this.publicProductUrl,
      this.editModelUrl,
      this.editProductDetailsUrl});

  Urls.fromJson(Map<String, dynamic> json) {
    privateProductUrl = json['privateProductUrl'] != null
        ? new PrivateProductUrl.fromJson(json['privateProductUrl'])
        : null;
    publicProductUrl = json['publicProductUrl'] != null
        ? new PrivateProductUrl.fromJson(json['publicProductUrl'])
        : null;
    editModelUrl = json['editModelUrl'] != null
        ? new PrivateProductUrl.fromJson(json['editModelUrl'])
        : null;
    editProductDetailsUrl = json['editProductDetailsUrl'] != null
        ? new PrivateProductUrl.fromJson(json['editProductDetailsUrl'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.privateProductUrl != null) {
      data['privateProductUrl'] = this.privateProductUrl.toJson();
    }
    if (this.publicProductUrl != null) {
      data['publicProductUrl'] = this.publicProductUrl.toJson();
    }
    if (this.editModelUrl != null) {
      data['editModelUrl'] = this.editModelUrl.toJson();
    }
    if (this.editProductDetailsUrl != null) {
      data['editProductDetailsUrl'] = this.editProductDetailsUrl.toJson();
    }
    return data;
  }
}

class PrivateProductUrl {
  String address;

  PrivateProductUrl({this.address});

  PrivateProductUrl.fromJson(Map<String, dynamic> json) {
    address = json['address'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['address'] = this.address;
    return data;
  }
}

class NextActionSuggestions {
  GetModel getModel;
  GetModel downloadModel;
  GetModel updateModelDetails;
  GetModel updateModelFile;
  GetModel addModelPhoto;

  NextActionSuggestions(
      {this.getModel,
      this.downloadModel,
      this.updateModelDetails,
      this.updateModelFile,
      this.addModelPhoto});

  NextActionSuggestions.fromJson(Map<String, dynamic> json) {
    getModel = json['getModel'] != null
        ? new GetModel.fromJson(json['getModel'])
        : null;
    downloadModel = json['downloadModel'] != null
        ? new GetModel.fromJson(json['downloadModel'])
        : null;
    updateModelDetails = json['updateModelDetails'] != null
        ? new GetModel.fromJson(json['updateModelDetails'])
        : null;
    updateModelFile = json['updateModelFile'] != null
        ? new GetModel.fromJson(json['updateModelFile'])
        : null;
    addModelPhoto = json['addModelPhoto'] != null
        ? new GetModel.fromJson(json['addModelPhoto'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.getModel != null) {
      data['getModel'] = this.getModel.toJson();
    }
    if (this.downloadModel != null) {
      data['downloadModel'] = this.downloadModel.toJson();
    }
    if (this.updateModelDetails != null) {
      data['updateModelDetails'] = this.updateModelDetails.toJson();
    }
    if (this.updateModelFile != null) {
      data['updateModelFile'] = this.updateModelFile.toJson();
    }
    if (this.addModelPhoto != null) {
      data['addModelPhoto'] = this.addModelPhoto.toJson();
    }
    return data;
  }
}

class GetModel {
  String method;
  String restUrl;
  String link;

  GetModel({this.method, this.restUrl, this.link});

  GetModel.fromJson(Map<String, dynamic> json) {
    method = json['method'];
    restUrl = json['restUrl'];
    link = json['link'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['method'] = this.method;
    data['restUrl'] = this.restUrl;
    data['link'] = this.link;
    return data;
  }
}
