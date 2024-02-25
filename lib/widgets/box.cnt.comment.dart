import 'package:flutter/material.dart';
import 'package:solutionchallenge2024/models/comment.dart';

import 'sizebox.dart';
import 'text.dart';

class BoxContentCommentaire extends StatelessWidget {
  const BoxContentCommentaire({
    super.key,
    required this.commentModel,
  });
  final CommentModel commentModel;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          width20(),
          CircleAvatar(
            backgroundImage: NetworkImage(commentModel.user['urlImg']),
          ),
          width20(),
          Expanded(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextMedium(commentModel.user['name'], size: 16),
                      TextSmall(
                          DateTime.now()
                                      .difference(commentModel.dateComment)
                                      .inMinutes <=
                                  0
                              ? 'Maintenant'
                              : DateTime.now()
                                          .difference(commentModel.dateComment)
                                          .inMinutes >
                                      59
                                  ? 'il y a ${DateTime.now().difference(commentModel.dateComment).inHours} heure'
                                  : ' il y a ${DateTime.now().difference(commentModel.dateComment).inMinutes} minutes',
                          color: Colors.grey,
                          size: 14),
                    ],
                  ),
                  height5(),
                  TextSmall(commentModel.comment)
                ],
              ),
              height5(),
              Container(
                color: Colors.grey,
                height: 1,
                margin: const EdgeInsets.only(right: 20),
              ),
            ],
          ))
        ],
      ),
    );
  }
}
