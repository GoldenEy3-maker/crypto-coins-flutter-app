import "package:json_annotation/json_annotation.dart";

import "../../domain/entities/entities.dart";

part "post.g.dart";

@JsonSerializable()
class PostModel {
  final int userId;
  final int id;
  final String title;
  final String body;

  PostModel({
    required this.userId,
    required this.id,
    required this.title,
    required this.body,
  });

  factory PostModel.fromJson(Map<String, dynamic> json) =>
      _$PostModelFromJson(json);

  Map<String, dynamic> toJson() => _$PostModelToJson(this);

  factory PostModel.fromEntity(Post entity) => PostModel(
    userId: entity.userId,
    id: entity.id,
    title: entity.title,
    body: entity.body,
  );

  Post toEntity() => Post(userId: userId, id: id, title: title, body: body);
}
