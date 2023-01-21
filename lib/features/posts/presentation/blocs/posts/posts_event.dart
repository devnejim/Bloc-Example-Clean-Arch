part of 'posts_bloc.dart';

abstract class PostsEvent extends Equatable {
  const PostsEvent();

  @override
  List<Object> get props => [];
}

class GetPostsEvent extends PostsEvent {
  const GetPostsEvent({this.posts});
  final List<PostEntity>? posts;
}

class RefreshPostsEvent extends PostsEvent {}

//
class TestEvent extends PostsEvent {}
