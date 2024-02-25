// ignore_for_file: depend_on_referenced_packages

import 'package:firebase_cached_image/firebase_cached_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:heroicons/heroicons.dart';
import 'package:solutionchallenge2024/logic/state_auth/state_auth_bloc.dart';
import 'package:solutionchallenge2024/maps.dart';
import 'package:solutionchallenge2024/models/post.dart';
import 'package:solutionchallenge2024/screens/detail.post.dart';
import 'package:solutionchallenge2024/services/firestore.dart';
import 'package:solutionchallenge2024/utils/color.dart';
import 'package:solutionchallenge2024/widgets/box.content.action.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'sizebox.dart';
import 'text.dart';

class BoxContentPost extends StatelessWidget {
  const BoxContentPost({
    super.key,
    required this.postModel,
  });
  final PostModel postModel;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => DetailPostScreen(postModel: postModel))),
      child: Container(
        margin: const EdgeInsets.only(bottom: 10),
        decoration: BoxDecoration(
            border: Border(bottom: BorderSide(color: ColorApp.colorGreyApp))),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            width10(),
            CircleAvatar(
              radius: 25,
              backgroundImage: NetworkImage(postModel.user['urlImg']),
            ),
            width10(),
            Expanded(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextMedium(postModel.user['name'], size: 16),
                        TextSmall(
                            DateTime.now()
                                        .difference(postModel.dateCreated)
                                        .inMinutes <=
                                    0
                                ? 'Maintenant'
                                : DateTime.now()
                                            .difference(postModel.dateCreated)
                                            .inMinutes >
                                        59
                                    ? 'il y a ${DateTime.now().difference(postModel.dateCreated).inHours} heure'
                                    : ' il y a ${DateTime.now().difference(postModel.dateCreated).inMinutes} minutes',
                            color: Colors.grey,
                            size: 14),
                      ],
                    )
                  ],
                ),
                height10(),
                postModel.content != ''
                    ? TextSmall(postModel.content)
                    : const SizedBox(),
                height10(),
                StaggeredGrid.count(
                  crossAxisCount: postModel.listImages.length,
                  mainAxisSpacing: 4,
                  crossAxisSpacing: 4,
                  children: [
                    ...postModel.listImages.map(
                      (e) => StaggeredGridTile.count(
                        crossAxisCellCount: 2,
                        mainAxisCellCount: 1,
                        child: Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(0),
                            color: Colors.grey,
                            image: DecorationImage(
                                image: FirebaseImageProvider(FirebaseUrl(e)),
                                fit: BoxFit.cover),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                height10(),
                BlocBuilder<StateAuthBloc, StateAuthState>(
                  builder: (context, state) {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        BoxContentAction(
                            icon: HeroIcons.heart,
                            colorIcon: postModel.usersLikes
                                    .contains(postModel.user['uid'])
                                ? Colors.blue
                                : Colors.grey,
                            nb: postModel.usersLikes.length.toString(),
                            onTap: () {
                              if (state is IsLogin) {
                                FirestoreService().likePost(postModel);
                              }
                            }),
                        BoxContentAction(
                            icon: HeroIcons.chatBubbleLeftRight,
                            colorIcon: postModel.usersComments
                                    .contains(postModel.user['uid'])
                                ? Colors.blue
                                : Colors.grey,
                            nb: postModel.usersComments.length.toString(),
                            onTap: () {}),
                        BoxContentAction(
                            icon: HeroIcons.mapPin,
                            nb: postModel.usersComments.length.toString(),
                            onTap: () {
                              showBottomSheet(
                                  enableDrag: false,
                                  context: context,
                                  builder: (context) => Container(
                                        width: double.infinity,
                                        height:
                                            MediaQuery.sizeOf(context).height *
                                                .8,
                                        decoration: const BoxDecoration(
                                            color: Colors.white,
                                            borderRadius: BorderRadius.only(
                                                topLeft: Radius.circular(30),
                                                topRight: Radius.circular(30))),
                                        child: Column(
                                          children: [
                                            height20(),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  const TextLarge('Localiser '),
                                                  IconButton(
                                                      onPressed: () {
                                                        Navigator.pop(context);
                                                      },
                                                      icon: const Icon(
                                                          Icons.close))
                                                ],
                                              ),
                                            ),
                                            height10(),
                                            Expanded(
                                                child: ViewMaps(
                                              latitude: postModel
                                                  .coordonnees['latitude'],
                                              longitude: postModel
                                                  .coordonnees['longitude'],
                                              isAdd: false,
                                              posPost: LatLng(
                                                postModel
                                                    .coordonnees['latitude'],
                                                postModel
                                                    .coordonnees['longitude'],
                                              ),
                                            )),
                                          ],
                                        ),
                                      ));
                            }),
                        BoxContentAction(
                            icon: HeroIcons.share,
                            nb: postModel.usersShared.length.toString(),
                            onTap: () {}),
                      ],
                    );
                  },
                ),
                height10()
              ],
            )),
            width20()
          ],
        ),
      ),
    );
  }
}
