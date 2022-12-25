import 'package:bloc_app_example/core/errors/app_failures.dart';
import 'package:bloc_app_example/features/posts/domain/entities/post_comment.dart';
import 'package:bloc_app_example/features/posts/domain/repositories/post_repository.dart';
import 'package:dartz/dartz.dart';

class GetPostCommentsUseCase {
  GetPostCommentsUseCase({required this.postRepository});
  final PostRepository postRepository;

  Future<Either<Failure, List<PostCommentEntity>>> call(id) async {
    final postComments = await postRepository.getPostComments(id);
    return postComments;
  }
}
