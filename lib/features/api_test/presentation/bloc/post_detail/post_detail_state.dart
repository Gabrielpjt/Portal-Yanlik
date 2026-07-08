import 'package:equatable/equatable.dart';
import '../../../domain/entities/post_entity.dart';

enum PostDetailStatus { initial, loading, loaded, error }

class PostDetailState extends Equatable {
  final PostDetailStatus status;
  final PostEntity? post;
  final String errorMessage;

  const PostDetailState({
    this.status = PostDetailStatus.initial,
    this.post,
    this.errorMessage = '',
  });

  PostDetailState copyWith({
    PostDetailStatus? status,
    PostEntity? post,
    String? errorMessage,
  }) {
    return PostDetailState(
      status: status ?? this.status,
      post: post ?? this.post,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [status, post, errorMessage];
}
