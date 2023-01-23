import 'package:bloc_app_example/features/posts/domain/repositories/post_repository.dart';
import 'package:bloc_app_example/features/posts/domain/usecases/get_all.dart';
import 'package:bloc_app_example/features/posts/domain/usecases/get_post_comments.dart';
import 'package:bloc_app_example/features/posts/presentation/blocs/comments/comments_bloc.dart';
import 'package:bloc_app_example/features/posts/presentation/blocs/posts/posts_bloc.dart';
import 'package:http/http.dart';
import 'package:mocktail/mocktail.dart';

class MockClient extends Mock implements Client {}

// Repositories Mocks
class MockPostRepository extends Mock implements PostRepository {}

// Usecases Mocks

class MockGetAllPostsUsecase extends Mock implements GetAllPostsUsecase {}

class MockGetPostCommentsUseCase extends Mock
    implements GetPostCommentsUseCase {}

// Bloc Mocks

class MockBlocComments extends Mock implements CommentsBloc {}

class MockPostsBloc extends Mock implements PostsBloc {}
