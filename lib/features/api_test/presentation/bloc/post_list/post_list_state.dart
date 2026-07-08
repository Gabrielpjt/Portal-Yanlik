import 'package:equatable/equatable.dart';
import '../../../domain/entities/post_entity.dart';

enum PostListStatus { initial, loading, loaded, loadingMore, error }

class PostListState extends Equatable {
  final PostListStatus status;
  final List<PostEntity> posts;
  final int currentPage;
  final int totalPages;
  final int totalItems;
  final bool hasNextPage;
  final String errorMessage;

  const PostListState({
    this.status = PostListStatus.initial,
    this.posts = const [],
    this.currentPage = 0,
    this.totalPages = 0,
    this.totalItems = 0,
    this.hasNextPage = false,
    this.errorMessage = '',
  });

  PostListState copyWith({
    PostListStatus? status,
    List<PostEntity>? posts,
    int? currentPage,
    int? totalPages,
    int? totalItems,
    bool? hasNextPage,
    String? errorMessage,
  }) {
    return PostListState(
      status: status ?? this.status,
      posts: posts ?? this.posts,
      currentPage: currentPage ?? this.currentPage,
      totalPages: totalPages ?? this.totalPages,
      totalItems: totalItems ?? this.totalItems,
      hasNextPage: hasNextPage ?? this.hasNextPage,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [
        status,
        posts,
        currentPage,
        totalPages,
        totalItems,
        hasNextPage,
        errorMessage,
      ];
}
