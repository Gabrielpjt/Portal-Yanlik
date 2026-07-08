import 'package:equatable/equatable.dart';

/// Domain entity representing a blog post.
///
/// This is the pure domain object with no serialization logic.
/// See [PostModel] for the JSON-aware data layer counterpart.
class PostEntity extends Equatable {
  final int id;
  final int userId;
  final String title;
  final String body;

  const PostEntity({
    required this.id,
    required this.userId,
    required this.title,
    required this.body,
  });

  @override
  List<Object?> get props => [id, userId, title, body];
}
