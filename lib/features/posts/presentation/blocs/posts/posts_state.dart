part of 'posts_bloc.dart';

abstract class PostsState extends Equatable {
  const PostsState();

  @override
  List<Object> get props => [];
}

class PostsInitial extends PostsState {}

class LoadingState extends PostsState {}

class DoneState extends PostsState {
  final List<PostEntity> posts;

  const DoneState({required this.posts});
}

class ErrorState extends PostsState {
  final String errorMessage;

  const ErrorState({required this.errorMessage});
}
