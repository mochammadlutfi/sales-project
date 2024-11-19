import 'package:get_storage/get_storage.dart';

import '../models/user_model.dart';

mixin CacheManager {
  Future<bool> saveToken(String? token) async {
    final box = GetStorage();
    await box.write(CacheManagerKey.token.toString(), token);
    return true;
  }

  String? getToken() {
    final box = GetStorage();
    return box.read(CacheManagerKey.token.toString());
  }

  Future<void> removeToken() async {
    final box = GetStorage();
    await box.remove(CacheManagerKey.token.toString());
  }

  
  Future<bool> saveUser(UserModel user) async {
    final box = GetStorage();
    await box.write('user', user.toJson());
    return true;
  }
  
  UserModel getUser() {
    final box = GetStorage();
    box.listen(() {});
    if (box.read("user") != null) {
      return UserModel.fromJson(box.read('user'));
    }else{
      return UserModel();
    }
  }  
  
  Future<void> removeUser() async {
    final box = GetStorage();
    await box.remove('user');
  }

  

}

enum CacheManagerKey { token }