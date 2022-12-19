import 'package:bloc/bloc.dart';
import 'package:bloc_app_example/core/constants/strings.dart';
import 'package:bloc_app_example/features/posts/domain/entities/post.dart';
import 'package:bloc_app_example/features/posts/domain/usecases/add.dart';
import 'package:bloc_app_example/features/posts/domain/usecases/delete.dart';
import 'package:bloc_app_example/features/posts/domain/usecases/update.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../../core/errors/app_failures.dart';

part 'add_delete_update_event.dart';
part 'add_delete_update_state.dart';

class AddDeleteUpdateBloc
    extends Bloc<AddDeleteUpdateEvent, AddDeleteUpdateState> {
  final AddPostUsecase addPostUsecase;
  final DeletePostUsecase deletePostUsecase;
  final UpdatePostUsecase updatePostUsecase;
  AddDeleteUpdateBloc(
      {required this.addPostUsecase,
      required this.deletePostUsecase,
      required this.updatePostUsecase})
      : super(AddDeleteUpdateInitial()) {
    on<AddDeleteUpdateEvent>((event, emit) async {
      if (event is AddEvent) {
        emit(LoadingState());
        final addPost = await addPostUsecase.call(event.post);
        emit(_eitherSuccessOrFail(addPost, successAddPostMessage));
      } else if (event is UpdateEvent) {
        emit(LoadingState());
        final updatePost = await updatePostUsecase.call(event.post);
        emit(_eitherSuccessOrFail(updatePost, successUpdatePostMessage));
      } else if (event is DeleteEvent) {
        emit(LoadingState());
        final deletePost = await deletePostUsecase.call(event.id);
        emit(_eitherSuccessOrFail(deletePost, successDeletePostMessage));
      }
    });
  }

  AddDeleteUpdateState _eitherSuccessOrFail(
      Either<Failure, Unit> either, String successMessage) {
    return either.fold((failure) {
      return ErrorState(errorMessage: failure.message);
    }, (success) {
      return SuccessState(successMessage: successMessage);
    });
  }
}
