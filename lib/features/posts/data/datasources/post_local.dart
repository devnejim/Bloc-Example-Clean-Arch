import 'package:bloc_app_example/features/posts/data/models/post.dart';
import 'package:dartz/dartz.dart';

abstract class PostsLocalDataSource {
  Future<List<PostModel>> getCachedPosts();
  Future<Unit> cachePosts(List<PostModel> posts);
}

class PostsLocalDataSourceImpl implements PostsLocalDataSource {
  @override
  Future<Unit> cachePosts(List<PostModel> posts) {
    // TODO: implement cachePosts
    throw UnimplementedError();
  }

  @override
  Future<List<PostModel>> getCachedPosts() {
    // TODO: implement getCachedPosts
    throw UnimplementedError();
  }
}
