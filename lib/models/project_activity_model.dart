
class ProjectActivityModel {
  int? id;
  String? image;
  String? description;
  String? date;

  ProjectActivityModel({
    this.id,
    this.image,
    this.description,
    this.date,
    });

  ProjectActivityModel.fromJson(Map<String, dynamic> json) {
    id = json['id'] != null ? int.parse(json['id'].toString()) : null;
    image = json['image'] ?? '';
    description = json['description'] ?? '';
    date = json['date'] ?? '';
    image = json['image_url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['image'] = image;
    data['description'] = description;
    data['date'] = date;
    data['image'] = image;
    return data;
  }

  static List<ProjectActivityModel> fromJsonList(List list) {
    return list.map((item) => ProjectActivityModel.fromJson(item)).toList();
  }
}
