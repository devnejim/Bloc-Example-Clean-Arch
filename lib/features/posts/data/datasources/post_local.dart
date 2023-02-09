import 'dart:convert';

import 'package:bloc_app_example/core/errors/app_exceptions.dart';
import 'package:bloc_app_example/features/posts/data/models/post.dart';
import 'package:bloc_app_example/features/posts/data/models/post_comment.dart';
import 'package:dartz/dartz.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class PostsLocalDataSource {
  Future<List<PostModel>> getCachedPosts();
  Future<List<PostCommentModel>> getPostCachedComments(int postId);
  Future<Unit> cachePosts(List<PostModel> posts);
  Future<Unit> cachePostComments(
      int postId, List<PostCommentModel> postComments);
}

const cachedPostsKey = "CACHED_POSTS";
const cachedPostCommentsKey = "CACHED_POST_COMMENTS";

class PostsLocalDataSourceImpl implements PostsLocalDataSource {
  PostsLocalDataSourceImpl({required this.sharedPreferences});
  final SharedPreferences sharedPreferences;

  @override
  Future<Unit> cachePosts(List<PostModel> posts) async {
    List postsToJsonString = posts.map((post) => post.toJson()).toList();
    String encodedPosts = json.encode(postsToJsonString);
    await sharedPreferences.setString(cachedPostsKey, encodedPosts);
    return Future.value(unit);
  }

  @override
  Future<List<PostModel>> getCachedPosts() {
    final cachedPostsString = sharedPreferences.getString(cachedPostsKey);
    if (cachedPostsString != null) {
      List decodedJsonData = json.decode(cachedPostsString);
      final cachedPosts = decodedJsonData
          .map((decodedPost) => PostModel.fromMap(decodedPost))
          .toList();
      return Future.value(cachedPosts);
    } else {
      throw EmptyCacheException();
    }
  }

  @override
  Future<Unit> cachePostComments(
      int postId, List<PostCommentModel> postComments) {
    // TODO: implement cachePostComments
    throw UnimplementedError();
  }

  @override
  Future<List<PostCommentModel>> getPostCachedComments(int postId) {
    // TODO: implement getCachedComments
    throw UnimplementedError();
  }
}
