import 'dart:convert';

import 'package:bloc_app_example/core/errors/app_exceptions.dart';
import 'package:bloc_app_example/features/posts/data/models/post.dart';
import 'package:dartz/dartz.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class PostsLocalDataSource {
  Future<List<PostModel>> getCachedPosts();
  Future<Unit> cachePosts(List<PostModel> posts);
}

const cachedPostsKey = "CACHED_POSTS";

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
          .map((decodedPost) => PostModel.fromJson(decodedPost))
          .toList();
      return Future.value(cachedPosts);
    } else {
      throw EmptyCacheException();
    }
  }
}
