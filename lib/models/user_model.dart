import 'branch_model.dart';

class UserModel {
  int? id;
  String? name;
  String? avatar;
  String? tingkat;
  String? phone;
  String? token;
  BranchModel? branch;

  UserModel({
    this.id,
    this.name,
    this.avatar,
    this.phone,
    this.token,
    this.branch,
  });

  UserModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    avatar = json['avatar'];
    phone = json['phone'] != null ? json['phone'].toString() : "";
    token = json['token'];
    branch = json['branch'] != null ? BranchModel.fromJson(json['branch']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['avatar'] = avatar;
    data['phone'] = phone;
    if (branch != null) {
      data['branch'] = branch!.toJson();
    }
    return data;
  }
}