import 'package:equatable/equatable.dart';

abstract class PostListEvent extends Equatable {
  const PostListEvent();

  @override
  List<Object?> get props => [];
}

/// Load the first page of posts (resets the list).
class FetchPosts extends PostListEvent {
  const FetchPosts();
}

/// Append the next page of posts to the existing list.
class FetchNextPage extends PostListEvent {
  const FetchNextPage();
}

/// Pull-to-refresh: reload from page 1.
class RefreshPosts extends PostListEvent {
  const RefreshPosts();
}
