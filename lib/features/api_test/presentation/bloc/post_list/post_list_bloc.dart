import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../domain/repositories/post_repository.dart';
import 'post_list_event.dart';
import 'post_list_state.dart';

/// Bloc that manages a paginated list of posts.
///
/// Events:
/// - [FetchPosts]: Load page 1 (initial load).
/// - [FetchNextPage]: Append the next page.
/// - [RefreshPosts]: Reset and reload from page 1.
class PostListBloc extends Bloc<PostListEvent, PostListState> {
  final PostRepository _repository;

  PostListBloc(this._repository) : super(const PostListState()) {
    on<FetchPosts>(_onFetchPosts);
    on<FetchNextPage>(_onFetchNextPage);
    on<RefreshPosts>(_onRefreshPosts);
  }

  Future<void> _onFetchPosts(
    FetchPosts event,
    Emitter<PostListState> emit,
  ) async {
    emit(state.copyWith(status: PostListStatus.loading));

    final (paginated, failure) = await _repository.getPosts(page: 1);

    if (failure != null) {
      emit(state.copyWith(
        status: PostListStatus.error,
        errorMessage: failure.message,
      ));
      return;
    }

    emit(state.copyWith(
      status: PostListStatus.loaded,
      posts: paginated!.items,
      currentPage: paginated.currentPage,
      totalPages: paginated.totalPages,
      totalItems: paginated.totalItems,
      hasNextPage: paginated.hasNextPage,
    ));
  }

  Future<void> _onFetchNextPage(
    FetchNextPage event,
    Emitter<PostListState> emit,
  ) async {
    if (!state.hasNextPage ||
        state.status == PostListStatus.loadingMore) {
      return;
    }

    emit(state.copyWith(status: PostListStatus.loadingMore));

    final nextPage = state.currentPage + 1;
    final (paginated, failure) = await _repository.getPosts(page: nextPage);

    if (failure != null) {
      emit(state.copyWith(
        status: PostListStatus.error,
        errorMessage: failure.message,
      ));
      return;
    }

    emit(state.copyWith(
      status: PostListStatus.loaded,
      posts: [...state.posts, ...paginated!.items],
      currentPage: paginated.currentPage,
      totalPages: paginated.totalPages,
      totalItems: paginated.totalItems,
      hasNextPage: paginated.hasNextPage,
    ));
  }

  Future<void> _onRefreshPosts(
    RefreshPosts event,
    Emitter<PostListState> emit,
  ) async {
    emit(const PostListState(status: PostListStatus.loading));

    final (paginated, failure) = await _repository.getPosts(page: 1);

    if (failure != null) {
      emit(state.copyWith(
        status: PostListStatus.error,
        errorMessage: failure.message,
      ));
      return;
    }

    emit(state.copyWith(
      status: PostListStatus.loaded,
      posts: paginated!.items,
      currentPage: paginated.currentPage,
      totalPages: paginated.totalPages,
      totalItems: paginated.totalItems,
      hasNextPage: paginated.hasNextPage,
    ));
  }
}
