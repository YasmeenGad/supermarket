import 'package:expandable_page_view/expandable_page_view.dart';
import 'package:flutter/material.dart';
import 'package:supermarket/core/utils/assets.dart';

class ImagePageView extends StatelessWidget {
  const ImagePageView({
    super.key, required this.pageController,
  });
   final PageController pageController;
  @override
  Widget build(BuildContext context) {
    return ExpandablePageView(
         controller: pageController,
        scrollDirection: Axis.horizontal,
        children: List.generate(
          3,
          (index) {
            return AspectRatio(
              aspectRatio: 680 / 215,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  image: DecorationImage(
                      fit: BoxFit.fill,
                      image: AssetImage(Assets.imagesCarouselSliderImage)),
                ),
              ),
            );
          },
        ));
  }
}
