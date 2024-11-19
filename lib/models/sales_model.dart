class SalesModel {
  int? id;
  String? name;
  int? branchId;

  SalesModel({
    this.id,
    this.name,
    this.branchId,
  });

  SalesModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    branchId = json['branch_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['branch_id'] = branchId;
    return data;
  }

  
  static List<SalesModel> fromJsonList(List list) {
    return list.map((item) => SalesModel.fromJson(item)).toList();
  }

  
  String userAsString() {
    return '#$id $name';
  }

  bool isEqual(SalesModel model) {
    return id == model.id;
  }
}
