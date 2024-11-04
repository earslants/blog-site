import 'package:emirhanarslantascom/core/base/model/base_model.dart';

class Content extends BaseModel {
  int? id;
  String? category;
  String? title;
  String? text;
  DateTime? time;
  Content({this.id, this.category, this.title, this.time, this.text});

  @override
  Content fromJson(Map<String, dynamic> json) {
    return Content(
      id: json['id'] as int?,
      category: json['category'] as String?,
      title: json['title'] as String?,
      text: json['text'] as String?,
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
      'text': text,
      'dateTime': time?.toIso8601String(),
    };
  }
}
