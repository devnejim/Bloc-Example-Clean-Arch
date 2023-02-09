part of 'posts_bloc.dart';

abstract class PostsState extends Equatable {
  const PostsState();

  @override
  List<Object> get props => [];
}

class PostsInitial extends PostsState {
  @override
  List<Object> get props => [];
}

class LoadingState extends PostsState {
  @override
  List<Object> get props => [];
}

class DoneState extends PostsState {
  final List<PostEntity> posts;
  final bool canFetch;
  const DoneState({required this.posts, required this.canFetch});

  @override
  List<Object> get props => [posts, canFetch];

  Map<String, dynamic> toMap() {
    return {
      'posts': posts.map((x) => x.toMap()).toList(),
      'canFetch': canFetch,
    };
  }

  factory DoneState.fromMap(Map<String, dynamic> map) {
    return DoneState(
      posts: List<PostEntity>.from(
          map['posts']?.map((x) => PostEntity.fromMap(x))),
      canFetch: map['canFetch'] ?? false,
    );
  }

  String toJson() => json.encode(toMap());

  factory DoneState.fromJson(String source) =>
      DoneState.fromMap(json.decode(source));
}

class ErrorState extends PostsState {
  final String errorMessage;

  const ErrorState({required this.errorMessage});

  @override
  List<Object> get props => [errorMessage];
}

//
class TestState extends PostsState {
  const TestState();

  @override
  List<Object> get props => [];
}
