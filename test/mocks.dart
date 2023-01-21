import 'package:bloc_app_example/features/posts/domain/repositories/post_repository.dart';
import 'package:bloc_app_example/features/posts/domain/usecases/get_all.dart';
import 'package:bloc_app_example/features/posts/domain/usecases/get_post_comments.dart';
import 'package:http/http.dart';
import 'package:mocktail/mocktail.dart';

class MockClient extends Mock implements Client {}

// Repositories Mocks
class MockPostRepository extends Mock implements PostRepository {}

// Usecases Mocks

class MockGetAllPostsUsecase extends Mock implements GetAllPostsUsecase {}

class MockGetPostCommentsUseCase extends Mock
    implements GetPostCommentsUseCase {}
