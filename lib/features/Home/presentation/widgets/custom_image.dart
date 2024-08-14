import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class CustomImage extends StatelessWidget {
  const CustomImage({super.key, required this.image});
  final String image;

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
                  imageUrl: "${image}",
                  width: MediaQuery.sizeOf(context).width * 0.2,
                  height: MediaQuery.sizeOf(context).height * 0.15,
                  fit: BoxFit.cover,
                  placeholder: (context, url) =>
                      Center(child: CircularProgressIndicator()),
                  errorWidget: (context, url, error) => Icon(
                    Icons.error,
                    color: Colors.red,
                  ), // Error handling
                );
  }
}