import 'dart:async';

import 'package:get_storage/get_storage.dart';
import 'package:mocci/app/data/Repository/repository.dart';

class LocalStorage {
  LocalStorage._internal();
  static final LocalStorage _instance = LocalStorage._internal();
  factory LocalStorage() => _instance;

  GetStorage storage = GetStorage();
  final repo = Repository();

  TOKEN() => storage.read('token');
  IS_LOGIN() => storage.read('isLoggedIn');
  FIRST_NAME() => storage.read('name');
  LAST_NAME() => storage.read('lastName');
  EMAIL() => storage.read('email');
  ACCESS_TOKEN() => storage.read('accessToken');

  deleteAccessToken() => Timer(Duration(seconds: 25), () {
        storage.remove('accessToken');
        print('Access Token Removed');
        repo.getAccessToken();
      });
}
