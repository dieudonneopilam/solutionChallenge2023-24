import 'dart:typed_data';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:solutionchallenge2024/logic/add_post/add_post_bloc.dart';
import 'package:solutionchallenge2024/logic/sign_in/sign_in_bloc.dart';
import 'package:solutionchallenge2024/logic/state_auth/state_auth_bloc.dart';
import 'package:solutionchallenge2024/maps.dart';
import 'package:solutionchallenge2024/services/geolocator.dart';
import 'package:solutionchallenge2024/utils/enum.dart';
import 'package:solutionchallenge2024/utils/picker_image_plus.dart';
import 'package:solutionchallenge2024/widgets/login.dart';
import 'package:solutionchallenge2024/widgets/sizebox.dart';
import 'package:solutionchallenge2024/widgets/text.dart';

class AddPostScreenen extends StatefulWidget {
  const AddPostScreenen({super.key});
  @override
  State<AddPostScreenen> createState() => _AddPostScreenenState();
}

class _AddPostScreenenState extends State<AddPostScreenen> {
  final List<Uint8List> listImages = [];
  final TextEditingController contentController = TextEditingController();
  final Map<String, dynamic> coordonnees = {};
  @override
  Widget build(BuildContext context) {
    return listImages.isNotEmpty
        ? BlocBuilder<StateAuthBloc, StateAuthState>(
            builder: (context, state) {
              return SafeArea(
                child: SizedBox(
                  height: MediaQuery.sizeOf(context).height,
                  child: Column(
                    children: [
                      height5(),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          width20(),
                          Column(
                            children: [
                              height10(),
                              CircleAvatar(
                                backgroundImage: NetworkImage(
                                    (state as IsLogin).user.photoURL!),
                              ),
                            ],
                          ),
                          width10(),
                          Expanded(
                              child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              TextField(
                                maxLines: 5,
                                minLines: 1,
                                controller: contentController,
                                decoration: const InputDecoration(
                                    border: InputBorder.none,
                                    hintText: 'Ecrivez ici'),
                              ),
                              Container(
                                height: 200,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    image: DecorationImage(
                                        fit: BoxFit.cover,
                                        image: MemoryImage(listImages[0]))),
                              ),
                              height10(),
                              listImages.length <= 1
                                  ? const SizedBox()
                                  : SizedBox(
                                      height: 50,
                                      width: double.infinity,
                                      child: ListView.builder(
                                        itemCount: listImages.length,
                                        scrollDirection: Axis.horizontal,
                                        itemBuilder: (context, index) =>
                                            Container(
                                          margin: const EdgeInsets.symmetric(
                                              horizontal: 5),
                                          height: 50,
                                          width: 50,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              image: DecorationImage(
                                                  fit: BoxFit.cover,
                                                  image: MemoryImage(
                                                      listImages[index]))),
                                          child: IconButton(
                                              onPressed: () {
                                                listImages.removeAt(index);
                                                setState(() {});
                                              },
                                              icon: const Icon(Icons.delete,
                                                  color: Colors.red)),
                                        ),
                                      ),
                                    ),
                              Row(
                                children: [
                                  IconButton(
                                      onPressed: () {},
                                      icon: const Icon(
                                          Icons.add_location_alt_outlined,
                                          color: Colors.blue)),
                                  IconButton(
                                      onPressed: () async {
                                        if (listImages.length < 4) {
                                          final Uint8List? img =
                                              await PickerImage().pickimage(
                                                  ImageSource.gallery);
                                          if (img != null) {
                                            listImages.add(img);
                                            setState(() {});
                                          }
                                        }
                                      },
                                      icon: Icon(
                                          Icons.add_photo_alternate_outlined,
                                          color: listImages.length > 3
                                              ? Colors.grey
                                              : Colors.blue)),
                                  Expanded(child: Container()),
                                  BlocBuilder<AddPostBloc, AddPostState>(
                                    builder: (context, stateAddPost) {
                                      (stateAddPost as AddPostInitial);
                                      return GestureDetector(
                                        onTap: () => context
                                            .read<AddPostBloc>()
                                            .add(SavePost(
                                                content: contentController.text,
                                                listImages: listImages,
                                                coordonnees: coordonnees,
                                                user: {
                                                  'name' : state.user.displayName,
                                                  'uid': state.user.uid,
                                                  'email': state.user.email,
                                                  'urlImg': state.user.photoURL,
                                                })),
                                        child: Container(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 20, vertical: 6),
                                          decoration: BoxDecoration(
                                              color: Colors.blue,
                                              borderRadius:
                                                  BorderRadius.circular(30)),
                                          child: stateAddPost.etatRequest ==
                                                  EtatRequest.loading
                                              ? const CupertinoActivityIndicator(
                                                  color: Colors.white,
                                                )
                                              : const TextMedium('poster',
                                                  size: 14,
                                                  color: Colors.white),
                                        ),
                                      );
                                    },
                                  )
                                ],
                              )
                            ],
                          )),
                          width20(),
                        ],
                      ),
                      Expanded(
                        child: Container(
                          height: 300,
                          width: double.infinity,
                          margin: const EdgeInsets.only(left: 0, right: 0),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10)),
                          child: ViewMaps(
                              posPost: LatLng(coordonnees['latitude'],
                                  coordonnees['longitude']),
                              latitude: coordonnees['latitude'],
                              longitude: coordonnees['longitude']),
                        ),
                      )
                    ],
                  ),
                ),
              );
            },
          )
        : BlocProvider(
            create: (context) => SignInBloc(),
            child: BlocBuilder<StateAuthBloc, StateAuthState>(
              builder: (context, state) {
                return state is! IsLogin
                    ? const LoginScreen()
                    : SizedBox(
                        height: MediaQuery.sizeOf(context).height,
                        width: MediaQuery.sizeOf(context).width,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            IconButton(
                                onPressed: () {
                                  showDialog(
                                    context: context,
                                    builder: (context) => Dialog(
                                      elevation: 0,
                                      child: Container(
                                        decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                        height: 200,
                                        width: double.infinity,
                                        padding: const EdgeInsets.all(30),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            const TextLarge('Alerter'),
                                            height20(),
                                            Row(
                                              children: [
                                                const Icon(
                                                    Icons.camera_alt_outlined),
                                                width10(),
                                                const TextSmall('Camera')
                                              ],
                                            ),
                                            height20(),
                                            InkWell(
                                              onTap: () async {
                                                context.pop();
                                                final Uint8List? img =
                                                    await PickerImage()
                                                        .pickimage(ImageSource
                                                            .gallery);
                                                if (img != null) {
                                                  listImages.add(img);

                                                  var posi =
                                                      await determinePosition();
                                                  coordonnees.addAll({
                                                    'latitude': posi.latitude,
                                                    'longitude': posi.longitude,
                                                    'altitude': posi.altitude
                                                  });
                                                  setState(() {});
                                                }
                                              },
                                              child: Row(
                                                children: [
                                                  const Icon(Icons
                                                      .photo_camera_back_outlined),
                                                  width10(),
                                                  const TextSmall('Gallerie')
                                                ],
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                                },
                                icon: const Icon(Icons.upload)),
                          ],
                        ),
                      );
              },
            ),
          );
  }
}
