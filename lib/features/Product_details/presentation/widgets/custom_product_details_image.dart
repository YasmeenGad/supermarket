import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class CustomProductDetailsImage extends StatelessWidget {
  const CustomProductDetailsImage({super.key, required this.image});
  final String image;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.sizeOf(context).height * 0.28,
      width: MediaQuery.sizeOf(context).width * 0.8,
      child: Align(
        alignment: Alignment.topCenter,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(25),
          child: CachedNetworkImage(
            imageUrl: "${image}",
            fit: BoxFit.cover,
            placeholder: (context, url) =>
                Center(child: CircularProgressIndicator()),
            errorWidget: (context, url, error) => Center(
              child: Icon(
                Icons.error,
                color: Colors.red,
              ),
            ), // Error handling
          ),
        ),
      ),
    );
  }
}
