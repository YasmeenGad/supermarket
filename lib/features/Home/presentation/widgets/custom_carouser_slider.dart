import 'package:expandable_page_view/expandable_page_view.dart';
import 'package:flutter/material.dart';
import 'package:supermarket/core/utils/assets.dart';
import 'package:supermarket/features/Home/presentation/widgets/custom_page_view_image.dart';

class ImagePageView extends StatelessWidget {
  const ImagePageView({
    super.key,
    required this.pageController,
  });

  final PageController pageController;

  @override
  Widget build(BuildContext context) {
    return ExpandablePageView(
      controller: pageController,
      scrollDirection: Axis.horizontal,
      children: [
        CustomPageViewImage(
          image: Assets.imagesPageView1,
        ),
        CustomPageViewImage(
          image: Assets.imagesPageView4,
        ),
        CustomPageViewImage(
          image: Assets.imagesPageView3,
        ),
      ],
    );
  }
}
