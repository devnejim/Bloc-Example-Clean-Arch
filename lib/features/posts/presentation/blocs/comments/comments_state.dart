part of 'comments_bloc.dart';

abstract class CommentsState extends Equatable {
  const CommentsState();

  @override
  List<Object> get props => [];
}

class CommentsInitial extends CommentsState {}

class LoadingState extends CommentsState {}

class DoneState extends CommentsState {
  final List<PostCommentEntity> comments;

  const DoneState(this.comments);
}

class ErrorState extends CommentsState {
  final String errorMessage;

  const ErrorState(this.errorMessage);
}
