import '../../domain/entities/post_entity.dart';

/// Data model for Post with JSON serialization.
///
/// Extends [PostEntity] and adds `fromJson` / `toJson`.
///
/// Example JSON (JSONPlaceholder):
/// ```json
/// {
///   "userId": 1,
///   "id": 1,
///   "title": "sunt aut facere ...",
///   "body": "quia et suscipit ..."
/// }
/// ```
class PostModel extends PostEntity {
  const PostModel({
    required super.id,
    required super.userId,
    required super.title,
    required super.body,
  });

  factory PostModel.fromJson(Map<String, dynamic> json) {
    return PostModel(
      id: json['id'] as int,
      userId: json['userId'] as int,
      title: json['title'] as String,
      body: json['body'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'title': title,
      'body': body,
    };
  }
}
