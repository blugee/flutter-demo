import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:mocci/app/data/LocalStorage/localStorage.dart';
import 'package:mocci/app/data/Models/getProducts_Model.dart';
import 'package:mocci/app/data/Models/login_Model.dart';
import 'package:mocci/app/data/Models/signUp_Model.dart';
import 'package:mocci/app/data/Models/uploadShapeWay_model.dart';
import 'package:mocci/app/data/constants.dart';
import 'package:mocci/app/global_widgets/ui_widgets.dart';
import 'package:mocci/app/data/Models/token_getter_model.dart';
import 'package:mocci/app/data/Models/shape_way_materials.dart';

class ApiProvider {
  static String token = LocalStorage().TOKEN();
  static String accessToken = LocalStorage().ACCESS_TOKEN();
  var dio = Dio();

  // ApiProvider(this.dio);

  /// error Handler
  dynamic errorHandler(Response response) {
    print(response.toString());
    switch (response.statusCode) {
      case 200:
      case 201:
      case 202:
        var responseJson = response.data;
        return responseJson;
      case 500:
        throw "Server Error please retry later";
        return errorSnackbar("Server Error please retry later");
      case 403:
        throw 'Error occurred pls check internet and retry.';
        return errorSnackbar('Error occurred pls check internet and retry.');
      case 500:
      default:
        throw 'Error occurred retry';
        return errorSnackbar('Error occurred please retry');
    }
  }

  ///=========  LOGIN API============///
  Future<LoginModel> loginPost(String loginEmail, String loginPass) async {
    Response response = await dio.post(
        "${kApiTexts.BASE_URL}${kApiTexts.LOGIN}",
        data: {'emailId': loginEmail, 'password': loginPass},
        options: Options(headers: {"Content-Type": "application/json"}));
    var _body = json.encode(response.data);
    if (response.statusCode == 200) {
      LoginModel userToken = LoginModel.fromJson(jsonDecode(_body));
      print("${response.statusCode}\n${response.data}");
      return userToken;
    } else {
      return errorHandler(response);
    }
  }

  /// ===========SIGNUP API CALL===================//
  Future<SignUpModel> signUpPost(
      String firstName, String lastName, String email, String pass) async {
    Response response = await dio.post(
        "${kApiTexts.BASE_URL}${kApiTexts.SIGNUP}",
        data: {
          "firstName": firstName,
          "lastName": lastName,
          "emailId": email,
          "password": pass
        },
        options: Options(headers: {"Content-Type": "application/json"}));
    var _body = json.encode(response.data);
    if (response.statusCode == 200) {
      SignUpModel signUpModel = SignUpModel.fromJson(jsonDecode(_body));
      print("${response.statusCode}\n${response.data}");
      return signUpModel;
    } else {
      return errorHandler(response);
    }
  }

  ///GET PRODUCTS PAGINATION======================================================
  static Future<List<MyProduct>> getProductList(
    //String id,
    int page,
    int limit,
  ) async {
    try {
      final response = await http
          .get(Uri.parse('${kApiTexts.BASE_URL}${kApiTexts.GET_PRODUCT_LIST}?'
              'page=$page'
              '&limit=$limit'));
      if (response.statusCode == 200) {
        var list = GetProductsModel.fromJson(jsonDecode(response.body));
        return list.result.myProduct.sublist(2);
      } else {
        throw Exception('Unable to fetch product lists');
      }
    } on SocketException {
      throw SocketException('Socket Exception');
    }
  }

  ///
  /// shapeway req access token ///============================================================
  Future<TokenGetterModel> reqAccessToken() async {
    var headers = {
      'Content-Type': 'application/x-www-form-urlencoded',
    };
    var data =
        'grant_type=client_credentials&client_id=${ShapeWayApi.CLIENT_ID}&client_secret=${ShapeWayApi.CLIENT_SECRET}';

    var res = await dio.post(
        '${ShapeWayApi.BASE_URL}${ShapeWayApi.ACCESS_TOKEN}',
        options: Options(headers: headers),
        data: data);
    var _body = json.encode(res.data);
    if (res.statusCode == 200) {
      TokenGetterModel signUpModel =
          TokenGetterModel.fromJson(jsonDecode(_body));
      print("${res.statusCode}\n${res.data}");

      await LocalStorage()
          .storage
          .write('accessToken', signUpModel.accessToken);
      return signUpModel;
    }
    return errorHandler(res);
  }

  /// Get Material from Shapeway ///========================================================
  getMaterials(accessToken) async {
    await reqAccessToken();
    try {
      final res = await dio.get(
        '${ShapeWayApi.BASE_URL}${ShapeWayApi.GET_SHAPEWAY_MATERIALS}',
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $accessToken',
          },
        ),
      );
      if (res.statusCode == 200) {
        await LocalStorage().storage.write('materials', res.data);
      }
      return errorHandler(res);
    } on Exception catch (e) {
      throw Exception('${e.toString()}');
    }
  }

  ///=========================UPLOAD MODEL TO SHAPEWAY==========//////
  ///
  // Future<UploadModel> uploadModelToShapeWay(
  //     String fileName, String file, int materialId) async {
  //   Response response = await dio.post(
  //     "${ShapeWayApi.BASE_URL}${ShapeWayApi.UPLOAD_MODEL}",
  //     data: {
  //       "fileName": "${fileName}.stl",
  //       "file": file,
  //       "hasRightsToModel": 1,
  //       "acceptTermsAndConditions": 1,
  //       "isForSale": 1,
  //       "isDownloadable": 1,
  //       "defaultMaterialId": materialId,
  //     },
  //     options: Options(
  //       headers: {
  //         'Content-Type': 'application/json',
  //         'Authorization': 'Bearer $accessToken',
  //       },
  //     ),
  //   );
  //   var _body = json.encode(response.data);
  //   if (response.statusCode == 200) {
  //     UploadModel uploadModel = UploadModel.fromJson(jsonDecode(_body));
  //     print("${response.statusCode}\n${response.data}");
  //     return uploadModel;
  //   } else {
  //     return errorHandler(response);
  //   }
  // }
}

// class _ApiUrlBuilder {
//   static const _baseUrl = kApiTexts.BASE_URL;
//   static const _End_point = kApiTexts.GET_PRODUCT_LIST;
//
//   static Uri Url(
//     String id,
//     int page,
//     int limit,
//   ) {
//     if (id == null) {
//       return Uri.parse('$_baseUrl$_End_point?'
//           'page=$page'
//           '&limit=$limit');
//     } else {
//       return Uri.parse('$_baseUrl$_End_point?'
//           '_id=$id'
//           'page=$page'
//           '&limit=$limit');
//     }
//   }
// }
