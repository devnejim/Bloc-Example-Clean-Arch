import 'package:bloc_app_example/core/errors/app_failures.dart';
import 'package:bloc_app_example/features/posts/domain/entities/post.dart';
import 'package:bloc_app_example/features/posts/presentation/blocs/posts/posts_bloc.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../../mocks.dart';

void main() {
  group('PostsBloc Tests', () {
    late PostsBloc postsBloc;
    late MockGetAllPostsUsecase mockGetAllPostsUsecase;

    setUp(() {
      mockGetAllPostsUsecase = MockGetAllPostsUsecase();
      postsBloc = PostsBloc(getAllPostsUsecase: mockGetAllPostsUsecase);
    });

    final posts = [
      const PostEntity(id: 1, body: 'body', title: 'title'),
      const PostEntity(id: 2, body: 'body2', title: 'title2')
    ];
    final failure = ServerFailure();
    const start = 0;
    const limit = 10;

    test('Initial state is PostsInitial', () {
      expect(postsBloc.state, equals(PostsInitial()));
    });

    blocTest(
      'emits LoadingState when state is not DoneState',
      build: () {
        when(() => mockGetAllPostsUsecase.call(start, limit))
            .thenAnswer((_) async => Right(posts));
        return postsBloc;
      },
      act: (bloc) => bloc.add(const GetPostsEvent()),
      expect: () => [LoadingState(), DoneState(posts: posts, canFetch: true)],
    );

    blocTest(
      'emits LoadingState when state is DoneState with old and new fetched posts',
      build: () {
        when(() => mockGetAllPostsUsecase.call(start, limit))
            .thenAnswer((_) async => Right(posts));
        return postsBloc;
      },
      act: (bloc) => bloc.add(const GetPostsEvent()),
      expect: () => [LoadingState(), DoneState(posts: posts, canFetch: true)],
    );
    blocTest(
      'emits DoneState with posts and canFetch true when usecase returns posts',
      build: () {
        when(() => mockGetAllPostsUsecase.call(start, limit))
            .thenAnswer((_) async => Right(posts));
        return postsBloc;
      },
      act: (bloc) => bloc.add(const GetPostsEvent()),
      expect: () => [LoadingState(), DoneState(posts: posts, canFetch: true)],
    );

    blocTest(
      'emits ErrorState with failure message when usecase returns failure',
      build: () {
        when(() => mockGetAllPostsUsecase.call(start, limit))
            .thenAnswer((_) async => Left(failure));
        return postsBloc;
      },
      act: (bloc) => bloc.add(const GetPostsEvent()),
      expect: () => [LoadingState(), ErrorState(errorMessage: failure.message)],
    );

    blocTest(
      'emits LoadingState and DoneState with concatenated posts and canFetch true when state is DoneState and usecase returns posts',
      build: () {
        postsBloc.emit(const DoneState(posts: [], canFetch: true));
        when(() => mockGetAllPostsUsecase.call(posts.length, limit))
            .thenAnswer((_) async => Right(posts));
        return postsBloc;
      },
      act: (bloc) => bloc.add(GetPostsEvent(posts: posts)),
      expect: () => [
        LoadingState(),
        DoneState(posts: [...posts, ...posts], canFetch: true),
      ],
    );

    blocTest(
      'emits ErrorState with failure message when current state is DoneState and usecase returns failure',
      build: () {
        postsBloc.emit(const DoneState(posts: [], canFetch: true));
        when(() => mockGetAllPostsUsecase.call(posts.length, limit))
            .thenAnswer((_) async => Left(failure));
        return postsBloc;
      },
      act: (bloc) => bloc.add(GetPostsEvent(posts: posts)),
      expect: () => [
        ErrorState(errorMessage: failure.message),
      ],
    );

    blocTest(
      'emits ErrorState with failure message when usecase returns failure',
      build: () {
        when(() => mockGetAllPostsUsecase.call(start, limit))
            .thenAnswer((_) async => Left(failure));
        return postsBloc..add(const GetPostsEvent());
      },
      act: (bloc) => bloc.add(const GetPostsEvent()),
      expect: () => [
        LoadingState(),
        ErrorState(errorMessage: failure.message),
        LoadingState(),
        ErrorState(errorMessage: failure.message)
      ],
    );

    blocTest(
      'emits DoneState with posts and canFetch true when usecase returns posts on refresh posts event',
      build: () {
        when(() => mockGetAllPostsUsecase.call(start, limit))
            .thenAnswer((_) async => Right(posts));
        return postsBloc;
      },
      act: (bloc) => bloc.add(RefreshPostsEvent()),
      expect: () => [LoadingState(), DoneState(posts: posts, canFetch: true)],
    );

    blocTest(
      'emits ErrorState when RefreshPostsEvent is added and usecase return failure.',
      build: () {
        when(() => postsBloc.getAllPostsUsecase.call(start, limit))
            .thenAnswer((_) async => Left(failure));
        return postsBloc;
      },
      act: (bloc) => bloc.add(RefreshPostsEvent()),
      expect: () => [LoadingState(), ErrorState(errorMessage: failure.message)],
    );
  });
}
