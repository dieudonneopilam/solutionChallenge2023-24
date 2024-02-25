import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:solutionchallenge2024/models/comment.dart';
import 'package:solutionchallenge2024/models/post.dart';
import 'package:solutionchallenge2024/services/firestore.dart';
import 'package:solutionchallenge2024/widgets/box.cnt.post.dart';
import 'package:solutionchallenge2024/widgets/sizebox.dart';
import 'package:solutionchallenge2024/widgets/text.dart';
import 'package:uuid/uuid.dart';

import '../widgets/box.cnt.comment.dart';

class DetailPostScreen extends StatefulWidget {
  const DetailPostScreen({super.key, required this.postModel});
  final PostModel postModel;

  @override
  State<DetailPostScreen> createState() => _DetailPostScreenState();
}

class _DetailPostScreenState extends State<DetailPostScreen> {
  final TextEditingController controller = TextEditingController();
  final List<CommentModel> listComment = [];

  @override
  void initState() {
    super.initState();
    getAllComment();
  }

  getAllComment() async {
    var data =
        await FirestoreService().getAllCommentByPost(widget.postModel.doc);
    listComment.addAll(data);
    setState(() {});
  }

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
                  BoxContentPost(postModel: widget.postModel),
                  ...listComment.map((e) => BoxContentCommentaire(
                        commentModel: e,
                      )),
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
                width: double.infinity,
                decoration: const BoxDecoration(color: Colors.white),
                child: Column(
                  children: [
                    TextField(
                      controller: controller,
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
                        GestureDetector(
                          onTap: () {
                            if (controller.text.trim().isNotEmpty) {
                              var user = FirebaseAuth.instance.currentUser;
                              FirestoreService().createComment(
                                  widget.postModel,
                                  CommentModel(
                                      doc: const Uuid().v1(),
                                      dateComment: DateTime.now(),
                                      comment: controller.text,
                                      user_uid: user!.uid,
                                      user: {
                                        'uid': user.uid,
                                        'name': user.displayName,
                                        'email': user.email,
                                        'urlImg': user.photoURL,
                                      }));
                              controller.text = '';
                            }
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 5),
                            decoration: BoxDecoration(
                                color: Colors.blue,
                                borderRadius: BorderRadius.circular(30)),
                            child: const TextMedium('Reply',
                                color: Colors.white, size: 16),
                          ),
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
