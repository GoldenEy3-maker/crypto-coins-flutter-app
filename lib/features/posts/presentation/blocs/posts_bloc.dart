import "package:bloc/bloc.dart";
import "package:bloc_concurrency/bloc_concurrency.dart";
import "package:equatable/equatable.dart";
import "package:flutter_application_1/core/error/failures.dart";

import "../../domain/entities/entities.dart";
import "../../domain/usecases/usecases.dart";
import "package:stream_transform/stream_transform.dart";

import "../../params/params.dart";

part "posts_event.dart";
part "posts_state.dart";

const throttleDuration = Duration(milliseconds: 100);

EventTransformer<E> throttleDroppable<E>(Duration duration) {
  return (events, mapper) {
    return droppable<E>().call(events.throttle(duration), mapper);
  };
}

class PostsBloc extends Bloc<PostsEvent, PostsState> {
  final GetPosts _getPosts;

  PostsBloc({required GetPosts getPosts})
    : _getPosts = getPosts,
      super(const PostsState()) {
    on<PostsFetchRequested>(
      _onFetchRequested,
      transformer: throttleDroppable(throttleDuration),
    );
  }

  Future<void> _onFetchRequested(
    PostsFetchRequested event,
    Emitter<PostsState> emit,
  ) async {
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
