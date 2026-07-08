import 'package:equatable/equatable.dart';

abstract class PostDetailEvent extends Equatable {
  const PostDetailEvent();

  @override
  List<Object?> get props => [];
}

/// Fetch a single post by its ID.
class FetchPostById extends PostDetailEvent {
  final int postId;

  const FetchPostById(this.postId);

  @override
  List<Object?> get props => [postId];
}
