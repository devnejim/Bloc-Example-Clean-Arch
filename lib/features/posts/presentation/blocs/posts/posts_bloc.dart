import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:bloc_app_example/features/posts/domain/entities/post.dart';
import 'package:bloc_app_example/features/posts/domain/usecases/get_all.dart';

part 'posts_event.dart';
part 'posts_state.dart';

class PostsBloc extends Bloc<PostsEvent, PostsState> {
  final GetAllPostsUsecase getAllPostsUsecase;
  PostsBloc({required this.getAllPostsUsecase}) : super(PostsInitial()) {
    on<PostsEvent>((event, emit) async {
      if (event is GetPostsEvent || event is RefreshPostsEvent) {
        emit(LoadingState());
        final postsOrFailure = await getAllPostsUsecase.call();
        postsOrFailure.fold((failure) {
          emit(ErrorState(errorMessage: failure.message));
        }, (posts) {
          emit(DoneState(posts: posts));
        });
      }
    });
  }
}
