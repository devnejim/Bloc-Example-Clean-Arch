import 'dart:convert';

import 'package:bloc_app_example/core/errors/app_exceptions.dart';
import 'package:bloc_app_example/features/posts/data/models/post.dart';
import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;

abstract class PostsRemoteDataSource {
  Future<List<PostModel>> getPosts();
  Future<Unit> addPost(PostModel postModel);
  Future<Unit> updatePost(PostModel postModel);
  Future<Unit> deletePost(int id);
}

const baseUrl = "https://jsonplaceholder.typicode.com";

class PostsRemoteDataSourceImpl implements PostsRemoteDataSource {
  final http.Client client;

  PostsRemoteDataSourceImpl({required this.client});

  @override
  Future<List<PostModel>> getPosts() async {
    final response = await client.get(
      Uri.parse('$baseUrl/posts/'),
      headers: {"Content-Type": "application/json"},
    );
    if (response.statusCode == 200) {
      List decodedBody = jsonDecode(response.body);
      final posts = decodedBody.map((e) => PostModel.fromJson(e)).toList();
      return posts;
    }
    throw ServerException();
  }

  @override
  Future<Unit> addPost(PostModel postModel) async {
    final response = await client.post(Uri.parse('$baseUrl/posts/'),
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
      Uri.parse('$baseUrl/posts/${id.toString()}'),
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
      Uri.parse('$baseUrl/posts/'),
      body: postModel.toJson(),
      headers: {"Content-Type": "application/json"},
    );
    if (response.statusCode == 200) {
      return unit;
    } else {
      throw ServerException();
    }
  }
}
