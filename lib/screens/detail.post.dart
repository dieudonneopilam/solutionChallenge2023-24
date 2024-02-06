import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:solutionchallenge2024/widgets/box.cnt.post.dart';
import 'package:solutionchallenge2024/widgets/sizebox.dart';
import 'package:solutionchallenge2024/widgets/text.dart';

import '../widgets/box.cnt.comment.dart';

class DetailPostScreen extends StatelessWidget {
  const DetailPostScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Stack(
        children: [
          SizedBox(
            height: MediaQuery.sizeOf(context).height - 100,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const BoxContentPost(),
                  ...[2, 3].map((e) => const BoxContentCommentaire()),
                  height(120)
                ],
              ),
            ),
          ),
          Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 0),
                alignment: Alignment.bottomCenter,
                margin: const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
                height: 120,
                width: double.infinity,
                decoration:
                    BoxDecoration(color: Colors.transparent.withOpacity(0)),
                child: Column(
                  children: [
                    TextField(
                      maxLines: 1,
                      minLines: 1,
                      decoration: InputDecoration(
                          hintText: 'Commenter ce post',
                          hintStyle: GoogleFonts.poppins()),
                    ),
                    height5(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 5),
                          decoration: BoxDecoration(
                              color: Colors.blue,
                              borderRadius: BorderRadius.circular(30)),
                          child: const TextMedium('Reply',
                              color: Colors.white, size: 16),
                        )
                      ],
                    ),
                  ],
                ),
              ))
        ],
      ),
    );
  }
}
