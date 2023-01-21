import 'package:bloc_app_example/core/errors/app_failures.dart';
import 'package:bloc_app_example/features/posts/domain/entities/post_comment.dart';
import 'package:bloc_app_example/features/posts/domain/usecases/get_post_comments.dart';
import 'package:bloc_app_example/features/posts/presentation/blocs/comments/comments_bloc.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../../mocks.dart';

void main() {
  group('Post Comments Bloc Tests', () {
    late GetPostCommentsUseCase getPostCommentsUseCase;
    late CommentsBloc commentsBloc;
    late MockPostRepository mockPostRepository;
    Failure failure = ServerFailure();
    int postId = 1;
    List<PostCommentEntity> comments = [
      PostCommentEntity(
          postId: postId,
          id: 1,
          author: 'author',
          email: 'email@gmail.com',
          body: 'comment body')
    ];

    setUp(() {
      mockPostRepository = MockPostRepository();
      getPostCommentsUseCase =
          GetPostCommentsUseCase(postRepository: mockPostRepository);
      commentsBloc = CommentsBloc(commentsUseCase: getPostCommentsUseCase);
    });

    test('Initial State is CommentsInitial', () {
      expect(commentsBloc.state, equals(CommentsInitial()));
    });

    blocTest(
        'emit LoadingState and CommentsState when when event is GetCommentsEvent and usecase return post comments',
        build: () {
          when(() => mockPostRepository.getPostComments(postId))
              .thenAnswer((_) async => Right(comments));
          return commentsBloc;
        },
        act: (bloc) => bloc.add(GetCommentsEvent(postId: postId)),
        expect: () => [LoadingState(), DoneState(comments)]);

    blocTest(
        'emit LoadingState and CommentsState when event is RefreshCommentsEvent and usecase return post comments',
        build: () {
          when(() => mockPostRepository.getPostComments(postId))
              .thenAnswer((_) async => Right(comments));
          return commentsBloc;
        },
        act: (bloc) => bloc.add(RefreshCommentsEvent(postId: postId)),
        expect: () => [LoadingState(), DoneState(comments)]);

    blocTest(
      'emit LoadingState and ErrorState when event is GetCommentsEvent and usecase return Failure',
      build: () {
        when(() => mockPostRepository.getPostComments(postId))
            .thenAnswer((_) async => Left(failure));
        return commentsBloc;
      },
      act: (bloc) => commentsBloc.add(GetCommentsEvent(postId: postId)),
      expect: () => [LoadingState(), ErrorState(failure.message)],
    );
    blocTest(
      'emit LoadingState and ErrorState when event is RefreshCommentsEvent and usecase return Failure',
      build: () {
        when(() => mockPostRepository.getPostComments(postId))
            .thenAnswer((_) async => Left(failure));
        return commentsBloc;
      },
      act: (bloc) => commentsBloc.add(RefreshCommentsEvent(postId: postId)),
      expect: () => [LoadingState(), ErrorState(failure.message)],
    );
    //
  });
}
