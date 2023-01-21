import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bloc_app_example/features/posts/domain/usecases/get_post_comments.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../../core/errors/app_failures.dart';
import '../../../domain/entities/post_comment.dart';

part 'comments_event.dart';
part 'comments_state.dart';

class CommentsBloc extends Bloc<CommentsEvent, CommentsState> {
  final GetPostCommentsUseCase commentsUseCase;
  CommentsBloc({required this.commentsUseCase}) : super(CommentsInitial()) {
    on<CommentsEvent>((event, emit) async {
      final getComments = commentsUseCase.postRepository.getPostComments;

      if (event is GetCommentsEvent) {
        emit(LoadingState());
        final response = await getComments(event.postId);
        emit(_failureOrComments(response));
      } else if (event is RefreshCommentsEvent) {
        emit(LoadingState());
        final response = await getComments(event.postId);
        emit(_failureOrComments(response));
      }
    });
  }

  CommentsState _failureOrComments(
      Either<Failure, List<PostCommentEntity>> response) {
    return response.fold((failure) {
      return ErrorState(failure.message);
    }, (comments) {
      return DoneState(comments);
    });
  }
}
