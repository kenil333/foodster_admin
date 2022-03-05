import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import './../../../domain/all.dart';

class CustomNetworkImage extends StatelessWidget {
  final String image;
  const CustomNetworkImage({Key? key, required this.image}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: image,
      placeholder: (context, url) => const Center(
        child: SpinKitSpinningLines(
          color: primarycol,
          size: 50.0,
        ),
      ),
      errorWidget: (context, url, error) => const Icon(Icons.error),
      fit: BoxFit.fill,
    );
  }
}
