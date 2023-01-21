import 'package:bloc_app_example/core/errors/app_failures.dart';
import 'package:bloc_app_example/features/posts/domain/entities/post.dart';
import 'package:bloc_app_example/features/posts/domain/usecases/add.dart';
import 'package:bloc_app_example/features/posts/domain/usecases/delete.dart';
import 'package:bloc_app_example/features/posts/domain/usecases/update.dart';
import 'package:bloc_app_example/features/posts/presentation/blocs/add_delete_update/add_delete_update_bloc.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../../mocks.dart';

void main() {
  late AddPostUsecase addPostUsecase;
  late DeletePostUsecase deletePostUsecase;
  late UpdatePostUsecase updatePostUsecase;
  late MockPostRepository mockPostRepository;
  late AddDeleteUpdateBloc addDeleteUpdateBloc;
  const PostEntity post = PostEntity(id: 1, title: 'title', body: 'body');
  Failure failure = ServerFailure();
  setUp(
    () {
      mockPostRepository = MockPostRepository();
      addPostUsecase = AddPostUsecase(mockPostRepository);
      deletePostUsecase = DeletePostUsecase(mockPostRepository);
      updatePostUsecase = UpdatePostUsecase(mockPostRepository);
      addDeleteUpdateBloc = AddDeleteUpdateBloc(
          addPostUsecase: addPostUsecase,
          deletePostUsecase: deletePostUsecase,
          updatePostUsecase: updatePostUsecase);
    },
  );

  group('AddUpdateDeletePosts Bloc Tests', () {
    blocTest(
      'emit LoadingState and SuccessState when event is AddEvent and usecase return Unit',
      build: () {
        when(
          () => mockPostRepository.addPost(post),
        ).thenAnswer((_) async => const Right(unit));
        return addDeleteUpdateBloc;
      },
      act: (bloc) => bloc.add(const AddEvent(post: post)),
      expect: () => [
        LoadingState(),
        const SuccessState(successMessage: 'successMessage')
      ],
    );
    blocTest(
      'emit LoadingState and SuccessState when event is UpdateEvent and usecase return Unit',
      build: () {
        when(
          () => mockPostRepository.updatePost(post),
        ).thenAnswer((_) async => const Right(unit));
        return addDeleteUpdateBloc;
      },
      act: (bloc) => addDeleteUpdateBloc.add(const UpdateEvent(post: post)),
      expect: () => [
        LoadingState(),
        const SuccessState(successMessage: 'successMessage')
      ],
    );

    blocTest(
      'emit LoadingState and SuccessState when event is DeleteEvent and usecase return Unit',
      build: () {
        when(
          () => mockPostRepository.deletePost(post.id),
        ).thenAnswer((_) async => const Right(unit));
        return addDeleteUpdateBloc;
      },
      act: (bloc) => addDeleteUpdateBloc.add(DeleteEvent(id: post.id)),
      expect: () => [
        LoadingState(),
        const SuccessState(successMessage: 'successMessage')
      ],
    );

    blocTest(
      'emit LoadingState and ErrorState when event is AddEvent and usecase return Failure',
      build: () {
        when(
          () => mockPostRepository.addPost(post),
        ).thenAnswer((_) async => Left(failure));
        return addDeleteUpdateBloc;
      },
      act: (bloc) => addDeleteUpdateBloc.add(const AddEvent(post: post)),
      expect: () => [
        LoadingState(),
        const ErrorState(errorMessage: 'errorMessage'),
      ],
    );

    blocTest(
      'emit LoadingState and ErrorState when event is UpdateEvent and usecase return Failure',
      build: () {
        when(
          () => mockPostRepository.updatePost(post),
        ).thenAnswer((_) async => Left(failure));
        return addDeleteUpdateBloc;
      },
      act: (bloc) => addDeleteUpdateBloc.add(const UpdateEvent(post: post)),
      expect: () => [
        LoadingState(),
        const ErrorState(errorMessage: 'errorMessage'),
      ],
    );

    blocTest(
      'emit LoadingState and ErrorState when event is AddEvent and usecase return Failure',
      build: () {
        when(
          () => mockPostRepository.deletePost(post.id),
        ).thenAnswer((_) async => Left(failure));
        return addDeleteUpdateBloc;
      },
      act: (bloc) => addDeleteUpdateBloc.add(DeleteEvent(id: post.id)),
      expect: () => [
        LoadingState(),
        const ErrorState(errorMessage: 'errorMessage'),
      ],
    );
  });
}
