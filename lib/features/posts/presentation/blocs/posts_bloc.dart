import "package:bloc/bloc.dart";
import "package:equatable/equatable.dart";
import "package:flutter_application_1/core/error/failures.dart";

import "../../domain/entities/entities.dart";
import "../../domain/usecases/usecases.dart";

part "posts_event.dart";
part "posts_state.dart";

class PostsBloc extends Bloc<PostsEvent, PostsState> {
  final GetPosts _getPosts;

  PostsBloc({required GetPosts getPosts})
    : _getPosts = getPosts,
      super(const PostsState()) {
    on<PostsFetched>(_onFetched);
  }

  Future<void> _onFetched(PostsFetched event, Emitter<PostsState> emit) async {
    if (state.hasReachedMax) return;

    final result = await _getPosts(
      GetPostsParams(start: state.posts.length, limit: 20),
    );

    result.fold(
      (failure) {
        emit(state.copyWith(status: PostsStatus.failure, error: failure));
      },
      (posts) {
        if (posts.isEmpty) {
          emit(state.copyWith(hasReachedMax: true));
        }

        emit(
          state.copyWith(
            status: PostsStatus.success,
            posts: [...state.posts, ...posts],
          ),
        );
      },
    );
  }
}
