import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:equatable/equatable.dart';

import 'package:bloc_app_example/features/posts/domain/entities/post.dart';
import 'package:bloc_app_example/features/posts/domain/usecases/get_all.dart';

part 'posts_event.dart';
part 'posts_state.dart';

class PostsBloc extends Bloc<PostsEvent, PostsState> {
  final GetAllPostsUsecase getAllPostsUsecase;
  PostsBloc({required this.getAllPostsUsecase}) : super(PostsInitial()) {
    on<PostsEvent>((event, emit) async {
      if (event is GetPostsEvent && state is! DoneState) {
        emit(LoadingState());
        final postsOrFailure = await getAllPostsUsecase.call(0, 10);
        postsOrFailure.fold((failure) {
          emit(ErrorState(errorMessage: failure.message));
        }, (posts) async {
          emit(DoneState(posts: posts, canFetch: posts.isNotEmpty));
        });
      } else if (event is GetPostsEvent && state is DoneState) {
        final loadedPosts = (event).posts;
        final postsOrFailure =
            await getAllPostsUsecase.call(loadedPosts!.length, 10);
        postsOrFailure.fold((failure) {
          emit(ErrorState(errorMessage: failure.message));
        }, (posts) {
          final resPosts = loadedPosts..addAll(posts);
          emit(LoadingState());
          emit(DoneState(posts: resPosts, canFetch: posts.isNotEmpty));
        });
      } else if (event is RefreshPostsEvent) {
        emit(LoadingState());
        final postsOrFailure = await getAllPostsUsecase.call(0, 10);
        postsOrFailure.fold((failure) {
          emit(ErrorState(errorMessage: failure.message));
        }, (posts) async {
          emit(DoneState(posts: posts, canFetch: posts.isNotEmpty));
        });
      }
    });
  }
}
