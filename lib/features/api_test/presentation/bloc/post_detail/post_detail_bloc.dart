import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../domain/repositories/post_repository.dart';
import 'post_detail_event.dart';
import 'post_detail_state.dart';

/// Bloc that fetches a single post by ID.
///
/// Events:
/// - [FetchPostById]: Fetch one post.
class PostDetailBloc extends Bloc<PostDetailEvent, PostDetailState> {
  final PostRepository _repository;

  PostDetailBloc(this._repository) : super(const PostDetailState()) {
    on<FetchPostById>(_onFetchPostById);
  }

  Future<void> _onFetchPostById(
    FetchPostById event,
    Emitter<PostDetailState> emit,
  ) async {
    emit(state.copyWith(status: PostDetailStatus.loading));

    final (post, failure) = await _repository.getPostById(event.postId);

    if (failure != null) {
      emit(state.copyWith(
        status: PostDetailStatus.error,
        errorMessage: failure.message,
      ));
      return;
    }

    emit(state.copyWith(
      status: PostDetailStatus.loaded,
      post: post,
    ));
  }
}
