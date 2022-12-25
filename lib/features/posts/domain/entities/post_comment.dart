import 'package:equatable/equatable.dart';

class PostCommentEntity extends Equatable {
  final int postId;
  final int id;
  final String author;
  final String email;
  final String body;

  const PostCommentEntity({
    required this.postId,
    required this.id,
    required this.author,
    required this.email,
    required this.body,
  });

  @override
  List<Object?> get props => [id, author, email, body, postId];
}
