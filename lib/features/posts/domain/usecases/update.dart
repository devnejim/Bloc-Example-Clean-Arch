import 'package:bloc_app_example/features/posts/domain/entities/post.dart';
import 'package:bloc_app_example/features/posts/domain/repositories/post_repository.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/errors/app_failures.dart';

class UpdatePostUsecase {
  UpdatePostUsecase(this.postRepository);
  final PostRepository postRepository;

  Future<Either<Failure, Unit>> call(PostEntity post) async {
    return await postRepository.updatePost(post);
  }
}
