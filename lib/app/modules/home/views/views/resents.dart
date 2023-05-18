import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../../models/resources_entities.dart';
import '../../controllers/home_controller.dart';

class ResentsPanel extends StatelessWidget {
  const ResentsPanel({Key? key}) : super(key: key);

  Future<void> openDoc(BuildContext context, IndexFile file) async =>
      await launchUrl(Uri.parse(file.id));

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.all(8.0),
        child: GetBuilder<HomeController>(
          builder: (controller) => controller
                  .boxService.recent.getRecents.isNotEmpty
              ? Column(
                  children: [
                    Row(
                      children: [
                        Text(
                          "Recent",
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        const Spacer(),
                        TextButton(
                          onPressed: () async {
                            await controller.boxService.recent.clearRecents();
                            controller.rerender();
                          },
                          child: const Text("Clear"),
                        )
                      ],
                    ),
                    const SizedBox(height: 10),
                    Expanded(
                        child: ListView.builder(
                      padding: const EdgeInsets.only(right: 15),
                      itemCount: controller.boxService.recent.getRecents.length,
                      itemBuilder: (context, index) {
                        final e =
                            controller.boxService.recent.getRecents[index];
                        return ListTile(
                          title: Text(e.name),
                          subtitle: Text(
                            e.path.replaceAll("Resources/", ""),
                            style:
                                Theme.of(context).textTheme.bodySmall!.copyWith(
                                      color: Colors.grey[600],
                                    ),
                          ),
                          onTap: () => openDoc(context, e),
                        );
                      },
                    )),
                  ],
                )
              : const SizedBox(),
        ),
      );
}
