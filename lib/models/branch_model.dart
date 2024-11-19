class BranchModel {
  int? id;
  String? name;

  BranchModel({
    this.id,
    this.name,
  });

  BranchModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    return data;
  }

  
  static List<BranchModel> fromJsonList(List list) {
    return list.map((item) => BranchModel.fromJson(item)).toList();
  }

  
  String userAsString() {
    return '#$id $name';
  }

  bool isEqual(BranchModel model) {
    return id == model.id;
  }
}
