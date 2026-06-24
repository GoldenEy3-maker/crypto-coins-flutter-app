part of "posts_bloc.dart";

enum PostsStatus { initial, success, failure }

final class PostsState extends Equatable {
  final PostsStatus status;
  final List<Post> posts;
  final Failure? error;
  final bool hasReachedMax;

  const PostsState({
    this.status = PostsStatus.initial,
    this.posts = const <Post>[],
    this.error,
    this.hasReachedMax = false,
  });

  PostsState copyWith({
    PostsStatus? status,
    List<Post>? posts,
    Failure? error,
    bool? hasReachedMax,
  }) {
    return PostsState(
      status: status ?? this.status,
      posts: posts ?? this.posts,
      error: error ?? this.error,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
    );
  }

  @override
  String toString() {
    return "PostsState(status: $status, posts: $posts, error: $error, hasReachedMax: $hasReachedMax)";
  }

  @override
  List<Object?> get props => [status, posts, error, hasReachedMax];
}
