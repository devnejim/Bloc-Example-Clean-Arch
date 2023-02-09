import 'dart:convert';

import 'package:bloc_app_example/core/api/posts_api.dart';
import 'package:bloc_app_example/core/errors/app_exceptions.dart';
import 'package:bloc_app_example/features/posts/data/models/post.dart';
import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;

import '../models/post_comment.dart';

abstract class PostsRemoteDataSource {
  Future<List<PostModel>> getPosts(int start, int limit);
  Future<Unit> addPost(PostModel postModel);
  Future<Unit> updatePost(PostModel postModel);
  Future<Unit> deletePost(int id);
  Future<List<PostCommentModel>> getPostComments(int id);
}

class PostsRemoteDataSourceImpl implements PostsRemoteDataSource {
  final http.Client client;

  PostsRemoteDataSourceImpl({required this.client});

  @override
  Future<List<PostModel>> getPosts(int start, int limit) async {
    final response = await client.get(
      Uri.parse(PostsApi.paginatedPostsUri(start, limit)),
      headers: {"Content-Type": "application/json"},
    );
    if (response.statusCode == 200) {
      List decodedBody = jsonDecode(response.body);
      final posts = decodedBody.map((e) => PostModel.fromMap(e)).toList();
      return posts;
    }
    throw ServerException();
  }

  @override
  Future<Unit> addPost(PostModel postModel) async {
    final response = await client.post(Uri.parse(PostsApi.addOrUpdatePostUri),
        headers: {"Content-Type": "application/json"},
        body: postModel.toJson());
    if (response.statusCode == 201) {
      return unit;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<Unit> deletePost(int id) async {
    final response = await client.delete(
      Uri.parse(PostsApi.deletePostUri(id.toString())),
      headers: {"Content-Type": "application/json"},
    );
    if (response.statusCode == 200) {
      return unit;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<Unit> updatePost(PostModel postModel) async {
    final response = await client.patch(
      Uri.parse(PostsApi.addOrUpdatePostUri),
      body: postModel.toJson(),
      headers: {"Content-Type": "application/json"},
    );
    if (response.statusCode == 200) {
      return unit;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<PostCommentModel>> getPostComments(int postId) async {
    final response = await client.get(Uri.parse(PostsApi.commentsUri),
        headers: {'Content-Type': 'application/json'});
    if (response.statusCode == 200) {
      List decodedBody = json.decode(response.body);
      List<PostCommentModel> comments = decodedBody
          .map((e) => PostCommentModel.fromJson(e))
          .where((element) => element.postId == postId)
          .toList();
      return comments;
    } else {
      throw ServerException();
    }
  }
}
