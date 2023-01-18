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
}

class ErrorState extends PostsState {
  final String errorMessage;

  const ErrorState({required this.errorMessage});
}
