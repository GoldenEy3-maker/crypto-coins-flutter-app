import "package:flutter/material.dart";

import "../../domain/entities/entities.dart";

class PostTile extends StatelessWidget {
  final Post post;

  const PostTile({super.key, required this.post});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Text(post.id.toString()),
      title: Text(post.title),
      isThreeLine: true,
      subtitle: Text(post.body),
      dense: true,
    );
  }
}
