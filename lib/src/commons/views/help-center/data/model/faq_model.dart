// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class FAQDataModel {
   final String title;
  final String description;
  FAQDataModel({
    required this.title,
    required this.description,
  });

  FAQDataModel copyWith({
    String? title,
    String? description,
  }) {
    return FAQDataModel(
      title: title ?? this.title,
      description: description ?? this.description,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'title': title,
      'description': description,
    };
  }

  factory FAQDataModel.fromMap(Map<String, dynamic> map) {
    return FAQDataModel(
      title: map['title'] as String,
      description: map['description'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory FAQDataModel.fromJson(String source) => FAQDataModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'FAQDataModel(title: $title, description: $description)';

  @override
  bool operator ==(covariant FAQDataModel other) {
    if (identical(this, other)) return true;
  
    return 
      other.title == title &&
      other.description == description;
  }

  @override
  int get hashCode => title.hashCode ^ description.hashCode;
}
