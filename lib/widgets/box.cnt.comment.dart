import 'package:flutter/material.dart';

import 'sizebox.dart';
import 'text.dart';

class BoxContentCommentaire extends StatelessWidget {
  const BoxContentCommentaire({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          width20(),
          const CircleAvatar(
            backgroundImage: AssetImage('assets/img/default.png'),
          ),
          width20(),
          Expanded(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextMedium('Dieudonne ngwangwa', size: 16),
                      TextSmall('il y a 10 min', size: 12)
                    ],
                  ),
                  height5(),
                  const TextSmall('commentaire')
                ],
              ),
              height5(),
              Container(color: Colors.grey, height: 1, margin: const EdgeInsets.only(right: 20),),
            ],
          ))
        ],
      ),
    );
  }
}
