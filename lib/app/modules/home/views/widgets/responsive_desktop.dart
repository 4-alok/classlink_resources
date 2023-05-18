// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:get/get.dart';

// enum ScreenType { mobile, tablet, desktop }

class ResponsiveUIBuilder extends StatelessWidget {
  final Widget Function(ScreenType type) rightChild;
  final Widget Function(ScreenType type) leftChild;
  final Widget Function(ScreenType type) centerChild;

  const ResponsiveUIBuilder(
      {super.key,
      required this.rightChild,
      required this.leftChild,
      required this.centerChild});

  ScreenType get getScreenType => Get.width > 1000.0
      ? ScreenType.Desktop
      : Get.width > 600.0
          ? ScreenType.Tablet
          : ScreenType.Phone;

  @override
  Widget build(BuildContext context) => LayoutBuilder(
        builder: (context, constraints) => Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                color: Colors.transparent,
                child: AnimatedContainer(
                  color: Colors.transparent,
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeInOut,
                  width: constraints.maxWidth > 1000.0 ? 400 : 70,
                  height: double.maxFinite,
                  child: leftChild(getScreenType),
                ),
              ),
              AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeInOut,
                width: constraints.maxWidth > 1000.0 ? 600 : Get.width - 100,
                height: double.maxFinite,
                color: Colors.transparent,
                child: centerChild(getScreenType),
              ),
              AnimatedSize(
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeInOut,
                child: constraints.maxWidth > 1450.0
                    ? Container(
                        width: 400,
                        height: double.maxFinite,
                        color: Colors.transparent,
                        child: rightChild(getScreenType),
                      )
                    : const SizedBox(height: double.maxFinite),
              ),
            ],
          ),
        ),
      );
}
