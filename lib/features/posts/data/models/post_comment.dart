import '../../domain/entities/post_comment.dart';

class PostCommentModel extends PostCommentEntity {
  const PostCommentModel({
    required int postId,
    required int id,
    required String author,
    required String email,
    required String body,
  }) : super(author: author, id: id, body: body, email: email, postId: postId);

  Map<String, dynamic> toJson() {
    return {'id': id, 'name': author, 'body': body, 'email': email};
  }

  factory PostCommentModel.fromJson(Map<String, dynamic> json) {
    return PostCommentModel(
      postId: json['postId'],
      id: json['id'],
      author: json['name'],
      body: json['body'],
      email: json['email'],
    );
  }

  factory PostCommentModel.fromEntity(PostCommentEntity postCommentEntity) {
    return PostCommentModel(
      postId: postCommentEntity.postId,
      id: postCommentEntity.id,
      author: postCommentEntity.author,
      body: postCommentEntity.body,
      email: postCommentEntity.email,
    );
  }

  @override
  List<Object?> get props => [id, author, email, body, postId];
}
