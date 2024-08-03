import 'dart:async';

import 'package:expandable_page_view/expandable_page_view.dart';
import 'package:flutter/material.dart';
import 'package:supermarket/core/utils/assets.dart';
import 'package:supermarket/features/Home/presentation/widgets/custom_page_view_image.dart';

class ImagePageView extends StatefulWidget {
  const ImagePageView({
    super.key,
    required this.pageController,
  });

  final PageController pageController;

  @override
  _ImagePageViewState createState() => _ImagePageViewState();
}

class _ImagePageViewState extends State<ImagePageView> {
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    _startAutoScroll();
  }

  void _startAutoScroll() {
    _timer = Timer.periodic(Duration(seconds: 4), (timer) {
      if (widget.pageController.hasClients) {
        int nextPage = widget.pageController.page!.round() + 1;
        if (nextPage >= 3) {
          nextPage = 0;
        }
        widget.pageController.animateToPage(
          nextPage,
          duration: Duration(milliseconds: 400),
          curve: Curves.fastOutSlowIn,
        );
      }
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    widget.pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ExpandablePageView(
      animationCurve: Curves.slowMiddle,
      controller: widget.pageController,
      scrollDirection: Axis.horizontal,
      children: [
        CustomPageViewImage(
          image: Assets.imagesPageView3,
        ),
        CustomPageViewImage(
          image: Assets.imagesPageView1,
        ),
        CustomPageViewImage(
          image: Assets.imagesPageView4,
        ),
        
      ],
    );
  }
}
