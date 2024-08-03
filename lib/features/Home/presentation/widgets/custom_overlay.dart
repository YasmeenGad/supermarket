import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:supermarket/core/utils/app_styles.dart';

class CustomOverlay extends StatefulWidget {
  const CustomOverlay({super.key, required this.showLoading});
  final bool showLoading;

  @override
  State<CustomOverlay> createState() => _CustomOverlayState();
}

class _CustomOverlayState extends State<CustomOverlay> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(16.0),
          child: Container(
            padding: EdgeInsets.all(20.0),
            color: Colors.black.withOpacity(0.6),
            child: widget.showLoading
                ? CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                  )
                : Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.check_circle, color: Colors.green, size: 100),
                      SizedBox(height: 16.0),
                      Text(
                        "Added To Cart Successfully",
                        style: AppStyles.styleSemiBold20(context)
                            .copyWith(color: Colors.white),
                      ),
                    ],
                  ),
          ),
        ),
      ),
    );
  }
}
