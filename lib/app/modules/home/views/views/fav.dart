// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:classlink_resources/app/modules/home/views/widgets/fav_option.dart';

import '../../../../../models/resources_entities.dart';
import '../../controllers/home_controller.dart';
import '../widgets/hover_builder.dart';

class FavBody extends StatelessWidget {
  final ScreenType screenType;
  const FavBody({Key? key, required this.screenType}) : super(key: key);

  Future<void> openDoc(HomeController controller, IndexFile file) async =>
      await controller.boxService.recent
          .saveRecent(file.toJson())
          .then<void>((_) async => await launchUrl(Uri.parse(file.id)));

  bool get showFavOption => screenType != ScreenType.Desktop;

  @override
  Widget build(BuildContext context) => GetBuilder<HomeController>(
        builder: (controller) => ListView(
          children: [
            showFavOption ? const FavOption() : const SizedBox(),
            Obx(
              () {
                final favs = controller.favController.getFiltedFavs();
                return ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  padding: const EdgeInsets.only(right: 10),
                  itemCount: favs.length,
                  itemBuilder: (context, index) {
                    favs.sort((a, b) => b.date.compareTo(a.date));
                    return Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(0),
                      ),
                      child: HoverBuilder(
                          builder: (context, hover) => ListTile(
                              title: Text(favs[index].file.name),
                              onTap: () =>
                                  openDoc(controller, favs[index].file),
                              subtitle: Text(
                                  favs[index]
                                      .file
                                      .path
                                      .replaceFirst("Resources/", ""),
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodySmall!
                                      .copyWith(color: Colors.grey[600])),
                              trailing: AnimatedOpacity(
                                duration: const Duration(milliseconds: 300),
                                opacity: hover ? 1 : 0,
                                child: IconButton(
                                  onPressed: () async => await controller
                                      .boxService.favBox
                                      .removeFav(favs[index].file.path)
                                      .then<void>((_) => controller.rerender()),
                                  icon: const Icon(Icons.delete),
                                ),
                              ))),
                    );
                  },
                );
              },
            ),
          ],
        ),
      );
}
