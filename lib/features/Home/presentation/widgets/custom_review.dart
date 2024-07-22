import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pannable_rating_bar/flutter_pannable_rating_bar.dart';
import 'package:supermarket/core/constants/app_colors.dart';
import 'package:supermarket/core/utils/app_styles.dart';

class CustomReview extends StatelessWidget {
  const CustomReview({super.key, this.rate});
  final rate;

  @override
  Widget build(BuildContext context) {
    return Row(
                  children: [
                    Text(
                      "Review",
                      style: AppStyles.styleSemiBold16(context)
                          .copyWith(color: darkColor),
                    ),
                    Expanded(child: SizedBox()),
                    PannableRatingBar(
                      rate: rate,
                      items: List.generate(
                          5,
                          (index) => const RatingWidget(
                                selectedColor: Color(0xffF3603F),
                                unSelectedColor: Colors.grey,
                                child: Icon(
                                  Icons.star,
                                  size: 20,
                                ),
                              )),
                    ),
                  ],
                );
  }
}