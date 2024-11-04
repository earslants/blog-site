import 'package:emirhanarslantascom/core/base/model/base_model.dart';

class AllContentsModel extends BaseModel {
  int? id;
  String? category;
  String? title;
  DateTime? time;

  AllContentsModel({this.id, this.category, this.title, this.time});

  @override
  AllContentsModel fromJson(Map<String, dynamic> json) {
    return AllContentsModel(
      id: json['id'] as int?,
      category: json['category'] as String?,
      title: json['title'] as String?,
      time: json['dateTime'] != null
          ? DateTime.parse(json['dateTime'] as String)
          : null,
    );
  }

  @override
  Map<String, Object?> toJson() {
    return {
      'id': id,
      'category': category,
      'title': title,
      'dateTime': time?.toIso8601String(),
    };
  }
}