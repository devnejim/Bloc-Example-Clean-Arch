// ignore_for_file: annotate_overrides

import 'package:bloc_app_example/features/posts/domain/entities/post.dart';

class PostModel extends PostEntity {
  const PostModel(
      {required int id, required String title, required String body})
      : super(body: body, id: id, title: title);

  Map<String, dynamic> toJson() {
    return {'id': id, 'title': title, 'body': body};
  }

  factory PostModel.fromJson(Map<String, dynamic> json) {
    return PostModel(id: json['id'], title: json['title'], body: json['body']);
  }

  factory PostModel.fromEntity(PostEntity postEntity) {
    return PostModel(
        id: postEntity.id, title: postEntity.title, body: postEntity.body);
  }

  @override
  String toString() => 'PostModel(id: $id , title: $title, body:$body)';
}
