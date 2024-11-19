class ContactModel {
  int? id;
  String? name;
  String? phone;

  ContactModel({
    this.id,
    this.name,
    this.phone,
  });

  ContactModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    phone = json['phone'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['phone'] = phone;
    return data;
  }

  
  static List<ContactModel> fromJsonList(List list) {
    return list.map((item) => ContactModel.fromJson(item)).toList();
  }

  
  String userAsString() {
    return '#$id $name';
  }

  bool isEqual(ContactModel model) {
    return id == model.id;
  }
}
