import 'branch_model.dart';
import 'user_model.dart';

class ProjectModel {
  int? id;
  String? name;
  String? customerName;
  String? customerPhone;
  String? customerEmail;
  String? customerAddress;
  String? cpName;
  String? cpPosition;
  String? cpPhone;
  String? amount;
  String? status;
  BranchModel? branch;
  UserModel? sales;

  ProjectModel({
    this.id,
    this.name,
    this.customerName,
    this.customerPhone,
    this.customerEmail,
    this.customerAddress,
    this.cpName,
    this.cpPosition,
    this.cpPhone,
    this.amount,
    this.status,
    this.branch,
    this.sales,
    });

  ProjectModel.fromJson(Map<String, dynamic> json) {
    id = json['id'] != null ? int.parse(json['id'].toString()) : null;
    name = json['name'] ?? '';
    customerName = json['customer_name'] ?? '';
    customerPhone = json['customer_phone'] ?? '';
    customerEmail = json['customer_email'] ?? '';
    customerAddress = json['customer_address'] ?? '';
    cpName = json['cp_name'] ?? '';
    cpPosition = json['cp_position'] ?? '';
    cpPhone = json['cp_phone'] ?? '-';
    amount = json['amount'].toString();
    status = json['status'] ?? '-';
    branch = json['branch'] != null ? BranchModel.fromJson(json['branch']) : null;
    sales = json['sales'] != null ? UserModel.fromJson(json['sales']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['customerName'] = customerName;
    data['customerPhone'] = customerPhone;
    data['customerEmail'] = customerEmail;
    data['customerAddress'] = customerAddress;
    data['cpName'] = cpName;
    data['cpPosition'] = cpPosition;
    data['cpPhone'] = cpPhone;
    data['amount'] = amount;
    data['status'] = status;
    if (branch != null) {
      data['branch'] = branch!.toJson();
    }
    if (sales != null) {
      data['sales'] = sales!.toJson();
    }
    return data;
  }

  static List<ProjectModel> fromJsonList(List list) {
    return list.map((item) => ProjectModel.fromJson(item)).toList();
  }
}
