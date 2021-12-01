import 'package:mocci/app/data/Models/getProducts_Model.dart';
import 'package:mocci/app/data/Models/login_Model.dart';
import 'package:mocci/app/data/Models/signUp_Model.dart';
import 'package:mocci/app/data/Models/uploadShapeWay_model.dart';
import 'package:mocci/app/data/Provider/provider.dart';
import 'package:mocci/app/data/Models/token_getter_model.dart';
import 'package:mocci/app/data/Models/shape_way_materials.dart';

class Repository {
  ApiProvider provider = ApiProvider();

  Future<LoginModel> loginAPI({String loginEmail, String loginPass}) =>
      provider.loginPost(loginEmail, loginPass);

  Future<TokenGetterModel> getAccessToken() => provider.reqAccessToken();

  Future<SignUpModel> signUpAPI(
          {String firstName, String lastName, String email, String pass}) =>
      provider.signUpPost(firstName, lastName, email, pass);

  Future getMaterialsFromShapeway(accessToken) =>
      provider.getMaterials(accessToken);

  // Future<UploadModel> uploadShapeWayModel(
  //         String fileName, String file, int materialId) =>
  //     provider.uploadModelToShapeWay(fileName, file, materialId);
}
