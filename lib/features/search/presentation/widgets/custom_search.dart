import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:supermarket/core/constants/app_colors.dart';
import 'package:supermarket/core/utils/app_styles.dart';
import 'package:supermarket/core/utils/assets.dart';

class CustomSearch extends StatefulWidget {
  const CustomSearch({Key? key}) : super(key: key);

  @override
  _CustomSearchState createState() => _CustomSearchState();
}

class _CustomSearchState extends State<CustomSearch> {
  final TextEditingController textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 48, left: 16, right: 16),
      child: Column(
        children: [
          Expanded(
            child: Column(
              children: [
                FittedBox(
                  fit: BoxFit.scaleDown,
                  alignment: Alignment.center,
                  child: Text('Looking for products',
                      style: AppStyles.styleBold20(context)
                          .copyWith(color: darkColor)),
                ),
                SizedBox(
                  height: 16,
                ),
                Container(
                  width: MediaQuery.sizeOf(context).width,
                  height: 51,
                  decoration: BoxDecoration(
                      color: bgTextFieldColor,
                      borderRadius: BorderRadius.circular(16)),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: TextField(
                      controller: textController,
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Search Store',
                          hintStyle: AppStyles.styleSemiBold16(context)
                              .copyWith(color: secondaryColor),
                          prefixIcon: Icon(
                            CupertinoIcons.search,
                            color: darkColor,
                          )),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(flex: 3, child: Image.asset(Assets.imagesSearch))
        ],
      ),
    );
  }
}
