import 'dart:convert';

import 'package:equatable/equatable.dart';

import 'package:bloc_app_example/features/posts/domain/entities/post.dart';
import 'package:bloc_app_example/features/posts/domain/usecases/get_all.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

part 'posts_event.dart';
part 'posts_state.dart';

const _start = 0;
const _limit = 10;

class PostsBloc extends Bloc<PostsEvent, PostsState> with HydratedMixin {
  final GetAllPostsUsecase getAllPostsUsecase;
  PostsBloc({required this.getAllPostsUsecase}) : super(PostsInitial()) {
    on<PostsEvent>((event, emit) async {
      if (event is GetPostsEvent && state is! DoneState) {
        emit(LoadingState());
        final postsOrFailure = await getAllPostsUsecase.call(_start, _limit);
        postsOrFailure.fold((failure) {
          emit(ErrorState(errorMessage: failure.message));
        }, (posts) async {
          emit(DoneState(posts: posts, canFetch: posts.isNotEmpty));
        });
      } else if (event is GetPostsEvent && state is DoneState) {
        final loadedPosts = (event).posts ?? [];
        final postsOrFailure =
            await getAllPostsUsecase.call(loadedPosts.length, _limit);
        postsOrFailure.fold((failure) {
          emit(ErrorState(errorMessage: failure.message));
        }, (posts) {
          final resPosts = [...loadedPosts, ...posts];
          emit(LoadingState());
          emit(DoneState(posts: resPosts, canFetch: posts.isNotEmpty));
        });
      } else if (event is RefreshPostsEvent) {
        emit(LoadingState());
        final postsOrFailure = await getAllPostsUsecase.call(_start, _limit);
        postsOrFailure.fold((failure) {
          emit(ErrorState(errorMessage: failure.message));
        }, (posts) async {
          emit(DoneState(posts: posts, canFetch: posts.isNotEmpty));
        });
      }
    });
  }

  @override
  PostsState? fromJson(Map<String, dynamic> json) {
    return DoneState.fromMap(json);

    //return PostEntity.fromMap(json);
  }

  @override
  Map<String, dynamic>? toJson(PostsState state) {
    if (state is DoneState) {
      return state.toMap();
    }
    return null;
  }
}
