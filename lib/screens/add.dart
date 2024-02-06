import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:solutionchallenge2024/utils/picker_image_plus.dart';
import 'package:solutionchallenge2024/widgets/sizebox.dart';
import 'package:solutionchallenge2024/widgets/text.dart';

class AddPostScreenen extends StatefulWidget {
  const AddPostScreenen({super.key});

  @override
  State<AddPostScreenen> createState() => _AddPostScreenenState();
}

class _AddPostScreenenState extends State<AddPostScreenen> {
  final List<Uint8List> listImages = [];
  @override
  Widget build(BuildContext context) {
    return listImages.isNotEmpty
        ? SafeArea(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  height20(),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      width20(),
                      Column(
                        children: [
                          height10(),
                          const CircleAvatar(
                            backgroundImage:
                                AssetImage('assets/img/default.png'),
                          ),
                        ],
                      ),
                      width10(),
                      Expanded(
                          child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const TextField(
                            maxLines: 5,
                            minLines: 1,
                            decoration: InputDecoration(
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
                                    itemBuilder: (context, index) => Container(
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
                                  icon: const Icon(Icons.location_on_sharp,
                                      color: Colors.blue)),
                              IconButton(
                                  onPressed: () {},
                                  icon: const Icon(Icons.add_a_photo_outlined,
                                      color: Colors.blue)),
                              IconButton(
                                  onPressed: () async {
                                    final Uint8List? img = await PickerImage()
                                        .pickimage(ImageSource.gallery);
                                    if (img != null) {
                                      listImages.add(img);
                                      setState(() {});
                                    }
                                  },
                                  icon: const Icon(
                                      Icons.add_photo_alternate_outlined,
                                      color: Colors.blue)),
                              Expanded(child: Container()),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 6),
                                decoration: BoxDecoration(
                                    color: Colors.blue,
                                    borderRadius: BorderRadius.circular(30)),
                                child: const TextMedium('poster',
                                    size: 14, color: Colors.white),
                              )
                            ],
                          )
                        ],
                      )),
                      width20(),
                    ],
                  )
                ],
              ),
            ),
          )
        : Center(
            child: IconButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) => Dialog(
                      elevation: 0,
                      child: Container(
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10)),
                        height: 200,
                        width: double.infinity,
                        padding: const EdgeInsets.all(30),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const TextLarge('Alerter'),
                            height20(),
                            Row(
                              children: [
                                const Icon(Icons.camera_alt_outlined),
                                width10(),
                                const TextSmall('Camera')
                              ],
                            ),
                            height20(),
                            InkWell(
                              onTap: () async {
                                context.pop();
                                final Uint8List? img = await PickerImage()
                                    .pickimage(ImageSource.gallery);
                                if (img != null) {
                                  listImages.add(img);
                                  setState(() {});
                                }
                              },
                              child: Row(
                                children: [
                                  const Icon(Icons.photo_camera_back_outlined),
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
          );
  }
}
