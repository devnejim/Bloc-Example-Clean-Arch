import 'package:bloc_app_example/features/posts/domain/repositories/post_repository.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/errors/app_failures.dart';

class DeletePostUsecase {
  DeletePostUsecase(this.postRepository);

  final PostRepository postRepository;

  Future<Either<Failure, Unit>> call(int id) async {
    return await postRepository.deletePost(id);
  }
}
