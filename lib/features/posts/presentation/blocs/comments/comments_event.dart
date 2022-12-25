part of 'comments_bloc.dart';

abstract class CommentsEvent extends Equatable {
  const CommentsEvent();

  @override
  List<Object> get props => [];
}

class GetCommentsEvent extends CommentsEvent {
  const GetCommentsEvent({required this.postId});
  final int postId;

  @override
  List<Object> get props => [postId];
}

class RefreshCommentsEvent extends CommentsEvent {
  const RefreshCommentsEvent({required this.postId});
  final int postId;

  @override
  List<Object> get props => [postId];
}
