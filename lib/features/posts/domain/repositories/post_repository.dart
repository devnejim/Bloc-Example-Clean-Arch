import 'package:bloc_app_example/core/errors/app_failures.dart';
import 'package:bloc_app_example/features/posts/domain/entities/post.dart';
import 'package:dartz/dartz.dart';

abstract class PostRepository {
  Future<Either<Failure, List<PostEntity>>> getPosts();
  Future<Either<Failure, Unit>> addPost(PostEntity post);
  Future<Either<Failure, Unit>> updatePost(PostEntity post);
  Future<Either<Failure, Unit>> deletePost(int id);
}
